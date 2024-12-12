require('dotenv').config();
const express = require('express');
const { Vonage } = require('@vonage/server-sdk');
const cors = require('cors');
const fs = require('fs');

const app = express();
app.use(express.json());
app.use(cors());

const vonage = new Vonage({
  apiKey: process.env.VONAGE_API_KEY,
  apiSecret: process.env.VONAGE_API_SECRET
});

// In-memory OTP storage
const otpStore = new Map();

// Read Aadhar DB
const aadharDB = JSON.parse(fs.readFileSync('./aadharDB.json', 'utf8'));

// Generate 6-digit OTP
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

// get route
app.get('/', (req, res) => {
  res.send('Welcome to Aadhar OTP Verification Server');
});

// Send OTP endpoint
app.post('/api/send-otp', async (req, res) => {
  const { aadharNo } = req.body;
  
  const user = aadharDB.find(user => user['aadhar no'] === aadharNo);
  
  if (!user) {
    return res.status(404).json({ error: 'Aadhar number not found' });
  }

  const otp = generateOTP();
  const phoneNo = user['Phone no'];
  
  try {
    await vonage.sms.send({
      to: `91${phoneNo}`,
      from: "Vonage APIs",
      text: `Your OTP for Aadhar verification is: ${otp}`
    });

    // Store OTP for verification (with 5 min expiry)
    otpStore.set(aadharNo, {
      otp,
      expiry: Date.now() + 5 * 60 * 1000
    });

    // Include OTP in response only in development mode
    const response = { message: 'OTP sent successfully' };
    if (process.env.NODE_ENV !== 'production') {
      response.otp = otp; // Only for testing purposes
    }

    res.json(response);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Failed to send OTP' });
  }
});

// Verify OTP endpoint
app.post('/api/verify-otp', (req, res) => {
  const { aadharNo, otp } = req.body;
  
  const storedData = otpStore.get(aadharNo);
  
  if (!storedData) {
    return res.status(400).json({ error: 'No OTP request found' });
  }
  
  if (Date.now() > storedData.expiry) {
    otpStore.delete(aadharNo);
    return res.status(400).json({ error: 'OTP expired' });
  }
  
  if (storedData.otp !== otp) {
    return res.status(400).json({ error: 'Invalid OTP' });
  }
  
  // Clear OTP after successful verification
  otpStore.delete(aadharNo);
  
  // Return user data on successful verification
  const userData = aadharDB.find(user => user['aadhar no'] === aadharNo);
  res.json({ message: 'Verified successfully', userData });
});

// Send SMS endpoint
app.post('/api/send-sms', async (req, res) => {
  const { phoneNo, message } = req.body;
  
  if (!phoneNo || !message) {
    return res.status(400).json({ 
      error: 'Phone number and message are required' 
    });
  }

  try {
    await vonage.sms.send({
      to: `91${phoneNo}`, // Assuming Indian numbers with 91 prefix
      from: "Vonage APIs",
      text: message
    });

    res.json({ 
      message: 'SMS sent successfully',
      // Include message in response only in development mode
      ...(process.env.NODE_ENV !== 'production' && { 
        sentMessage: message 
      })
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ 
      error: 'Failed to send SMS',
      details: process.env.NODE_ENV !== 'production' ? error.message : undefined
    });
  }
});

// Make otpStore accessible for testing
global.otpStore = otpStore;

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 
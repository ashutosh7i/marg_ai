const User = require('../models/userModel');
const OTP = require('../models/otpModel');
const { sendOTPEmail } = require('../utils/emailService');
const { v4: uuidv4 } = require('uuid');
const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');

// Generate OTP
const generateOTP = () => {
  return Math.floor(100000 + Math.random() * 900000).toString();
};

// Send OTP
const sendOTP = async (req, res) => {
  try {
    const { email, purpose } = req.body;

    // Find user
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Generate new OTP
    const otp = generateOTP();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

    // Hash OTP before saving
    const salt = await bcrypt.genSalt(10);
    const hashedOTP = await bcrypt.hash(otp, salt);

    // Save OTP record
    await OTP.create({
      userId: user.id,
      otp: hashedOTP,
      purpose,
      expiresAt
    });

    // Send OTP email
    const emailSent = await sendOTPEmail(email, otp);
    if (!emailSent) {
      return res.status(500).json({ message: 'Error sending OTP email' });
    }

    res.json({
      message: 'OTP sent successfully',
      expiresAt
    });
  } catch (error) {
    console.error('Error in sendOTP:', error);
    res.status(500).json({ message: 'Error sending OTP', error: error.message });
  }
};

// Verify OTP
const verifyOTP = async (req, res) => {
  try {
    const { email, otp, purpose } = req.body;

    // Find user
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Find latest unused OTP for this user and purpose
    const otpRecord = await OTP.findOne({
      where: {
        userId: user.id,
        purpose,
        isUsed: false,
        expiresAt: { [Op.gt]: new Date() }
      },
      order: [['createdAt', 'DESC']]
    });

    if (!otpRecord) {
      return res.status(400).json({ message: 'Invalid or expired OTP' });
    }

    // Verify OTP
    const isValid = await bcrypt.compare(otp, otpRecord.otp);
    if (!isValid) {
      return res.status(400).json({ message: 'Invalid OTP' });
    }

    // Mark OTP as used
    otpRecord.isUsed = true;
    await otpRecord.save();

    // Generate verification token
    const verificationToken = uuidv4();

    res.json({
      message: 'OTP verified successfully',
      verificationToken
    });
  } catch (error) {
    console.error('Error in verifyOTP:', error);
    res.status(500).json({ message: 'Error verifying OTP', error: error.message });
  }
};

module.exports = {
  sendOTP,
  verifyOTP
}; 
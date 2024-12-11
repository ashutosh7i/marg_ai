const axios = require('axios');

async function testAadharOTP() {
  try {
    // Test with a valid Aadhar number from DB
    const aadharNo = "618018270812";
    
    // Request OTP
    console.log('Requesting OTP...');
    const otpResponse = await axios.post('http://localhost:3000/api/send-otp', {
      aadharNo
    });
    console.log('OTP Response:', otpResponse.data);
    
    // Get OTP from response (only available in development mode)
    const otp = otpResponse.data.otp;
    if (!otp) {
      throw new Error('OTP not found in response. Make sure NODE_ENV is not production');
    }
    
    console.log('\nReceived OTP:', otp);
    
    // Verify OTP
    console.log('\nVerifying OTP...');
    const verifyResponse = await axios.post('http://localhost:3000/api/verify-otp', {
      aadharNo,
      otp
    });
    console.log('Verify Response:', verifyResponse.data);
    
  } catch (error) {
    console.error('Error:', error.response?.data || error.message);
  }
}

testAadharOTP(); 
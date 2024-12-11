const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');
const User = require('../models/userModel');
const LoginHistory = require('../models/loginHistoryModel');
const { sendOTPEmail } = require('../utils/emailService');
const { v4: uuidv4 } = require('uuid');

// Generate JWT token
const generateToken = (id) => {
  return jwt.sign({ id }, process.env.JWT_SECRET, {
    expiresIn: '1h'
  });
};

// Signup controller
const signup = async (req, res) => {
  try {
    console.log('Signup process initiated');
    const { username, email, password } = req.body;
    console.log(`Received signup request for username: ${username}, email: ${email}`);

    // Check if user already exists
    console.log('Checking if user already exists in the database');
    const existingUser = await User.findOne({
      where: {
        [Op.or]: [{ email }, { username }]
      }
    });

    if (existingUser) {
      console.log(`User with email ${email} or username ${username} already exists`);
      return res.status(400).json({
        message: 'User with this email or username already exists'
      });
    }

    console.log('No existing user found, proceeding with user creation');

    // Create new user
    console.log('Creating new user in the database');
    const user = await User.create({
      username,
      email,
      password
    });
    console.log(`New user created with ID: ${user.id}`);

    // Generate token
    console.log('Generating JWT token for the new user');
    const token = generateToken(user.id);
    console.log('JWT token generated successfully');

    console.log('Sending successful response');
    res.status(201).json({
      message: 'User created successfully',
      token,
      user: {
        id: user.id,
        username: user.username,
        email: user.email
      }
    });
    console.log('Signup process completed successfully');
  } catch (error) {
    console.error('Error occurred during signup process:', error);
    res.status(500).json({ message: 'Error creating user', error: error.message });
  }
};

// Login controller
const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find user
    const user = await User.findOne({ where: { email } });
    if (!user) {
      // Log failed login attempt
      await LoginHistory.create({
        userId: null,
        status: 'failed',
        ipAddress: req.ip,
        deviceInfo: req.headers['user-agent']
      });
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Validate password
    const isValidPassword = await user.validatePassword(password);
    if (!isValidPassword) {
      // Log failed login attempt
      await LoginHistory.create({
        userId: user.id,
        status: 'failed',
        ipAddress: req.ip,
        deviceInfo: req.headers['user-agent']
      });
      return res.status(401).json({ message: 'Invalid credentials' });
    }

    // Log successful login
    await LoginHistory.create({
      userId: user.id,
      status: 'success',
      ipAddress: req.ip,
      deviceInfo: req.headers['user-agent']
    });

    // Generate token
    const token = generateToken(user.id);

    res.json({
      message: 'Login successful',
      token,
      user: {
        id: user.id,
        username: user.username,
        email: user.email
      }
    });
  } catch (error) {
    console.error('Error in login:', error);
    res.status(500).json({ message: 'Error logging in', error: error.message });
  }
};

// Request password reset
const requestPasswordReset = async (req, res) => {
  try {
    const { email } = req.body;
    const user = await User.findOne({ where: { email } });

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    // Generate OTP
    const otp = Math.floor(100000 + Math.random() * 900000).toString();
    const resetToken = uuidv4();

    // Save reset token and expiry
    user.resetPasswordToken = resetToken;
    user.resetPasswordExpires = Date.now() + 600000; // 10 minutes
    await user.save();

    // Send OTP email
    const emailSent = await sendOTPEmail(email, otp);
    if (!emailSent) {
      return res.status(500).json({ message: 'Error sending OTP email' });
    }

    res.json({
      message: 'OTP sent successfully',
      resetToken
    });
  } catch (error) {
    res.status(500).json({ message: 'Error requesting password reset', error: error.message });
  }
};

// Reset password
const resetPassword = async (req, res) => {
  try {
    const { resetToken, newPassword } = req.body;
    
    const user = await User.findOne({
      where: {
        resetPasswordToken: resetToken,
        resetPasswordExpires: { [Op.gt]: Date.now() }
      }
    });

    if (!user) {
      return res.status(400).json({ message: 'Invalid or expired reset token' });
    }

    // Update password
    user.password = newPassword;
    user.resetPasswordToken = null;
    user.resetPasswordExpires = null;
    await user.save();

    res.json({ message: 'Password reset successful' });
  } catch (error) {
    res.status(500).json({ message: 'Error resetting password', error: error.message });
  }
};

module.exports = {
  signup,
  login,
  requestPasswordReset,
  resetPassword
}; 
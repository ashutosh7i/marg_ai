const User = require('../models/userModel');
const multer = require('multer');
const path = require('path');

// Configure multer for file upload
const storage = multer.diskStorage({
  destination: './uploads/profile',
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  }
});

const upload = multer({
  storage,
  limits: { fileSize: 1024 * 1024 * 5 }, // 5MB limit
  fileFilter: (req, file, cb) => {
    const filetypes = /jpeg|jpg|png/;
    const mimetype = filetypes.test(file.mimetype);
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());

    if (mimetype && extname) {
      return cb(null, true);
    }
    cb(new Error('Only .png, .jpg and .jpeg format allowed!'));
  }
}).single('profilePicture');

// Get user profile
const getProfile = async (req, res) => {
  try {
    const user = await User.findByPk(req.user.id, {
      attributes: { exclude: ['password', 'resetPasswordToken', 'resetPasswordExpires'] }
    });

    // Add base URL to profile picture URL if it exists
    if (user.profilePictureUrl) {
      user.profilePictureUrl = `${req.protocol}://${req.get('host')}${user.profilePictureUrl}`;
    }

    res.json(user);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching profile', error: error.message });
  }
};

// Update user profile
const updateProfile = async (req, res) => {
  try {
    const { username, name, bio, class: userClass } = req.body;
    const user = await User.findByPk(req.user.id);

    if (username) {
      const existingUser = await User.findOne({ where: { username } });
      if (existingUser && existingUser.id !== user.id) {
        return res.status(400).json({ message: 'Username already taken' });
      }
      user.username = username;
    }

    if (name) user.name = name;
    if (bio) user.bio = bio;
    if (userClass) user.class = userClass;

    await user.save();

    // Add base URL to profile picture URL if it exists
    if (user.profilePictureUrl) {
      user.profilePictureUrl = `${req.protocol}://${req.get('host')}${user.profilePictureUrl}`;
    }

    res.json({
      message: 'Profile updated successfully',
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        name: user.name,
        bio: user.bio,
        class: user.class,
        profilePictureUrl: user.profilePictureUrl
      }
    });
  } catch (error) {
    res.status(500).json({ message: 'Error updating profile', error: error.message });
  }
};

// Upload profile picture
const uploadProfilePicture = (req, res) => {
  upload(req, res, async (err) => {
    if (err) {
      return res.status(400).json({ message: err.message });
    }

    if (!req.file) {
      return res.status(400).json({ message: 'Please upload a file' });
    }

    try {
      const user = await User.findByPk(req.user.id);
      const profilePictureUrl = `/uploads/profile/${req.file.filename}`;
      user.profilePictureUrl = profilePictureUrl;
      await user.save();

      res.json({
        message: 'Profile picture uploaded successfully',
        profilePictureUrl: `${req.protocol}://${req.get('host')}${profilePictureUrl}`
      });
    } catch (error) {
      res.status(500).json({ message: 'Error uploading profile picture', error: error.message });
    }
  });
};

module.exports = {
  getProfile,
  updateProfile,
  uploadProfilePicture
}; 
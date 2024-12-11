const express = require('express');
const router = express.Router();
const auth = require('../middlewares/authMiddleware');
const {
  getProfile,
  updateProfile,
  uploadProfilePicture
} = require('../controllers/userController');

router.get('/profile', auth, getProfile);
router.put('/profile', auth, updateProfile);
router.post('/profile/picture', auth, uploadProfilePicture);

module.exports = router; 
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');
const authRoutes = require('./routes/authRoutes');
const userRoutes = require('./routes/userRoutes');
const otpRoutes = require('./routes/otpRoutes');
const { sequelize } = require('./models/db');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// temporary dir in place of bucket
// Create uploads directory if it doesn't exist
const uploadsDir = path.join(__dirname, '../uploads');
const profileUploadsDir = path.join(uploadsDir, 'profile');
if (!require('fs').existsSync(uploadsDir)){
  require('fs').mkdirSync(uploadsDir);
}
if (!require('fs').existsSync(profileUploadsDir)){
  require('fs').mkdirSync(profileUploadsDir);
}

// Serve static files from uploads directory
app.use('/uploads', express.static(path.join(__dirname, '../uploads')));

// Routes
// test route
app.get('/', (req, res) => {
  res.json({ message: 'Welcome to the API' });
});

// basic auth route
app.use('/api/auth', authRoutes);
// user routes
app.use('/api/user', userRoutes);
// otp routes
app.use('/api/otp', otpRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: 'Something went wrong!' });
});

const PORT = process.env.PORT || 3000;

// Database connection and server start
sequelize.sync()
  .then(() => {
    console.log('Database connected successfully');
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  }); 
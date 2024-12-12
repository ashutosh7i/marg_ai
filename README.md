# Marg AI - Inclusive Assessment Platform

Marg AI is an innovative AI-powered assessment platform designed to make education more accessible and inclusive. Built as a solution for SIH 1777, it addresses the need for comprehensive assessment tools in India's skill ecosystem.

## 🎯 Core Features

### Web Platform (react.js)

#### Teacher Dashboard
- Create and manage assessments (MCQ, descriptive, practical)
- Real-time monitoring of student progress
- Resource management and material uploads
- Advanced analytics and performance tracking
- Multi-language support (11+ Indian languages)

#### Analytics Module
- Class-wise performance analysis
- Assessment-wise result tracking
- Student-wise progress monitoring
- Visual data representation (bar charts, line charts, area charts)

### Mobile Application (Flutter)

#### Student Features
- Secure Aadhar-based authentication
- Offline assessment capabilities
- Auto-save functionality
- Accessibility features:
  - Text-to-speech
  - Speech-to-text
  - High contrast modes
  - Font size adjustment
  - Screen reader support=

#### Assessment Types
- Multiple Choice Questions (MCQ)
- Descriptive Questions
- Practical Assessments
- Viva Voce Examinations

## 🛠️ Technical Architecture

### Backend Services
- Main API: `20.197.18.36:5000`
- Aadhar API: `20.197.18.36:8000`
  - OTP-based verification
  - Secure authentication

### AI Integration
- Powered by LangFlow
- HuggingFace models integration
- ChatGPT capabilities
- Automated question generation
- Answer evaluation

### Security Features
- End-to-end encryption
- Secure file storage
- Anti-cheating measures
- Session management
- Offline authentication using hashing + SQLite

## 🌐 Language Support
- Hindi (हिंदी)
- Malayalam (മലയാളം)
- Tamil (தமிழ்)
- Telugu (తెలుగు)
- Gujarati (ગુજરાતી)
- Bengali (বাংলা)
- Marathi (मराठी)
- Assamese (অসমীয়া)

## 🎨 Accessibility Features
- PWD (Persons with Disabilities) support
- Voice command navigation
- Screen reader optimization
- Customizable UI elements
- Multi-modal input support

## 📱 Mobile App Features
- Offline functionality
- Auto-sync when online
- Progress tracking
- Resource downloads
- Performance analytics

## 🔒 Security Measures
- Role-based access control
- Secure file handling
- Anti-tampering mechanisms
- Session monitoring
- Data encryption

## 🎯 Target Users
- Educational Institutions
- Vocational Training Centers
- Skill Development Programs
- Students (including PWD)
- Teachers and Administrators

## 💡 Future Enhancements
- Advanced AI analytics
- Enhanced offline capabilities
- Additional language support
- Expanded accessibility features
- Performance optimizations

## 🚀 Deployment
- Azure VM hosting
- Scalable architecture
- Load balancing
- Automated backups

## 📊 Impact
- Standardized assessment delivery
- Inclusive education support
- Real-time performance tracking
- Data-driven insights
- Accessible skill evaluation

---

## 🛠️ Setup Instructions

### Backend Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/margai_flutter.git
   cd margai_flutter/backend
   ```

2. **Install Dependencies**
   Ensure you have [Node.js](https://nodejs.org/) installed, then run:
   ```bash
   npm install
   ```

3. **Configure Environment Variables**
   Create a `.env` file in the root of the backend directory and add the following:
   ```
   PORT=5000
   DATABASE_URL=your_database_url
   JWT_SECRET=your_jwt_secret
   ```

4. **Run the Server**
   Start the backend server:
   ```bash
   npm start
   ```

### Flutter Setup

1. **Install Flutter**
   Follow the instructions on the [Flutter website](https://flutter.dev/docs/get-started/install) to install Flutter.

2. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/margai_flutter.git
   cd margai_flutter
   ```

3. **Install Dependencies**
   Run the following command to get the required packages:
   ```bash
   flutter pub get
   ```

4. **Run the App**
   Use the following command to run the Flutter application:
   ```bash
   flutter run
   ```

### React Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/margai_flutter.git
   cd margai_flutter/web
   ```

2. **Install Dependencies**
   Ensure you have [Node.js](https://nodejs.org/) installed, then run:
   ```bash
   npm install
   ```

3. **Run the React App**
   Start the React application:
   ```bash
   npm start
   ```

### Additional Notes
- Ensure that the backend server is running before starting the Flutter or React applications.
- For any issues, refer to the respective documentation for Flutter and React.

---

Built with ❤️ for Smart India Hackathon 2024
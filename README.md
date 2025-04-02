# Alenlachu - Mental Health & Wellness Mobile Application

## 🌿 Overview
Alenlachu is a mobile application designed to support mental health and emotional well-being through interactive tools, professional connections, and AI-driven assistance. Built with **Flutter** (frontend) and **Node.js** (backend), Alenlachu delivers a seamless and engaging experience for users seeking mental wellness support.

## ✨ Key Features
- **Multi-Role System**: Support for Users, Mental Health Professionals, Institutions, and Admins.
- **AI-Powered Chatbot**: Intelligent assistant for instant support and mental health guidance.
- **Journaling & Venting**: Secure personal journaling to express emotions and track progress.
- **Professional Support**: Direct connection with licensed mental health professionals.
- **Awareness & Events**: Access educational content, mental health resources, and upcoming events.
- **Daily Challenge System**: Engage with personalized mental wellness challenges to improve emotional resilience.

## 🛠️ Tech Stack
### **Frontend:**
- **Flutter** – Cross-platform UI development framework.
- **Dart** – Primary programming language for Flutter applications.

### **Backend:**
- **Node.js** – JavaScript runtime for scalable backend development.
- **Express.js** – Lightweight and flexible web framework.
- **MongoDB** – NoSQL database for efficient data storage.
- **Socket.IO** – Real-time communication for chat and support interactions.

---

## 🚀 Installation Guide
Follow these steps to set up and run Alenlachu on your local environment:

### ✅ Prerequisites
Ensure you have the following installed:
- **Flutter** (>= 3.4.3)
- **Node.js** (>= 16.x)
- **MongoDB** (local or cloud instance)
- **Visual Studio Code** or your preferred code editor

### 🏗 Backend Setup
1. Navigate to the backend directory:
   ```sh
   cd Alenlachu-Version-2/Backend
   ```
2. Install dependencies:
   ```sh
   npm install
   ```
3. Create a `.env` file in the `Backend` directory and configure the following:
   ```env
   MONGO_URL=your_mongodb_connection_string
   PORT=3001
   ```
4. Start the backend server:
   ```sh
   npm start
   ```

### 🎨 Frontend Setup
1. Navigate to the app directory:
   ```sh
   cd Alenlachu-Version-2/app
   ```
2. Install Flutter dependencies:
   ```sh
   flutter pub get
   ```
3. Run the app on an emulator or a connected device:
   ```sh
   flutter run
   ```

---

## 📁 Project Structure
```
Alenlachu/
├── app/
│   ├── android/
│   ├── ios/
│   ├── macos/
│   ├── linux/
│   └── windows/
├── lib/
│   ├── controllers/
│   ├── models/
│   ├── screens/
│   ├── services/
│   └── main.dart
├── assets/
│   ├── images/
│   └── fonts/
├── test/
└── pubspec.yaml
```

---

## 🌟 Daily Challenge System
The **Daily Challenge System** encourages users to engage in mental wellness activities tailored to their preferences. Users can track progress, revisit past challenges, and maintain streaks for consistent participation.

### 📌 Feature Flow
1. **Admin Adds Challenges** → Challenges are created with categories and difficulty levels.
2. **User Selects Preferences** → Users choose preferred challenge categories and difficulty.
3. **Daily Challenge Assignment** → Backend assigns a daily challenge based on preferences.
4. **User Progress Tracking** → Users can mark challenges as "Completed", "In Progress", or "Skipped".
5. **Challenge History & Streaks** → Users view past challenges and maintain streaks.

### 🛠 Responsibilities
#### **Frontend (Flutter)**
- Design user interface for selecting challenge preferences.
- Implement daily challenge display with tracking functionality.
- Display challenge streak progress visually.
- Integrate with backend APIs for fetching and updating challenge data.

#### **Backend (Node.js + MongoDB)**
- **Admin Panel**: Create and manage challenges.
- **User Preference Management**: Store and retrieve user preferences.
- **Challenge Assignment**: Assign personalized challenges daily.
- **Challenge Tracking**: Store user challenge progress.
- **Streak System**: Track and return challenge completion streaks.

### 🔗 API Endpoints
| Feature | Method | Endpoint | Description |
|---------|--------|------------|-------------|
| **Admin: Add Challenge** | POST | `/api/admin/challenges` | Admin creates challenges with category & difficulty. |
| **User: Set Preferences** | POST | `/api/user/preferences` | Users set preferred challenge categories & difficulty. |
| **User: Get Daily Challenge** | GET | `/api/challenges/daily` | Retrieves a challenge based on user preferences. |
| **User: Mark Challenge as Completed** | POST | `/api/challenges/complete` | Marks a challenge as "Completed". |
| **User: Skip Challenge** | POST | `/api/challenges/skip` | Marks a challenge as "Skipped". |
| **User: View Challenge History** | GET | `/api/challenges/history` | Fetches user challenge history. |
| **User: Get Streak Info** | GET | `/api/challenges/streak` | Retrieves user's current challenge streak. |

---

## 📌 Additional Considerations
- **Security & Privacy**: Ensure secure storage of user preferences and challenge data.
- **Performance Optimization**: Optimize database queries for efficient challenge retrieval.
- **User Engagement**: Integrate notifications and motivational UI elements to encourage participation.

---

## 🎉 Get Started
Clone the repository, follow the setup guide, and explore Alenlachu. Together, we can make mental health support more accessible and engaging. 💙

## 🤝 Contributions & Feedback
We welcome contributions! Feel free to submit issues, suggest features, or contribute code to improve the platform.


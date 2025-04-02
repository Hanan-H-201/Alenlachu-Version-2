# 🌿 Alenlachu - Mental Health Mobile App

Welcome to **Alenlachu**, a mobile application designed to provide mental health support, resources, and interactive tools to enhance emotional well-being. Built with **Flutter** (frontend) and **Node.js** (backend), Alenlachu ensures a seamless, engaging, and supportive user experience.

---

## 🌟 Overview

Alenlachu is a mental health platform that connects users with professionals, raises awareness, and offers tools to help users navigate their emotional journey. Whether you're looking for professional guidance or a safe space to express yourself, **Alenlachu** is here for you.

### ✨ Key Features:
- **Multi-Role System**: Users, Professionals, Institutions, and Admins.
- **AI-Powered Chatbot**: Get instant support through an intelligent AI assistant.
- **Journaling & Venting**: Maintain a personal journal and freely express emotions.
- **Professional Support**: Connect with verified mental health professionals.
- **Awareness & Events**: Access educational resources, articles, and upcoming events.

---

## 🛠️ Tech Stack

### **Frontend:**
- **Flutter** – Cross-platform UI development framework.
- **Dart** – The programming language powering Flutter apps.

### **Backend:**
- **Node.js** – JavaScript runtime for server-side development.
- **Express.js** – Lightweight and flexible web framework.
- **MongoDB** – NoSQL database for efficient data storage.
- **Socket.IO** – Enables real-time chat functionality.

---

## 🚀 Installation Guide

Follow these steps to set up and run **Alenlachu** on your local machine:

### ✅ Prerequisites
Ensure you have the following installed:
1. [Flutter](https://docs.flutter.dev/get-started/install) (>= 3.4.3)
2. [Node.js](https://nodejs.org/) (>= 16.x)
3. [MongoDB](https://www.mongodb.com/try/download/community) (local or cloud instance)
4. [Visual Studio Code](https://code.visualstudio.com/) or your preferred editor

### 🏗 Backend Setup
1. Navigate to the backend directory:
   ```bash
   cd Alenlachu-Version-2/Backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file in the `Backend` directory and add:
   ```plaintext
   MONGO_URL=your_mongodb_connection_string
   PORT=3001
   ```
4. Start the backend server:
   ```bash
   npm start
   ```

### 🎨 Frontend Setup
1. Navigate to the app directory:
   ```bash
   cd Alenlachu-Version-2/app
   ```
2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app on an emulator or connected device:
   ```bash
   flutter run
   ```

---

## 📁 Project Structure

### **Backend:**
- `routes/` – API endpoints (authentication, chat, etc.)
- `models/` – MongoDB schemas for structured data storage
- `controllers/` – Business logic for handling requests
- `utils/` – Helper functions and utilities

### **Frontend:**
- `lib/` – Main Flutter application code
- `screens/` – UI screens for various features and user roles
- `widgets/` – Reusable UI components
- `services/` – API calls and application logic
- `core/` – App-wide utilities like theming and localization

---

## 🎉 Get Started

Clone the repository, follow the setup guide, and start exploring **Alenlachu**. Let's make mental health support accessible for everyone. 💙

---

💡 *Contributions & feedback are welcome! Feel free to report issues, suggest features, or contribute to the project.*


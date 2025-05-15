🌿 Alenlachu – Mental Health & Emotional Support Platform Alenlachu is a Mobile app platform designed to support communities with emotional well-being by providing mental health awareness, and daily challenges.

🚀 Features 🔐 OTP-based Authentication (Planned)

😌 Mood Tracker Log daily emotions, intensity, tags, and notes.

📦 Tech Stack Backend: Node.js, Express.js, MongoDB, Mongoose

Frontend: Flutter, Dart

📁 Folder Structure (Backend)

├── controllers/
│ ├── mood.controllers.js
│ ├── challenge.controller.js
│ └── ...
├── middleware/
│ └── fakeUser.js # Temporary development middleware
├── models/
│ ├── mood.model.js
│ ├── blackList.model.js
│ └── ...
├── routes/
│ ├── mood.routes.js
│ ├── challenge.routes.js
│ └── ...
├── config/
│ └── db.js # MongoDB connection
├── socketHandler.js # Socket.io logic
└── server.js # App entry point
🧪 Development Mode Notes

-fakeUser middleware is used for testing and development to simulate a logged-in user.

-Real authentication using OTP will be integrated later — remove fakeUser before production.

📜 API Overview Mood Endpoints POST /api/mood/ – Log a new mood

GET /api/mood/ – Retrieve all moods

GET /api/mood/stats – Aggregated stats per user

Daily Challenge GET /api/mood/challenge/ – Get the daily mental health challenge
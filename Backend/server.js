import express from 'express';
import http from 'http';
import { Server } from 'socket.io';
import cors from 'cors';
import './config/db.js';
import adminRoutes from "./routes/admin.routes.js";
import clientRoutes from "./routes/client.routes.js";
import institutionRoutes from "./routes/institution.routes.js";
import professionRoutes from "./routes/profession.routes.js";
import authRoutes from './routes/auth.routes.js';
import eventRoutes from "./routes/event.routes.js";
import awarenessRoutes from './routes/awareness.routes.js';
import chatbotRoutes from './routes/chat.routes.js';
import realtimechatRoutes from './routes/realtimechat.routes.js';
import challengeRoutes from './routes/challenge.routes.js'; 
import bodyParser from 'body-parser';
import socketHandler from './socketHandler.js';

const port = process.env.PORT || 3001;

const app = express();
app.use(cors());
app.use(bodyParser.json());

const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*",
        methods: ["GET", "POST"]
    },
});

// Routes
app.use("/api/admins", adminRoutes);
app.use("/api/institutions", institutionRoutes);
app.use("/api/professions", professionRoutes);
app.use("/api/clients", clientRoutes);
app.use("/api", authRoutes);
app.use("/api/events", eventRoutes);
app.use("/api/awarenesses", awarenessRoutes);
app.use("/api/chat", chatbotRoutes);
app.use("/api/realtimechat", realtimechatRoutes);
app.use("/api/mood/challenge", challengeRoutes); 

// Socket
socketHandler(io);

server.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

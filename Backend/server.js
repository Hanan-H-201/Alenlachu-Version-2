const bodyParser = require("body-parser");
const express = require("express");
const dotenv = require('dotenv').config();
const db = require("./config/db");
const adminRoutes = require("./routes/admin.routes");
const clientRoutes = require("./routes/client.routes");
const institutionRoutes = require("./routes/institution.routes");
const professionRoutes = require("./routes/profession.routes");
const authRoutes = require('./routes/auth.routes');
const eventRoutes = require("./routes/event.routes");
const awarenessRoutes = require('./routes/awareness.routes');

const port = process.env.PORT || 3000;
const app = express();

app.use(bodyParser.json());

app.use("/api/admins", adminRoutes);
app.use("/api/clients", clientRoutes);
app.use("/api/institutions", institutionRoutes);
app.use("/api/professions", professionRoutes);
app.use("/api", authRoutes);
app.use("/api/events", eventRoutes);
app.use("/api/awarenesses", awarenessRoutes);

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
  });

 
app.listen(port, ()=>{
    console.log(`Server is running on port ${port}`)
});
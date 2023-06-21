const express = require("express");
const mongoose = require('mongoose');
//IMPPORTS FROM OTHER FILES
const authRouter = require('./routes/auth');
const e = require("express");

// INIT
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://sabricakmakci:M.1975.1975m@cluster0.6vntrgz.mongodb.net/?retryWrites=true&w=majority"

// midleware
app.use(express.json());
app.use(authRouter);

// Connections
mongoose
.connect(DB)
.then(() => {
  console.log('Connection Succesfully');
})
.catch(e => {
  console.log(e);
});


app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT} `); 
});
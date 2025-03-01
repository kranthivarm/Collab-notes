const express = require('express');

const authController = require("../controllers/auth.controller");
const formatData = require('../middlewares/formatData.middleware');

const authRouter = express.Router()

authRouter.post("/login", formatData, authController.loginUser)
authRouter.post("/register", formatData, authController.registerUser)

module.exports = authRouter
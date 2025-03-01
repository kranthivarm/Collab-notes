const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken")
require("dotenv").config()

const User = require("../models/user.model");

const loginUser = async (req,res) => {
    try{
        const { username, password } = req.body;
        const user = await User.findOne({ 
            $or: [
                { username: username },
                { email: username }
            ]
         })
        if(user){
            const isValidPassword = await bcrypt.compare(password, user.password)
            if(isValidPassword){
                const token = jwt.sign(
                    {
                        _id: user._id,
                        username: user.username,
                        email: user.email,
                    },
                    process.env.JWT_SECRET,
                    {
                        expiresIn: 15 * 24 * 60 * 60        // 15 days
                    }
                )
                res.cookie(
                    "token",
                    token,
                    {
                        maxAge: 15 * 24 * 60 * 60 * 1000,    // 15 days
                        httpOnly: true,
                        sameSite: "None",
                        secure: false
                    }
                )
                return res.status(200).json({
                    "message": "Login successful",
                    "_id": user._id,
                    "username": user.username,
                    "email": user.email,
                    "token": token
                })
            }
            else{
                return res.status(403).json({"message": "Invalid password"})
            }
        }
        return res.status(401).json({"message": "User doesnot exist"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const registerUser = async (req,res) => {
    try{
        const { username, email, password } = req.body
        const hashedPassword = await bcrypt.hash(password, 13)
        const user = new User({ username, email, password: hashedPassword })
        await user.save()
        return res.status(201).json({"message": "User created successfully"})
    }
    catch(e){
        // console.log(e)
        if(e['errorResponse']['code']===11000){
            return res.status(409).json({"message": "User with same name or email already exist"})
        }
        return res.status(500).json({"message": "Internal server error"})
    }
}

module.exports = { loginUser, registerUser }

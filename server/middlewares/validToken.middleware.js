const jwt = require("jsonwebtoken")

const validToken = (req,res,next) => {
    try{
        const token = req.body.token || req.params.token || req.cookies.token
        jwt.verify(token,process.env.JWT_SECRET,(err,decoded)=>{
            if(err){
                return res.status(400).json({"message": "Invalid token"})
            }
            req.user = decoded
            next()
        })
    }
    catch(e){
        console.log(e)
        return res.status(500).json({"message": "Internal server error"})
    }
}

module.exports = validToken
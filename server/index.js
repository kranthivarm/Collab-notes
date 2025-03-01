const express = require('express')
const cors = require('cors')
const cookieParser = require("cookie-parser")

const connectToDB = require('./config/connectToDB')
const router = require("./routes/mainRouter")

const app = express()

app.use(express.json())
app.use(cookieParser())

app.use(cors(
    {
        origin: (origin, callback) => {
            callback(null, true)
        },
        credentials: true
    }
))

app.use("/api",router)

const port = process.env.PORT || 5000
app.listen(port,() => {
    console.log(`Server is running on port ${port}`)
    connectToDB()

    setInterval(()=>{
        fetch(process.env.SERVER_URL)
    },840000)
    
})

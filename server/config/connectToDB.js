const mongoose = require("mongoose")
require("dotenv").config()

const connectToDB = async () => {
    try{
        await mongoose.connect(process.env.MONGO_DB_URL)
        console.log("DB Connected")
    }
    catch(e){
        console.log(`Error connecting to DB: ${e}`)
    }
}

module.exports = connectToDB
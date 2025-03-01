const mongoose = require('mongoose');

const noteSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true
    },
    content: {
        type: String,
        required: true
    },
    createdBy: {
        type: mongoose.Types.ObjectId,
        ref: "users"
    }
} , { timestamps: true })

const Note = mongoose.model("notes",noteSchema)

module.exports = Note
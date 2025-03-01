const mongoose = require('mongoose');

const accessControlSchema = new mongoose.Schema({
    ownerId: {
        type: mongoose.Types.ObjectId,
        ref: "users",
        required: true
    },
    userId: {
        type: mongoose.Types.ObjectId,
        ref: "users",
        required: true
    },
    noteId: {
        type: mongoose.Types.ObjectId,
        ref: "notes",
        required: true
    },
    permission: {
        type: String,
        enum: ["full", "read", "write"],
        required: true
    }
})

const AccessControl = mongoose.model("accesscontrols",accessControlSchema)

module.exports = AccessControl
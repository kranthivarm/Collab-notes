const AccessControl = require("../models/accessControl.model");
const Note = require("../models/note.model");
const User = require("../models/user.model");

const createNote = async (req,res) => {
    try{
        const { title, content } = req.body;
        const { _id } = req.user;
        const note = new Note({ title, content, createdBy: _id })
        const access = new AccessControl({ ownerId: _id, userId: _id, noteId: note._id, permission: "full" })
        const [savedNote, savedPermission] = await Promise.all([
            note.save(),            // for concurrent execution
            access.save()
        ])
        return res.status(201).json({
            "note": savedNote,
            "message": "Note created successfully"
        })
    }
    catch(e){
        console.log(e)
        return res.status(500).json({"message": "Internal server error"})
    }
}

const deleteNote = async (req,res) => {
    try{
        const { noteId } = req.body;
        const { _id } = req.user;
        const access = await AccessControl.findOne({ ownerId: _id, noteId: noteId, permission: "full" })
        if(access){
            await Promise.all([
                Note.findByIdAndDelete( noteId ),            // for concurrent execution
                AccessControl.deleteMany({ noteId })
            ])
            return res.status(200).json({"message": "Note deleted successfully"})
        }
        return res.status(400).json({"message": "Can't perform this operation"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const getOwnNotesOfAUser = async (req, res) => {
    try{
        const { _id } = req.user;
        const ownNotes = await AccessControl.find({ userId: _id, permission: "full" }).populate("noteId").select("-permission -userId")
        return res.status(200).json(ownNotes)
    }
    catch(e) {
        return res.status(500).json({"message": "Internal server error"})
    }
}

const getReadableNotesOfAUser = async (req, res) => {
    try{
        const { _id } = req.user;
        const ownNotes = await AccessControl.find({ userId: _id, permission: "read" }).populate("noteId").select("-permission -userId")
        return res.status(200).json(ownNotes)
    }
    catch(e) {
        return res.status(500).json({"message": "Internal server error"})
    }
}

const getEditableNotesOfAUser = async (req, res) => {
    try{
        const { _id } = req.user;
        const ownNotes = await AccessControl.find({ userId: _id, permission: "write" }).populate("noteId").select("-permission -userId")
        return res.status(200).json(ownNotes)
    }
    catch(e) {
        return res.status(500).json({"message": "Internal server error"})
    }
}


const getAllNotesOfaUser = async (req,res) => {
    try{
        const { _id } = req.user;
        const allNotes = await AccessControl.find({ userId: _id }).populate("noteId")
        return res.status(200).json(allNotes)
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const updateNote = async (req,res) => {
    try{
        const { noteId, title, content } = req.body
        const { _id } = req.user
        const access = await AccessControl.findOne({ noteId: noteId, userId: _id })
        if(access){
            if(access.permission === "full" || access.permission === "write"){
                const updatedNote = await Note.findByIdAndUpdate({ _id: noteId }, { title, content })
                updatedNote.title = title
                updatedNote.content = content
                return res.status(200).json({"message": "Note updated successfully", "updatedNote": updatedNote})
            }
        }
        return res.status(401).json({"message": "You don't have permission to execute this operation"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const getPermissionsOfaNote = async (req,res) => {
    try{
        const { noteId } = req.body
        const note = await Note.findById( noteId )
        if(note.createdBy != req.user['_id']){
            return res.status(403).json({"message": "You can't perform this operation"})
        }
        const permissions = await AccessControl.find({ noteId: noteId, permission: { $ne: "full" } }).populate("userId", "username").select("_id permission")
        return res.status(200).json(permissions)
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

module.exports = { createNote, deleteNote, getAllNotesOfaUser, updateNote, getPermissionsOfaNote, getOwnNotesOfAUser, getReadableNotesOfAUser, getEditableNotesOfAUser }

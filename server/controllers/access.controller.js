const AccessControl = require("../models/accessControl.model");
const User = require("../models/user.model");

const giveAccessToUserByUsername = async (req,res) => {
    try{
        const { noteId, username, access } = req.body
        if(username === req.user.username){
            return res.status(401).json({"message": "You have full permission on your notes"})
        }
        const { _id } = req.user;
        const user = await User.findOne({ username })
        if(user){
            const accessControl = new AccessControl({ ownerId:_id, userId: user._id, noteId, permission: access })
            await accessControl.save()
            return res.status(201).json({"message": "Permission added successfully", accessControl})
        }
        return res.status(404).json({"message": "User doesnot exist"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

const deletePermission = async (req,res) => {
    try{
        const { _id } = req.body
        await AccessControl.findByIdAndDelete( _id )
        return res.status(200).json({"message": "Permission deleted"})
    }
    catch(e){
        return res.status(500).json({"message": "Internal server error"})
    }
}

module.exports = { giveAccessToUserByUsername, deletePermission }

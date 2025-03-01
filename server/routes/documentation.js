const express = require('express');

const router = express.Router()

router.get("/",(req,res) => {
    res.status(200).json(
        [
            {
                method: "POST",
                path: "/api/auth/login",
                body: {
                    "username": "",
                    "password": ""
                }
            },
            {
                method: "POST",
                path: "/api/auth/register",
                body: {
                    "username": "",
                    "password": "",
                    "email": ""
                }
            },
            {
                method: "POST",
                path: "/api/create-note",
                body: {
                    "token": "",
                    "title": "",
                    "content": ""
                }
            },
            {
                method: "POST",
                path: "/api/delete-note",
                body: {
                    "token": "",
                    "noteId": ""
                }
            },
            {
                method: "POST",
                path: "/api/update-note",
                body: {
                    "token": "",
                    "noteId": "",
                    "title": "",
                    "content": ""
                }
            },
            {
                method: "POST",
                path: "/api/get-all-notes-of-a-user",
                body: {
                    "token": ""
                }
            },
            {
                method: "POST",
                path: "/api/get-permissions-of-a-note",
                body: {
                    "token": "",
                    "noteId": ""
                }
            },
            {
                method: "POST",
                path: "/api/give-access-by-username",
                body: {
                    "token": "",
                    "noteId": "",
                    "username": "",
                    "access": "read | write"
                }
            },
            {
                method: "POST",
                path: "/api/delete-permission",
                body: {
                    "token": "",
                    "_id": ""
                }
            }
        ]
    )
})

module.exports = router
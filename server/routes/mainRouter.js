const express = require('express')
const authRouter = require('./auth.route')
const documentation = require('./documentation')
const noteRouter = require('./note.route')
const accessControlRouter = require('./accessControl.route')

const router = express.Router()

// router.use(documentation)
router.use("/auth",authRouter)
router.use(noteRouter)
router.use(accessControlRouter)

module.exports = router
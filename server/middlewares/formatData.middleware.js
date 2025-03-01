const formatData = (req,res,next) => {
    if(req.body.username!==undefined) req.body.username = req.body.username.toLowerCase().trim()
    if(req.body.email!==undefined) req.body.email = req.body.email.toLowerCase().trim()
    next()
}

module.exports = formatData
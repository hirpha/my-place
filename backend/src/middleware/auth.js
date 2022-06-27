const jwt = require("jsonwebtoken")
const User = require("../model/user")


const auth = async (req, res, next) => {
console.log("Aouotentication")


    try{
        const token = req.header("Authorization").replace("Bearer ","")
        console.log(token)
        const decoded=  jwt.verify(token, "visitoromia")
        const user = await User.findOne({_id:decoded._id,"tokens.token":token})
        
        //  console.log(user)
        if(!user){
            throw new Error()
        }

        req.user = user
        req.token = token
        

        next()
    }catch(e){
        console.log(e.message)
        res.status(401).send({error:"please Authenticate."})
    }
    
}

module.exports = auth
const mongoose = require("mongoose")
const jwt = require("jsonwebtoken")
const bcrypt= require("bcryptjs")

const Place = require("./place")

const userSchema = mongoose.Schema({
    name:{
        type:String,
        required:true,
    },
    email:{
        type:String,
        required:true,
    },
    address:{
        type:String,
        required:true,
    },
    password:{
        type:String,
        required:true,
    }
    ,avatar:{
        type:String,
    }
    ,tokens:[
        {
            token:{
                type:String,
                required:true
            }
        }
    ],
})

userSchema.virtual("place",{
    ref:"Place",
    localField:"_id",
    foreignField:"owner",
})


userSchema.statics.getAllPlace = async (id) => {
    const user = await User.find({_id:id})


    return user
}

userSchema.methods.toJSON = function (){
    const user = this
    const userObject = user.toObject()
     delete userObject.password
    delete userObject.tokens
    

    return userObject
}
userSchema.methods.generateAuthToken = async function (){
    const user = this
    const token = jwt.sign({_id:user._id.toString()}, "visitoromia")
   user.tokens = user.tokens.concat({token})
   await user.save()    
    return token
}

userSchema.statics.findByCridentials = async( email,  password) =>{
    try{
    const user= await User.findOne({email})
    console.log(email)
    if(!user){
        throw new Error("Unable to login")
    }

    const isMatch = await bcrypt.compare(password, user.password)
    if(!isMatch){
        throw new Error("No match found")
    }
    return user
}catch(e){
    throw new Error(e)
}


}

userSchema.pre("save", async function(next){
    const user = this
    if(user.isModified("password")){
        user.password = await bcrypt.hash(user.password, 8)
    }
    console.log("before saving")
    next()

})
const User = mongoose.model("User", userSchema)

module.exports = User

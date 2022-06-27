const mongoose = require("mongoose")

const placeSchema = mongoose.Schema({
    name:{
        type:String,
        required:true
    },
    description:{
        type:String,
        required:true
    }
    ,owner:{
        type:mongoose.Schema.Types.ObjectId,
        required:true,
        ref:"User"
    },image:{
        type:String,
        required:true

    }
}) 


// placeSchema.methods.toJSON = function(){
//     const place = this
//     const placeObject = place
//     delete placeObject.id
    

//     return placeObject
// }

const place = mongoose.model("Place", placeSchema)


module.exports = place
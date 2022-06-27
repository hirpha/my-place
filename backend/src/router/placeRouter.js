
const express = require("express")
const { header } = require("express/lib/request")
const multer = require("multer")
const sharp = require("sharp")
const auth = require('../middleware/auth')
const Place = require("../model/place")
const User = require("../model/user")

const router = express.Router()

router.get("/allPlaces", async(req, res) => {
console.log("fetching")

    try{
        const sentData = []

        const users = await User.find()
        // console.log(users)
        for  (var i =0; i < users.length; i++ )  {
            var user = users[i]
            // var userPlace = await Place.find({owner:user._id})
            var userPlace = await user.populate("place")
            // console.log(userPlace)
            var countPlace = await Place.count({owner:user._id})
            if(countPlace > 0){
              sentData.push({
                user:user,
                userPlaces:userPlace.place,
                countPlace:countPlace
            })
            }
           
       }
        console.log(sentData)
        // console.log(user)
        res.set({"Content-type": "multipart/form-data"})
        res.status(202).send(sentData)

    }catch(e){
        res.status(404).send(e.message)
        console.log(e)
    }
})

const storage= multer.diskStorage({
  destination:function(req, file, cb){
    cb(null, './uploads/')
  },
  filename:function(req,file, cb){
    cb(null, new Date().toISOString + file.originalname)
  }
})

  const avatar = multer({
    // limits:{
    //     fileSize:5000000,
    // },
    dest:'uploads/',
    storage:storage,
    fileFilter(req, file, cb){
        if(!file.originalname.match(/\.(jpg|jpeg|png|JPEG|PNG|JPEG)$/)){
           return  cb(new Error("please upload image"))
        }
        cb(undefined, true)
    }

  })
router.post("/createPlace", auth, avatar.single("placeImage"),async (req, res)=>{
    console.log(req.file)
    // const buffer =await sharp(req.file.buffer).resize({width:250,hieght:250}).png().toBuffer()
    const place =  Place({...req.body, owner:req.user._id, image:req.file.path})
        await place.save()
        res.send({"user":req.user})

    
},(error, req, res, next)=>{
    console.log(error.message)
    res.status(400).send({error:error.message})
  })

router.post("/place/me/image", auth, async (req, res)=>{
   
  req.user.avatar = buffer
  await req.user.save()
  res.send(req.user.avatar)
  console.log("ok")
} ,(error, req, res, next)=>{
  console.log(error.message)
  res.status(400).send({error:error.message})
})

router.get("/user/:id/details", async(req, res)=>{
  try{
    const user = await User.findById(req.params.id)
     await user.populate("place")
    console.log(user.place)
    res.send({"name":user.name,"userPlace":user.place})
  }catch(e){
    res.sendStatus(404)
    console.log(e)
  }
})



module.exports = router
const express = require("express")
const multer = require("multer")
const sharp = require("sharp")


const router = express.Router()

const auth = require("../middleware/auth")
const User = require("../model/user")


router.use((req, res, next) => {
    console.log('Time: ', Date.now())
    next()
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
  

router.post("/register",async (req,res)=>{

try{
  console.log("helloo")

  // const buffer =await sharp(req.file.buffer).resize({width:250,hieght:250}).png().toBuffer()

  // const user = new User({...req.body, avatar:req.file.path})
  
  const user = new User({...req.body, avatar:null})
    await user.save()
    const token = await user.generateAuthToken()
    console.log(user)
    res.status(201).send({"success":"successfully registered", token})

}catch(e){
console.log(e.message)
res.send(e.message)

}
})
// router.post("/register",avatar.single("signup"),async (req,res)=>{

// try{

//   const buffer =await sharp(req.file.buffer).resize({width:250,hieght:250}).png().toBuffer()

//   const user = new User({...req.body, avatar:buffer})
//     await user.save()
//     const token = await user.generateAuthToken()
//     console.log(user)
//     res.status(201).send({"success":"successfully registered", token})

// }catch(e){
// console.log(e.message)
// res.send(e.message)

// }
// })

router.post("/user/logout" ,auth, async (req, res)=>{
  try{
    // console.log("tokens",req.user.tokens)
    req.user.tokens = req.user.tokens.filter((token) =>  token.token != req.token)
    await req.user.save()
    // console.log("token",req.user.tokens)
    res.status(200).send(req.user.tokens)
}catch(e){
    res.status(500).send()
}

})


router.post("/login",  async (req, res)=>{
  console.log("during login")
  try{
    console.log(req.body)
    const user = await User.findByCridentials(req.body.email, req.body.password)
    const token = await user.generateAuthToken()
    console.log("log in")
    await user.populate("place")
    res.status(201).send({"login":"successfully login","user":user,"token":token,})
  }catch(e){
    res.status(404).send(e)
  }
})





router.post("/user/me/profile",auth, avatar.single("profileImage"), async (req,res)=>{
  console.log("image upload")
  console.log(req.file.path)
  // 
  // const buffer =await sharp(req.file.buffer).resize({width:250,hieght:250}).png().toBuffer()
  req.user.avatar = req.file.path

  await req.user.save()
  res.send({"user":req.user})
  console.log("ok")
} ,(error, req, res, next)=>{
  console.log(error.message)
  res.status(400).send({error:error.message})
})

router.get("/user/:id/avatar", async(req, res)=>{
  try{
  const user = await User.findById(req.params.id)
  if(!user || !user.avatar){
      throw new Error()
  }
  res.set("Content-Type","image/png")
  res.send(user.avatar)
}catch(e){
  res.status(404).send(e.message)
}
},)

module.exports = router
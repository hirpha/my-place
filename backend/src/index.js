const express = require("express")
const cors = require("cors")
const bodyParser = require("body-parser")

const userRouter = require('./router/userRouter')
const {database}=require("./db/database")
const placeRouter = require("./router/placeRouter")
database()

const app = express()



app.use(cors())
app.use(bodyParser.urlencoded(
    { extended:true }
))

app.use('/uploads', express.static("uploads"))
app.use(express.json())
app.use(userRouter)
app.use(placeRouter)
const port = process.env.PORT || 3000;
app.listen(port,()=>{
console.log("server listening" ,port)
})

const mongoose = require("mongoose")



const database= async()=> 
{
    
mongoose.connect('mongodb://127.0.0.1:27017/visit_oromia',{useNewUrlParser: true})

var conn = mongoose.connection;
conn.on('connected', () => {
    console.log('database is connected successfully');
});
conn.on('disconnected',function(){
    console.log('database is disconnected successfully');
})
conn.on('error', console.error.bind(console, 'connection error:'))
 
}


module.exports = {database}
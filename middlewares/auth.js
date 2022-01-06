const jwt = require("jsonwebtoken");
const authConfig = require("../config/auth");

module.exports = (req, res, next) => {
    
    console.log(req.session.token);

    if(!req.session.token){
        res.render('index',{title: 'TURNERO', error: '', pretty: true});
    }else{

        let token = req.session.token.split(" ")[1];
        console.log(token);
        jwt.verify(token, authConfig.secret, (err, decoded) => {
            if(err){
                res.status(500).json({ msg: "No se pudo decodificar el token"});
            }else{
                console.log(decoded);
                req.user = decoded.user;
                next();
            }
        })
    }
}
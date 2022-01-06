const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const authConfig = require('../config/auth');
const Persona = require('../models').Persona;
const Usuario = require('../models').Usuario;


exports.singIn = function(req, res){

    let { usuario, password } = req.body;

    Usuario.findOne({where:{
        Usuario: usuario
    }, include: Persona})
    .then(user => {
        if(!user){
            res.render('index',{title: 'TURNERO', error: 'Usuario incorrecto', pretty: true});
        }else{
            if(bcrypt.compareSync(password, user.password)){

                let token = jwt.sign({ user: user }, authConfig.secret, {
                    expiresIn: authConfig.expires
                });

                req.user = user;
                req.session.token = "Bearer " + token;
                res.redirect('/');

            }else{
                res.render('index',{title: 'TURNERO', error: 'Contraseña incorrecta', pretty: true});
            }
        }
    }).catch(err =>{
        res.status(500).send(err);
    })
}

exports.singUp = function(req, res){
    
    let password = bcrypt.hashSync(req.body.passRegistro, authConfig.rounds);

    Persona.create({
        dni: req.body.dni,
        nombre: req.body.nombre,
        apellido: req.body.apellido,
        celular: req.body.celular,
        email: req.body.email,
        domicilio: req.body.domicilio,
        riesgoso: 0,
        Usuario:{
            usuario: req.body.userRegistro,
            password: password
        }
    },{
        include: Usuario
    }).then(user =>{

        Usuario.findOne({where:{
            Usuario: user.Usuario.usuario
        }, include: Persona}).then(userr =>{
            let token = jwt.sign({ user: userr }, authConfig.secret, {
                expiresIn: authConfig.expires
            });

            req.user = userr;
            req.session.token = "Bearer " + token;
            res.redirect('/');
        })
    }).catch(err =>{
        res.status(500).json(err);
    });
}

exports.singOut = async function(req, res){
    await req.session.destroy(function(err){
        console.log(err)
    })
    res.redirect("/");
}
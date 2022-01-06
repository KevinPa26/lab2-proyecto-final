const { Op } = require('sequelize');
var db = require('../models/index');
const bcrypt = require('bcrypt');
const authConfig = require('../config/auth')
const Persona = require('../models').Persona;
const Usuario = require('../models').Usuario;

exports.cargarPerfil = async function(req, res){
    const persona = await Persona.findByPk(req.user.Persona.id,{include:Usuario});
    res.render("paciente-perfil",{pretty: true, persona:persona});
};

exports.agregar = function(req, res){
    if(req.user.RoleId == 2){
        res.render('secretario-agregarPersona', {pretty: true, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.personasSinRelacion = async function(req, res){
    const personas = await db.sequelize.query('SELECT * FROM `personas` WHERE (id NOT IN (SELECT personaid FROM medicos)) AND usuarioid IS null', {
        model: Persona
      });
    res.send(personas);
}

exports.personasConUsuPaciente = async function(req, res){
    const personas = await Persona.findAll({
        where:{UsuarioId:{[Op.not]:null}}, include:{model:Usuario, where:{RoleId: 3}}
    });
    res.send(personas);
};

exports.insertar = async function(req, res){
    if(req.user.RoleId == 1){
        await Persona.create({
            dni: req.body.dni,
            nombre: req.body.nombre,
            apellido: req.body.apellido,
            celular: req.body.celular,
            email: req.body.email,
            domicilio: req.body.domicilio,
            riesgoso: 0
        });
        res.redirect('/medico/agregar');
    }else if(req.user.RoleId == 2){
        let password = await bcrypt.hashSync(req.body.passRegistro, authConfig.rounds);

        await Persona.create({
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
        })
        res.redirect('/turno/allTurnos');
    }else{
        res.redirect('/');
    }
}

exports.update = async function(req, res){
    const persona = await Persona.findByPk(req.user.Persona.id);
    const usuario = await Usuario.findByPk(req.user.id);
    if(req.body.password != ""){
        let password = bcrypt.hashSync(req.body.password, authConfig.rounds);
        usuario.password = password;
    };
    usuario.usuario = req.body.usuario;
    persona.celular = req.body.celular;
    persona.email = req.body.email;
    persona.domicilio = req.body.domicilio;
    await persona.save();
    await usuario.save();
    res.redirect("/");
}
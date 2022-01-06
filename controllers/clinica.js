const Clinica = require('../models').Clinica;

exports.clinicaTodas = async function(req, res){
    const clinicas = await Clinica.findAll();
    res.send(clinicas);
};

exports.clincaID = async function(req, res){
    const clinica = await Clinica.findByPk(req.params.id);
    res.render('clinica', {pretty: true, clinica: clinica, role: req.user.RoleId, persona: req.user.Persona});
};

exports.insertar = async function(req, res){
    await Clinica.create({
        nombre: req.body.nombre,
        direccion: req.body.direccion
    });
    res.redirect('/agenda/crearAgenda');
};

exports.agregar = function(req, res){
    if(req.user.RoleId == 1){
        res.render('admin-agregarClinica', {pretty: true, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
};


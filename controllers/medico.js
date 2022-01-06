const Medico = require('../models').Medico;
const Especialidad = require('../models').Especialidad;
const Persona = require('../models').Persona;


exports.medicosEsp = async function(req, res){
    const medicos = await Medico.findAll({where:{"EspecialidadId":req.params.EspId},include:Persona});
    res.send(medicos)
};

exports.agregar = function(req, res){
    if(req.user.RoleId == 1){
        res.render('admin-agregarMedico', {pretty: true, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.insertar = async function(req, res){
    if(req.user.RoleId == 1){
        await Medico.create({
            PersonaId: req.body.persona,
            matricula: req.body.matricula,
            EspecialidadId: req.body.especialidad
        },{
            include:[Persona, Especialidad]
        });
        res.redirect('/agenda/crearAgenda');
    }else{
        res.redirect('/');
    }
}

exports.medicoID = async function(req, res){
    const medico = await Medico.findByPk(req.params.id, {include:[Persona, Especialidad]});
    res.render('medico', {pretty: true, medico: medico, role: req.user.RoleId, persona: req.user.Persona});
}
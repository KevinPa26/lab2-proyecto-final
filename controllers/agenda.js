const Medico = require('../models').Medico;
const Agenda = require('../models').Agenda;
const Clinica = require('../models').Clinica;
const Persona = require('../models').Persona;
const Procedimiento = require('../models').Procedimiento;

exports.buscarAgenda = async function(req, res){
    if(req.user.RoleId == 1){
        const agendas = await Agenda.findAll({include:[{model:Clinica}, {model:Procedimiento}, {model:Persona}, {model:Medico, include:{model:Persona}}]})
        res.render('admin-buscarAgenda', {pretty: true, agendas: agendas, persona: req.user.Persona});
    }else if(req.user.RoleId == 3){
        res.render('paciente-buscarAgenda', {pretty: true, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.agendasMed = async function(req, res){
    const agendas = await Agenda.findAll({where:{"MedicoId":req.params.MedId},include:Clinica});
    res.send(agendas)
}

exports.agendasPro = async function(req, res){
    const agendas = await Agenda.findAll({where:{"ProcedimientoId":req.params.ProId},include:Clinica});
    res.send(agendas)
}

exports.crearAgenda = async function(req, res){
    if(req.user.RoleId == 1){
        res.render('admin-crearAgenda', {pretty: true, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.insertarAgenda = async function(req, res){
    if(req.body.tipo == "Medico"){
        const medico = await Medico.findByPk(req.body.medico, {include:Persona});
        await Agenda.create({
            PersonaId: req.user.Persona.id,
            ClinicaId: req.body.clinica,
            MedicoId: req.body.medico,
            nombre: "Agenda de " + medico.Persona.nombre + " " + medico.Persona.apellido,
            tiempo_turno: req.body.tiempo_turno
        });
        res.redirect("/agenda/buscarAgenda");
    }else if(req.body.tipo == "Procedimiento"){
        const pro = await Procedimiento.findByPk(req.body.procedimiento);
        await Agenda.create({
            PersonaId: req.user.Persona.id,
            ClinicaId: req.body.clinica,
            ProcedimientoId: req.body.procedimiento,
            nombre: "Agenda de " + pro.nombre,
            tiempo_turno: req.body.tiempo_turno
        });
        res.redirect("/agenda/buscarAgenda");
    }else{
        res.json({msg: "error no eligio el tipo de agenda"})
    }
}
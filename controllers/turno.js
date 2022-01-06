const Turno = require('../models').Turno;
const EstadoTurno = require('../models').Estado_turno;
const Calendario = require('../models').Calendario;
const Persona = require('../models').Persona;
const Agenda = require('../models').Agenda;
const Procedimiento = require('../models').Procedimiento;
const Especialidad = require('../models').Especialidad;
const Medico = require('../models').Medico;
const Clinica = require('../models').Clinica;

exports.turnosDisponibles = async function(req, res){
    if(req.user.RoleId == 1 || 3){
        const turnos = await Turno.findAll({where:{"calendarioId":req.params.calId, "EstadoTurnoId":1}, include:[Calendario, EstadoTurno]});
        res.render("paciente-reservaTurno", {pretty: true, turnos:turnos, role:req.user.RoleId, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.misTurnos = async function(req, res){
    if(req.user.RoleId == 3){
        const turnos = await Turno.findAll({where:{'$Turno.PersonaId$':req.user.Persona.id, "EstadoTurnoId":2}, include:[{model:Persona}, {model:EstadoTurno}, {model:Calendario, include:{model:Agenda, include:[{model:Medico, include:Persona}, {model:Procedimiento}, {model:Clinica}]}}]});
        const persona = await Persona.findByPk(req.user.Persona.id);
        res.render('paciente-misTurnos', {pretty:true, turnos: turnos, persona: persona});
    }else{
        res.redirect('/');
    }
}

exports.allTurnos = async function(req, res){
    if(req.user.RoleId == 2){
        const turnos = await Turno.findAll({include:[{model:Persona}, {model:EstadoTurno}, {model:Calendario, include:{model:Agenda, include:[{model:Medico, include:[Especialidad, Persona]}, {model:Procedimiento}, {model:Clinica}]}}]});
        res.render('secretario-allTurnos', {pretty:true, turnos: turnos, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.reserva = async function(req, res){
    if(req.user.RoleId == 3){
        const turno = await Turno.findByPk(req.body.id);
        turno.fecha_reserva = req.body.fecha_reserva;
        turno.EstadoTurnoId = 2;
        turno.PersonaId = req.body.personaid || req.user.Persona.id;
        await turno.save();
    }
}

exports.cambiarEstado = async function(req, res){
    const turno = await Turno.findByPk(req.body.id);
    const persona = await Persona.findByPk(req.body.personaid);
    turno.EstadoTurnoId = req.body.estadoTurno;
    if(req.body.estadoTurno == 3){
        persona.riesgoso += 1;
        turno.EstadoTurnoId = 1;
    };
    if(req.body.estadoTurno == 2){
        turno.PersonaId = req.body.personaid;
        turno.fecha_reserva = req.body.fecha_reserva;
    };
    await persona.save();
    await turno.save();
}
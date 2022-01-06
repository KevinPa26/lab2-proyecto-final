const Calendario = require('../models').Calendario;
const Agenda = require('../models').Agenda;

exports.calendarioAgenda = async function(req, res){
    const dias = await Calendario.findAll({where:{"agendaId":req.params.AgendaId}});
    console.log(JSON.stringify(dias, null, 2));
    res.send(dias);
}

exports.agregarCal = async function(req, res){
    if(req.user.RoleId == 1){
        const dias = await Calendario.findAll({where:{"agendaId":req.params.AgendaId}});
        res.render('admin-agregarDia', {pretty: true, dias: dias, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
}

exports.insertarCal = async function(req, res){
    console.log(req.body)
    Calendario.create({
        AgendaId: req.body.agendaid,
        fecha: req.body.fecha,
        hora_inicio: req.body.hora_inicio,
        hora_fin: req.body.hora_fin
    },{
        include: Agenda
    })
}
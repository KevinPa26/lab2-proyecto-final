const Procedimiento = require("../models").Procedimiento;

exports.proTodas = async function(req, res){
    const pros = await Procedimiento.findAll();
    res.send(pros);
};

exports.procedimientoID = async function(req, res){
    const pro = await Procedimiento.findByPk(req.params.id);
    res.render('procedimiento', {pretty: true, pro: pro, role: req.user.RoleId, persona: req.user.Persona});
};

exports.agregar = function(req, res){
    if(req.user.RoleId == 1){
        res.render('admin-agregarProcedimiento', {pretty: true, persona: req.user.Persona});
    }else{
        res.redirect('/');
    }
};

exports.insertar = async function(req, res){
    if(req.user.RoleId == 1){
        await Procedimiento.create({
            nombre: req.body.nombre,
            descripcion: req.body.descripcion,
            indicaciones: req.body.indicaciones
        });
        res.redirect('/agenda/crearAgenda');
    }else{
        res.redirect('/');
    }
};

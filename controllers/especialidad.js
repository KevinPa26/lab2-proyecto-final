const Especialidad = require("../models").Especialidad;

exports.espTodas = async function(req, res){
    const esps = await Especialidad.findAll();
    res.send(esps);
};

exports.espID = async function(req, res){
    const esp = await Especialidad.findByPk(req.params.id);
    res.render('especialidad', {pretty: true, esp: esp, role: req.user.RoleId, persona: req.user.Persona});
}

exports.insertar = async function(req, res){
    if(req.user.RoleId == 1){
        await Especialidad.create({
            nombre: req.body.nombre,
            detalles: req.body.detalles
        });
        res.redirect('/medico/agregar');
    }else{
        res.redirect('/');
    };
};

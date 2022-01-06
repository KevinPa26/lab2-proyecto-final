var express = require('express');
var router = express.Router();
var medicoController = require('../controllers/medico');
var agendaController = require('../controllers/agenda');
var personaController = require('../controllers/persona');
var calendarioController = require('../controllers/calendario');
var turnoController = require('../controllers/turno');


router.get('/esp/:EspId', medicoController.medicosEsp);
router.get('/agregar', medicoController.agregar);
router.get('/:id', medicoController.medicoID);

router.post('/agregar', medicoController.insertar);

module.exports = router;
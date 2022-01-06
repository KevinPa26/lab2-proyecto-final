var express = require('express');
var router = express.Router();
var medicoController = require('../controllers/medico');
var agendaController = require('../controllers/agenda');
var personaController = require('../controllers/persona');
var calendarioController = require('../controllers/calendario');
var turnoController = require('../controllers/turno');


router.get('/agenda/:AgendaId', calendarioController.calendarioAgenda);
router.get('/agregarDia/:AgendaId', calendarioController.agregarCal);
router.post('/agregarDia', calendarioController.insertarCal);

module.exports = router;
var express = require('express');
var router = express.Router();
var medicoController = require('../controllers/medico');
var agendaController = require('../controllers/agenda');
var personaController = require('../controllers/persona');
var calendarioController = require('../controllers/calendario');
var turnoController = require('../controllers/turno');


router.get('/medico/:MedId', agendaController.agendasMed);
router.get('/procedimiento/:ProId', agendaController.agendasPro);
router.get('/buscarAgenda', agendaController.buscarAgenda);
router.get('/crearAgenda', agendaController.crearAgenda);
router.post('/crearAgenda', agendaController.insertarAgenda);

module.exports = router;
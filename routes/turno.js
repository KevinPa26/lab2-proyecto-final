var express = require('express');
var router = express.Router();
var medicoController = require('../controllers/medico');
var agendaController = require('../controllers/agenda');
var personaController = require('../controllers/persona');
var calendarioController = require('../controllers/calendario');
var turnoController = require('../controllers/turno');


router.get('/misTurnos', turnoController.misTurnos);
router.get('/calendario/:calId', turnoController.turnosDisponibles);
router.get('/allTurnos', turnoController.allTurnos);
router.post('/reservar', turnoController.reserva);
router.post('/cambiarEstado', turnoController.cambiarEstado);

module.exports = router;
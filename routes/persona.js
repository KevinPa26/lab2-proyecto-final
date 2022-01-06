var express = require('express');
var router = express.Router();
var personaController = require('../controllers/persona');

/* GET home page. */

router.get('/perfil', personaController.cargarPerfil);
router.get('/personasConUsuPaciente', personaController.personasConUsuPaciente);
router.get('/personasSinRelacion', personaController.personasSinRelacion);
router.get('/agregar', personaController.agregar);

router.post('/agregar', personaController.insertar);
router.post('/update', personaController.update);


module.exports = router;
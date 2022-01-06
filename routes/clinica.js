var express = require('express');
var router = express.Router();
var clinicaController = require('../controllers/clinica');


router.get('/todas', clinicaController.clinicaTodas);
router.get('/agregar', clinicaController.agregar);
router.post('/agregar', clinicaController.insertar);

router.get('/:id', clinicaController.clincaID);

module.exports = router;
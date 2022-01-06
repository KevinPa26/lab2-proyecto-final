var express = require('express');
var router = express.Router();
var proController = require('../controllers/procedimiento');


router.get('/todas', proController.proTodas);
router.get('/agregar', proController.agregar);
router.post('/agregar', proController.insertar)
router.get('/:id', proController.procedimientoID);


module.exports = router;
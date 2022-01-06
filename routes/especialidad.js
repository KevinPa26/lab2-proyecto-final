var express = require('express');
var router = express.Router();
var espController = require('../controllers/especialidad');


router.get('/todas', espController.espTodas);
router.get('/:id', espController.espID);

router.post('/agregar', espController.insertar);

module.exports = router;
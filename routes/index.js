var express = require('express');
var router = express.Router();

const auth = require('../middlewares/auth');
var authController = require('../controllers/auth');

/* GET home page. */
router.get('/', auth, function(req, res, next) {
  if(req.user){
    console.log(req.user)
    res.render('lobby', {pretty: true, role: req.user.RoleId, persona: req.user.Persona});
  }else{
    res.render('index', { title: 'TURNERO', error: '', pretty:true});
  }
});

router.get('/singOut', authController.singOut);

router.post('/singUp', authController.singUp);
router.post('/singIn', authController.singIn);

module.exports = router;

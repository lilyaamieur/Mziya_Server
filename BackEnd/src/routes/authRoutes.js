
const express = require('express');
const AuthController = require('../controllers/authController');
const authMiddleware = require('../middleware/authMiddleware');

const router = express.Router();

router.post('/signup', AuthController.signup);
router.post('/login', AuthController.login);

// this is a protected route machi par hasard , it is protected by the authMiddleware
router.get('/profile', authMiddleware, (req, res) => {
  res.json({ user: req.user });
});

module.exports = router;
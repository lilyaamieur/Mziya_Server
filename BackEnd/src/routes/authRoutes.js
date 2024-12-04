const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { validateSignup, validateLogin } = require('../middleware/validationMiddleware');

// Signup route
router.post('/signup', validateSignup, authController.signup);

// Login route
router.post('/login', validateLogin, authController.login);

// Email verification route
router.get('/verify/:token', authController.verifyEmail);

// Forgot password route
router.post('/forgot-password', authController.forgotPassword);

// Password reset route
router.post('/reset-password/:token', authController.resetPassword);

module.exports = router;





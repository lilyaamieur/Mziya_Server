// src/controllers/authController.js
const AuthService = require('../services/authService');

class AuthController {
  // Signup controller
  static async signup(req, res) {
    try {
      const { name, email, password, phone, address } = req.body;
      
      const result = await AuthService.signup({
        name,
        email,
        password,
        phone,
        address
      });
      
      res.status(201).json({
        message: 'User registered successfully',
        user: result.user,
        token: result.token
      });
    } catch (error) {
      res.status(400).json({ 
        message: error.message 
      });
    }
  }

  // Login controller
  static async login(req, res) {
    try {
      const { email, password } = req.body;
      
      const result = await AuthService.login(email, password);

      res.status(200).json({
        message: 'Login successful',
        user: result.user,
        token: result.token
      });
    } catch (error) {
      res.status(401).json({ 
        message: error.message 
      });
    }
  }
}

module.exports = AuthController;
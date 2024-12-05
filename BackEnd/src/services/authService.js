
const User = require('../models/User');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

class AuthService {
  // Signup service
  static async signup(userData) {
    // Input validation
    if (!userData.name || !userData.email || !userData.password) {
      throw new Error('Name, email, and password are required');
    }

    // Check if user already exists
    const existingUser = await User.findByEmail(userData.email);
    if (existingUser) {
      throw new Error('User with this email already exists');
    }

    // Password strength validation
    if (userData.password.length < 8) {
      throw new Error('Password must be at least 8 characters long');
    }

    // Create user
    const newUser = await User.create(userData);
    
    // Generate JWT token
    const token = this.generateToken(newUser);

    // Remove sensitive information
    const userResponse = { ...newUser };
    delete userResponse.password;

    return { user: userResponse, token };
  }

  // Login service
  static async login(email, password) {
    // Input validation
    if (!email || !password) {
      throw new Error('Email and password are required');
    }

    // Find user by email
    const user = await User.findByEmail(email);
    if (!user) {
      throw new Error('Invalid credentials');
    }

    // Compare passwords
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      throw new Error('Invalid credentials');
    }

    // Generate JWT token
    const token = this.generateToken(user);

    // Remove sensitive information
    const userResponse = { ...user };
    delete userResponse.password;

    return { user: userResponse, token };
  }

  // Generate JWT token
  static generateToken(user) {
    return jwt.sign(
      { 
        id: user.id, 
        email: user.email 
      }, 
      process.env.JWT_SECRET, 
      { expiresIn: '1d' }
    );
  }
}

module.exports = AuthService;
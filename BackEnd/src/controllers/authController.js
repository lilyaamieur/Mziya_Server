const User = require('../models/User');
const authService = require('../services/authService');
const emailService = require('../services/emailService');
const { generateToken } = require('../utils/tokenGenerator');
const bcrypt = require('bcryptjs');

class AuthController {
  async signup(req, res) {
    try {
      const { 
        name, 
        surname, 
        email, 
        phoneNumber, 
        birthday, 
        password, 
        passwordConfirmation 
      } = req.body;

      // Validate password match
      if (password !== passwordConfirmation) {
        return res.status(400).json({ message: 'Passwords do not match' });
      }

      // Check if user already exists
      const existingUser = await User.findOne({ 
        where: { 
          [Op.or]: [{ email }, { phoneNumber }] 
        } 
      });

      if (existingUser) {
        return res.status(400).json({ message: 'User already exists' });
      }

      // Create verification token
      const verificationToken = authService.generateVerificationToken();

      // Create user
      const user = await User.create({
        name,
        surname,
        email,
        phoneNumber,
        birthday,
        password,
        verificationToken
      });

      // Send verification email
      await emailService.sendVerificationEmail(email, verificationToken);

      res.status(201).json({ 
        message: 'User registered successfully. Please check your email to verify.',
        userId: user.id 
      });
    } catch (error) {
      res.status(500).json({ message: 'Registration failed', error: error.message });
    }
  }

  async login(req, res) {
    try {
      const { login, password } = req.body;

      // Find user by email or phone number
      const user = await User.findOne({ 
        where: { 
          [Op.or]: [{ email: login }, { phoneNumber: login }] 
        } 
      });

      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }

      // Check if user is verified
      if (!user.isVerified) {
        return res.status(403).json({ message: 'Please verify your email first' });
      }

      // Compare passwords
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(401).json({ message: 'Invalid credentials' });
      }

      // Generate JWT token
      const token = generateToken(user);

      res.json({ 
        token, 
        user: { 
          id: user.id, 
          name: user.name, 
          email: user.email 
        } 
      });
    } catch (error) {
      res.status(500).json({ message: 'Login failed', error: error.message });
    }
  }

  async verifyEmail(req, res) {
    try {
      const { token } = req.params;

      const user = await User.findOne({ where: { verificationToken: token } });

      if (!user) {
        return res.status(400).json({ message: 'Invalid verification token' });
      }

      // Mark user as verified
      user.isVerified = true;
      user.verificationToken = null;
      await user.save();

      res.json({ message: 'Email verified successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Verification failed', error: error.message });
    }
  }

  async forgotPassword(req, res) {
    try {
      const { email } = req.body;

      const user = await User.findOne({ where: { email } });

      if (!user) {
        return res.status(404).json({ message: 'User not found' });
      }

      // Generate password reset token
      const resetToken = authService.generateResetToken();

      // Save reset token to user
      user.passwordResetToken = resetToken;
      user.passwordResetExpires = Date.now() + 3600000; // 1 hour
      await user.save();

      // Send password reset email
      await emailService.sendPasswordResetEmail(email, resetToken);

      res.json({ message: 'Password reset link sent to email' });
    } catch (error) {
      res.status(500).json({ message: 'Password reset failed', error: error.message });
    }
  }
}

module.exports = new AuthController();

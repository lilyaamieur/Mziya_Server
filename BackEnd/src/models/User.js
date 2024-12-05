const supabase = require('../config/database');
const bcrypt = require('bcryptjs');

class User {
  // Create a new user
  static async create(userData) {
    const { 
      name, 
      email, 
      password, 
      phone, 
      address 
    } = userData;

    // Hash the password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Insert user into Supabase
    const { data, error } = await supabase
      .from('users')
      .insert([{
        name,
        email,
        password: hashedPassword,
        phone,
        address,
        verifie: false
      }])
      .select();

    if (error) {
      console.log('here is the error, amel', error)
      throw error;
    }

    return data[0];
  }

  // Find user by email
  static async findByEmail(email) {
    const { data, error } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .single();

    if (error) {
      return null;
    }

    return data;
  }
}

module.exports = User;
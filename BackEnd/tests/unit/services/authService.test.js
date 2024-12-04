const AuthService = require('../../../src/services/authService');
const { User } = require('../../../src/models/User');

describe('Authentication Service', () => {
  test('generate verification token', () => {
    const token = AuthService.generateVerificationToken();
    expect(token).toBeTruthy();
    expect(token.length).toBeGreaterThan(10);
  });

  test('validate user credentials', async () => {
    // Create a test user
    const testUser = await User.create({
      name: 'Test',
      surname: 'User',
      email: 'test@example.com',
      phoneNumber: '+1234567890',
      birthday: new Date(),
      password: 'TestPass123!'
    });

    const validCredentials = await AuthService.validateCredentials(
      'test@example.com', 
      'TestPass123!'
    );
    expect(validCredentials).toBeTruthy();

    const invalidCredentials = await AuthService.validateCredentials(
      'test@example.com', 
      'WrongPassword'
    );
    expect(invalidCredentials).toBeFalsy();
  });
});
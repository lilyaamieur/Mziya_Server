const AuthController = require('../../../src/controllers/authController');
const httpMocks = require('node-mocks-http');

describe('Authentication Controller', () => {
  test('signup method with valid data', async () => {
    const req = httpMocks.createRequest({
      method: 'POST',
      url: '/signup',
      body: {
        name: 'Controller',
        surname: 'Test',
        email: 'controller@test.com',
        phoneNumber: '+1234567890',
        birthday: new Date(),
        password: 'ControllerPass123!',
        passwordConfirmation: 'ControllerPass123!'
      }
    });

    const res = httpMocks.createResponse();
    
    await AuthController.signup(req, res);
    
    expect(res.statusCode).toBe(201);
    expect(res._getJSONResponse()).toHaveProperty('userId');
  });

  test('login method with invalid credentials', async () => {
    const req = httpMocks.createRequest({
      method: 'POST',
      url: '/login',
      body: {
        login: 'nonexistent@email.com',
        password: 'WrongPassword'
      }
    });

    const res = httpMocks.createResponse();
    
    await AuthController.login(req, res);
    
    expect(res.statusCode).toBe(404);
  });
});
const { User } = require('../../../src/models/User');
const sequelize = require('../../../src/config/database');

describe('User Model', () => {
  beforeAll(async () => {
    await sequelize.sync({ force: true });
  });

  test('create user with valid data', async () => {
    const userData = {
      name: 'John',
      surname: 'Doe',
      email: 'john@example.com',
      phoneNumber: '+1234567890',
      birthday: new Date(),
      password: 'StrongPass123!'
    };

    const user = await User.create(userData);
    expect(user.name).toBe(userData.name);
    expect(user.email).toBe(userData.email);
  });

  test('cannot create user with duplicate email', async () => {
    const userData = {
      name: 'Jane',
      surname: 'Doe',
      email: 'john@example.com', // Same email as previous test
      phoneNumber: '+0987654321',
      birthday: new Date(),
      password: 'AnotherStrongPass123!'
    };

    await expect(User.create(userData)).rejects.toThrow();
  });
});
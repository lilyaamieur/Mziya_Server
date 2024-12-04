const { validateEmail, validatePassword } = require('../../../src/utils/validation');

describe('Validation Utilities', () => {
  describe('Email Validation', () => {
    test('valid email should pass', () => {
      expect(validateEmail('test@example.com')).toBeTruthy();
    });

    test('invalid email formats should fail', () => {
      expect(validateEmail('invalid-email')).toBeFalsy();
      expect(validateEmail('missing@domain')).toBeFalsy();
      expect(validateEmail('@incomplete.com')).toBeFalsy();
    });
  });

  describe('Password Validation', () => {
    test('strong password should pass', () => {
      expect(validatePassword('Strong123!@#')).toBeTruthy();
    });

    test('weak passwords should fail', () => {
      expect(validatePassword('weak')).toBeFalsy();
      expect(validatePassword('short')).toBeFalsy();
      expect(validatePassword('onlylowercase')).toBeFalsy();
      expect(validatePassword('ONLYUPPERCASE')).toBeFalsy();
    });
  });
});
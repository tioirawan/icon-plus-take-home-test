import bcrypt from 'bcrypt';

const SALT_ROUNDS = 10;

export function comparePassword(password, hash) {
  return bcrypt.compare(password, hash);
}

export function hashPassword(password) {
  return bcrypt.hash(password, SALT_ROUNDS);
}

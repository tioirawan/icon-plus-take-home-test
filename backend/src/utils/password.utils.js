import bcrypt from 'bcrypt';

export function comparePassword(password, hash) {
  return bcrypt.compare(password, hash);
}

import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET;
const ACCESS_TOKEN_TTL = process.env.ACCESS_TOKEN_TTL || '15m';
const REFRESH_TOKEN_TTL = process.env.REFRESH_TOKEN_TTL || '7d';

if (!JWT_SECRET) {
  throw new Error('Missing JWT_SECRET in environment variables');
}

export function createAccessToken(user) {
  const payload = { sub: user.id, type: 'ACCESS' };
  return jwt.sign(payload, JWT_SECRET, { expiresIn: ACCESS_TOKEN_TTL });
}

export function createRefreshToken(user) {
  const payload = { 
    sub: user.id, 
    type: 'REFRESH',
    tokenVersion: user.refreshTokenVersion 
  };
  return jwt.sign(payload, JWT_SECRET, { expiresIn: REFRESH_TOKEN_TTL });
}

export function verifyJwt(token) {
  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    return decoded;
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      throw new ApiError(401, 'AUTH_TOKEN_EXPIRED', 'Token has expired');
    }
    throw new ApiError(401, 'AUTH_INVALID_TOKEN', 'Invalid token');
  }
}

export async function logoutUser(userId) {
  await prisma.user.update({
    where: { id: userId },
    data: {
      refreshTokenVersion: {
        increment: 1,
      },
    },
  });
}

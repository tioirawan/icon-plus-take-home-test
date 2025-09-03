import prisma from '../../lib/prisma.js';
import ApiError from '../../utils/apiError.js';
import { createAccessToken, createRefreshToken, verifyJwt } from '../../utils/jwt.utils.js';
import { comparePassword } from '../../utils/password.utils.js';

export async function registerUser({ name, email, password }) {
  const existingUser = await prisma.user.findUnique({
    where: { email },
  });

  if (existingUser) {
    throw new ApiError(409, 'AUTH_EMAIL_IN_USE', 'An account with this email already exists.');
  }

  const passwordHash = await hashPassword(password);

  const newUser = await prisma.user.create({
    data: {
      name,
      email,
      passwordHash,
    },
  });

  const accessToken = createAccessToken(newUser);
  const refreshToken = createRefreshToken(newUser);

  const { passwordHash: _, refreshTokenVersion: __, ...userResponse } = newUser;

  return {
    accessToken,
    refreshToken,
    user: userResponse,
  };
}

export async function loginUser(email, password) {
  const user = await prisma.user.findUnique({
    where: { email },
  });

  if (!user) {
    throw new ApiError(401, 'AUTH_INVALID_CREDENTIALS', 'Invalid email or password');
  }

  const isPasswordValid = await comparePassword(password, user.passwordHash);
  if (!isPasswordValid) {
    throw new ApiError(401, 'AUTH_INVALID_CREDENTIALS', 'Invalid email or password');
  }

  prisma.user.update({
    where: { id: user.id },
    data: { lastLoginAt: new Date() },
  }).catch(console.error);

  const accessToken = createAccessToken(user);
  const refreshToken = createRefreshToken(user);

  // Sanitize 
  const { passwordHash, refreshTokenVersion, ...userResponse } = user;

  return {
    accessToken,
    refreshToken,
    user: userResponse,
  };
}

export async function refreshTokens(token) {
  const payload = verifyJwt(token);

  if (payload.type !== 'REFRESH') {
    throw new ApiError(401, 'AUTH_INVALID_TOKEN', 'Invalid token type provided for refresh');
  }

  const user = await prisma.user.findUnique({
    where: { id: payload.sub },
  });

  if (!user) {
    throw new ApiError(401, 'AUTH_USER_NOT_FOUND', 'User not found');
  }

  if (user.refreshTokenVersion !== payload.tokenVersion) {
    throw new ApiError(401, 'AUTH_TOKEN_REVOKED', 'Refresh token has been revoked');
  }

  // Rotate tokens
  const newAccessToken = createAccessToken(user);
  const newRefreshToken = createRefreshToken(user);

  return {
    accessToken: newAccessToken,
    refreshToken: newRefreshToken,
  };
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

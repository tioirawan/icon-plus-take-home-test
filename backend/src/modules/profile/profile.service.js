import prisma from '../../lib/prisma.js';
import ApiError from '../../utils/apiError.js';
import { comparePassword, hashPassword } from '../../utils/password.utils.js';

export async function updateUserProfile(userId, data) {
  const user = await prisma.user.update({
    where: { id: userId },
    data: data,
  });

  const { passwordHash, refreshTokenVersion, ...userResponse } = user;
  return userResponse;
}

export async function changeUserPassword(userId, currentPassword, newPassword) {
  const user = await prisma.user.findUnique({
    where: { id: userId },
  });

  if (!user) {
    throw new ApiError(404, 'USER_NOT_FOUND', 'User not found');
  }

  const isPasswordValid = await comparePassword(currentPassword, user.passwordHash);
  if (!isPasswordValid) {
    throw new ApiError(400, 'PASSWORD_INCORRECT', 'Current password is incorrect');
  }

  const newPasswordHash = await hashPassword(newPassword);

  await prisma.user.update({
    where: { id: userId },
    data: {
      passwordHash: newPasswordHash,
    },
  });
}

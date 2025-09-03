import * as profileService from './profile.service.js';

export const getProfile = (req, res) => {
  res.status(200).json(req.user);
};

export const updateProfile = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const updatedUser = await profileService.updateUserProfile(userId, req.body);
    res.status(200).json(updatedUser);
  } catch (error) {
    next(error);
  }
};

export const changePassword = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const { currentPassword, newPassword } = req.body;
    await profileService.changeUserPassword(userId, currentPassword, newPassword);
    res.status(200).json({ success: true, message: 'Password changed successfully' });
  } catch (error) {
    next(error);
  }
};

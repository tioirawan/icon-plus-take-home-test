export const getProfile = (req, res) => {
  res.status(200).json({ message: 'Get profile endpoint hit' });
};

export const updateProfile = (req, res) => {
  res.status(200).json({ message: 'Update profile endpoint hit' });
};

export const changePassword = (req, res) => {
  res.status(200).json({ message: 'Change password endpoint hit' });
};

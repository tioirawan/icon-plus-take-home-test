export const login = (req, res) => {
  res.status(200).json({ message: 'Login endpoint hit' });
};

export const refresh = (req, res) => {
  res.status(200).json({ message: 'Refresh token endpoint hit' });
};

export const logout = (req, res) => {
  res.status(200).json({ message: 'Logout endpoint hit' });
};

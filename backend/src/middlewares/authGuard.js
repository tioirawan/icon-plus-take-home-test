import prisma from '../lib/prisma.js';
import ApiError from '../utils/apiError.js';
import { verifyJwt } from '../utils/jwt.utils.js';

const authGuard = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      throw new ApiError(401, 'AUTH_MISSING_TOKEN', 'No authentication token provided');
    }

    const token = authHeader.split(' ')[1];
    const payload = verifyJwt(token);

    if (payload.type !== 'ACCESS') {
      throw new ApiError(401, 'AUTH_INVALID_TOKEN', 'Invalid token type');
    }

    const user = await prisma.user.findUnique({ where: { id: payload.sub }});

    if (!user) {
      throw new ApiError(401, 'AUTH_USER_NOT_FOUND', 'User associated with this token not found');
    }
    
    // sanitize and attach to request
    const { passwordHash, ...safeUser } = user;
    req.user = safeUser;
    
    next();
  } catch (error) {
    next(error);
  }
};

export default authGuard;
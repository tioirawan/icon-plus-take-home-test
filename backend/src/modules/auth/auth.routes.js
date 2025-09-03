import { Router } from 'express';
import authGuard from '../../middlewares/authGuard.js';
import validateRequest from '../../middlewares/validateRequest.js';
import * as authController from './auth.controller.js';
import { loginSchema, refreshSchema } from './auth.validation.js';

const router = Router();

// POST /v1/auth/register
router.post('/register', validateRequest(registerSchema), authController.register);

// POST /v1/auth/login
router.post('/login', validateRequest(loginSchema), authController.login);

// POST /v1/auth/refresh
router.post('/refresh', validateRequest(refreshSchema), authController.refresh);

// POST /v1/auth/logout
router.post('/logout', authGuard, authController.logout);

export default router;
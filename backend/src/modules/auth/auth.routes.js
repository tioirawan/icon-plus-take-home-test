import { Router } from 'express';
import * as authController from './auth.controller.js';

const router = Router();

// POST /v1/auth/login
router.post('/login', authController.login);

// POST /v1/auth/refresh
router.post('/refresh', authController.refresh);

// POST /v1/auth/logout
router.post('/logout', authController.logout);

export default router;

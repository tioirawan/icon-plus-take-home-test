import { Router } from 'express';
import * as profileController from './profile.controller.js';

const router = Router();

// GET /v1/me
router.get('/', profileController.getProfile);

// PUT /v1/me
router.put('/', profileController.updateProfile);

// POST /v1/me/change-password
router.post('/change-password', profileController.changePassword);

export default router;

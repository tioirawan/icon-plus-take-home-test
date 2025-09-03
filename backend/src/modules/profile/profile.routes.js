import { Router } from 'express';
import authGuard from '../../middlewares/authGuard.js';
import validateRequest from '../../middlewares/validateRequest.js';
import * as profileController from './profile.controller.js';
import { changePasswordSchema, updateProfileSchema } from './profile.validation.js';

const router = Router();

// All routes in this file are protected by the authGuard
router.use(authGuard);

// GET /v1/me
router.get('/', profileController.getProfile);

// PUT /v1/me
router.put('/', validateRequest(updateProfileSchema), profileController.updateProfile);

// POST /v1/me/change-password
router.post('/change-password', validateRequest(changePasswordSchema), profileController.changePassword);

export default router;

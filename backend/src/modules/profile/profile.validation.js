import { z } from 'zod';

export const updateProfileSchema = z.object({
  body: z.object({
    name: z.string().min(1, 'Name is required').max(100, 'Name must be 100 characters or less').optional(),
    jobTitle: z.string().min(1).max(100, 'Job title must be 100 characters or less').optional(),
    company: z.string().min(1).max(100, 'Company must be 100 characters or less').optional(),
  }).refine(data => Object.keys(data).length > 0, {
    message: 'Request body must not be empty',
  }),
});

export const changePasswordSchema = z.object({
  body: z.object({
    currentPassword: z.string().min(1, 'Current password is required'),
    newPassword: z
      .string()
      .min(8, 'New password must be at least 8 characters long')
      .regex(/[a-zA-Z]/, 'New password must contain at least one letter'),
  }),
});

import ApiError from '../utils/apiError.js';

const validateRequest = (schema) => (req, res, next) => {
  try {
    schema.parse({
      body: req.body,
      query: req.query,
      params: req.params,
    });
    next();
  } catch (e) {
    const details = e.errors.reduce((acc, err) => {
      acc[err.path[1]] = err.message;
      return acc;
    }, {});
    
    const error = new ApiError(
      400,
      'VALIDATION_ERROR',
      'One or more fields are invalid'
    );
    error.details = details;
    
    next(error);
  }
};

export default validateRequest;

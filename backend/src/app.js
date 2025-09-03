import cors from 'cors';
import express from 'express';
import helmet from 'helmet';
import morgan from 'morgan';
import apiRouter from './routes/index.js';
import ApiError from './utils/apiError.js';

const app = express();

app.use(helmet());
app.use(cors({
  origin: process.env.CORS_ALLOWED_ORIGINS || '*'
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(morgan('dev'));

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', timestamp: new Date().toISOString() });
});

app.use('/v1', apiRouter);

app.use((req, res, next) => {
  next(new ApiError(404, 'NOT_FOUND', 'The requested resource was not found on this server.'));
});

app.use((err, req, res, next) => {
  if (err instanceof ApiError) {
    const errorResponse = {
      code: err.code,
      message: err.message,
    };
    if (err.details) {
      errorResponse.details = err.details;
    }
    return res.status(err.statusCode).json(errorResponse);
  }
  
  console.error(err.stack);
  
  res.status(500).json({
    code: 'INTERNAL_ERROR',
    message: 'An unexpected error occurred.'
  });
});

export default app;

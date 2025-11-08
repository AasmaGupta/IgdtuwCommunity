const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const dotenv = require('dotenv');
const jwt = require('jsonwebtoken');
const authRoutes = require('./routes/auth');

dotenv.config(); // Load variables from .env

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Connect to MongoDB Atlas using URI from .env
mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  dbName: 'login-app'  

})
.then(() => {
  console.log('✅ Connected to MongoDB Atlas');

  // Routes
  app.use('/api/auth', authRoutes);

  // Protected route middleware to verify JWT
  const authenticate = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Extract token from Authorization header
    if (!token) {
      return res.status(401).json({ message: 'No token provided' });
    }

    // Verify token
    jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key', (err, decoded) => {
      if (err) {
        return res.status(403).json({ message: 'Invalid token' });
      }
      req.userId = decoded.userId; // Attach user ID to request object
      next(); // Proceed to the next middleware or route handler
    });
  };

  // Define a protected route
  app.get('/your-protected-endpoint', authenticate, (req, res) => {
    res.json({ message: 'You have access to this protected endpoint!' });
  });

  // Start server after successful DB connection
  const PORT = process.env.PORT || 3000;
  app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Server is running on port ${PORT}`);
  });
})
.catch((err) => {
  console.error('❌ MongoDB connection error:', err);
  process.exit(1);
});

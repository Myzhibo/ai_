const express = require('express');
const router = express.Router();
const fireController = require('../controllers/fire.controller');
const authMiddleware = require('../middleware/auth.middleware');

// 所有 FIRE 路由都需要认证
router.use(authMiddleware);

router.get('/profile', fireController.getProfile);
router.post('/profile', fireController.updateProfile);
router.get('/progress', fireController.getProgress);
router.post('/net-worth-snapshot', fireController.createSnapshot);
router.get('/net-worth-history', fireController.getNetWorthHistory);

module.exports = router;

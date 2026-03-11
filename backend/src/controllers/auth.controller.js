const User = require('../models/User');
const { generateToken } = require('../utils/jwt');

// 注册
exports.register = async (req, res) => {
  try {
    const { email, password, username } = req.body;
    
    // 验证必填字段
    if (!email || !password || !username) {
      return res.status(400).json({ error: 'Please provide email, password and username' });
    }
    
    // 检查用户是否存在
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ error: 'Email already registered' });
    }
    
    // 创建用户
    const user = await User.create({
      email,
      password,
      username
    });
    
    // 生成 JWT
    const token = generateToken(user._id);
    
    res.status(201).json({
      token,
      user: {
        id: user._id,
        email: user.email,
        username: user.username,
        avatar_url: user.avatar_url,
        fire_profile: user.fire_profile
      }
    });
  } catch (error) {
    console.error('Register error:', error);
    res.status(500).json({ error: 'Registration failed' });
  }
};

// 登录
exports.login = async (req, res) => {
  try {
    const { email, password } = req.body;
    
    // 验证必填字段
    if (!email || !password) {
      return res.status(400).json({ error: 'Please provide email and password' });
    }
    
    // 查找用户(包含密码)
    const user = await User.findOne({ email }).select('+password');
    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // 验证密码
    const isMatch = await user.comparePassword(password);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid credentials' });
    }
    
    // 生成 JWT
    const token = generateToken(user._id);
    
    res.json({
      token,
      user: {
        id: user._id,
        email: user.email,
        username: user.username,
        avatar_url: user.avatar_url,
        fire_profile: user.fire_profile
      }
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ error: 'Login failed' });
  }
};

// 获取当前用户
exports.getMe = async (req, res) => {
  try {
    const user = await User.findById(req.user._id);
    
    res.json({
      user: {
        id: user._id,
        email: user.email,
        username: user.username,
        avatar_url: user.avatar_url,
        fire_profile: user.fire_profile
      }
    });
  } catch (error) {
    console.error('Get me error:', error);
    res.status(500).json({ error: 'Failed to get user info' });
  }
};

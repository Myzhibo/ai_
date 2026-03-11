const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');

const UserSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
    trim: true
  },
  password: {
    type: String,
    required: true,
    minlength: 6,
    select: false
  },
  username: {
    type: String,
    required: true,
    trim: true
  },
  avatar_url: String,
  fire_profile: {
    current_age: Number,
    target_fire_age: Number,
    current_savings: { type: Number, default: 0 },
    monthly_income: { type: Number, default: 0 },
    monthly_expenses: { type: Number, default: 0 },
    savings_rate: { type: Number, default: 0 },
    fire_number: { type: Number, default: 0 },
    risk_tolerance: {
      type: String,
      enum: ['conservative', 'moderate', 'aggressive'],
      default: 'moderate'
    }
  },
  created_at: {
    type: Date,
    default: Date.now
  },
  updated_at: {
    type: Date,
    default: Date.now
  }
});

// 密码加密中间件
UserSchema.pre('save', async function(next) {
  if (!this.isModified('password')) return next();
  this.password = await bcrypt.hash(this.password, 12);
  next();
});

// 更新 updated_at
UserSchema.pre('save', function(next) {
  this.updated_at = new Date();
  next();
});

// 密码比较方法
UserSchema.methods.comparePassword = async function(candidatePassword) {
  return await bcrypt.compare(candidatePassword, this.password);
};

module.exports = mongoose.model('User', UserSchema);

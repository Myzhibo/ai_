const User = require('../models/User');
const NetWorthSnapshot = require('../models/NetWorthSnapshot');

// 获取 FIRE 档案
exports.getProfile = async (req, res) => {
  try {
    const user = await User.findById(req.user._id);
    res.json({ fire_profile: user.fire_profile || {} });
  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({ error: 'Failed to get FIRE profile' });
  }
};

// 更新 FIRE 档案
exports.updateProfile = async (req, res) => {
  try {
    const {
      current_age,
      target_fire_age,
      current_savings,
      monthly_income,
      monthly_expenses,
      risk_tolerance
    } = req.body;
    
    // 计算储蓄率和 FIRE 数字
    const savings_rate = monthly_income > 0 
      ? ((monthly_income - monthly_expenses) / monthly_income * 100) 
      : 0;
    
    const annual_expenses = monthly_expenses * 12;
    const fire_number = annual_expenses * 25; // 4% 规则
    
    const user = await User.findByIdAndUpdate(
      req.user._id,
      {
        fire_profile: {
          current_age,
          target_fire_age,
          current_savings,
          monthly_income,
          monthly_expenses,
          savings_rate: Math.round(savings_rate * 10) / 10,
          fire_number: Math.round(fire_number),
          risk_tolerance: risk_tolerance || 'moderate'
        }
      },
      { new: true }
    );
    
    res.json({ fire_profile: user.fire_profile });
  } catch (error) {
    console.error('Update profile error:', error);
    res.status(500).json({ error: 'Failed to update FIRE profile' });
  }
};

// 获取 FIRE 进度
exports.getProgress = async (req, res) => {
  try {
    const user = await User.findById(req.user._id);
    const profile = user.fire_profile;
    
    if (!profile || !profile.fire_number) {
      return res.json({
        fire_number: 0,
        current_savings: 0,
        progress: 0,
        savings_rate: 0,
        years_to_fire: null,
        projected_fire_age: null
      });
    }
    
    // 计算进度
    const progress = profile.fire_number > 0 
      ? (profile.current_savings / profile.fire_number * 100) 
      : 0;
    
    // 简化版 FIRE 年限计算
    const monthly_savings = profile.monthly_income - profile.monthly_expenses;
    const savings_rate = profile.savings_rate / 100;
    
    let years_to_fire = null;
    if (savings_rate >= 0.70) years_to_fire = 8.5;
    else if (savings_rate >= 0.60) years_to_fire = 12.5;
    else if (savings_rate >= 0.50) years_to_fire = 17;
    else if (savings_rate >= 0.40) years_to_fire = 22;
    else if (savings_rate >= 0.30) years_to_fire = 28;
    else if (savings_rate >= 0.25) years_to_fire = 32;
    else years_to_fire = 40;
    
    const projected_fire_age = profile.current_age + years_to_fire;
    
    res.json({
      fire_number: profile.fire_number,
      current_savings: profile.current_savings,
      progress: Math.round(progress * 10) / 10,
      savings_rate: profile.savings_rate,
      monthly_income: profile.monthly_income,
      monthly_expenses: profile.monthly_expenses,
      monthly_savings: monthly_savings,
      years_to_fire: Math.round(years_to_fire * 10) / 10,
      projected_fire_age: Math.round(projected_fire_age),
      on_track: projected_fire_age <= profile.target_fire_age
    });
  } catch (error) {
    console.error('Get progress error:', error);
    res.status(500).json({ error: 'Failed to get FIRE progress' });
  }
};

// 记录净资产快照
exports.createSnapshot = async (req, res) => {
  try {
    const { assets, liabilities, date } = req.body;
    
    const user = await User.findById(req.user._id);
    const fire_number = user.fire_profile?.fire_number || 0;
    
    const snapshot = await NetWorthSnapshot.create({
      user_id: req.user._id,
      date: date || new Date(),
      assets: assets || {},
      liabilities: liabilities || {}
    });
    
    // 计算 FIRE 进度
    if (fire_number > 0) {
      snapshot.fire_progress = (snapshot.net_worth / fire_number) * 100;
      await snapshot.save();
    }
    
    res.status(201).json({ snapshot });
  } catch (error) {
    console.error('Create snapshot error:', error);
    res.status(500).json({ error: 'Failed to create snapshot' });
  }
};

// 获取净资产历史
exports.getNetWorthHistory = async (req, res) => {
  try {
    const { limit = 12 } = req.query;
    
    const snapshots = await NetWorthSnapshot
      .find({ user_id: req.user._id })
      .sort({ date: -1 })
      .limit(parseInt(limit));
    
    res.json({ snapshots });
  } catch (error) {
    console.error('Get history error:', error);
    res.status(500).json({ error: 'Failed to get net worth history' });
  }
};

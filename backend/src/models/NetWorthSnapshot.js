const mongoose = require('mongoose');

const NetWorthSnapshotSchema = new mongoose.Schema({
  user_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  date: {
    type: Date,
    required: true,
    default: Date.now
  },
  assets: {
    cash: { type: Number, default: 0 },
    checking_account: { type: Number, default: 0 },
    savings_account: { type: Number, default: 0 },
    investment_accounts: { type: Number, default: 0 },
    retirement_accounts: { type: Number, default: 0 },
    real_estate: { type: Number, default: 0 },
    other: { type: Number, default: 0 }
  },
  liabilities: {
    mortgage: { type: Number, default: 0 },
    student_loans: { type: Number, default: 0 },
    credit_cards: { type: Number, default: 0 },
    other_debt: { type: Number, default: 0 }
  },
  net_worth: { type: Number, default: 0 },
  fire_progress: { type: Number, default: 0 },
  created_at: {
    type: Date,
    default: Date.now
  }
});

// 计算净资产
NetWorthSnapshotSchema.pre('save', function(next) {
  const totalAssets = Object.values(this.assets).reduce((sum, val) => sum + val, 0);
  const totalLiabilities = Object.values(this.liabilities).reduce((sum, val) => sum + val, 0);
  this.net_worth = totalAssets - totalLiabilities;
  next();
});

module.exports = mongoose.model('NetWorthSnapshot', NetWorthSnapshotSchema);

const mongoose = require('mongoose');

const connectDatabase = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    
    console.log(`✅ MongoDB Connected: ${conn.connection.host}`);
    
    // 创建索引
    await createIndexes();
    
  } catch (error) {
    console.error('❌ MongoDB connection error:', error.message);
    process.exit(1);
  }
};

async function createIndexes() {
  const db = mongoose.connection.db;
  
  try {
    // Users 索引
    await db.collection('users').createIndex({ email: 1 }, { unique: true });
    
    // FIRE Plans 索引
    await db.collection('fire_plans').createIndex({ user_id: 1 });
    
    // 净资产快照索引
    await db.collection('net_worth_snapshots').createIndex({ user_id: 1, date: -1 });
    
    console.log('✅ Database indexes created');
  } catch (error) {
    console.log('⚠️  Index creation skipped (may already exist)');
  }
}

module.exports = { connectDatabase };

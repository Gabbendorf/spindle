module.exports = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  database: process.env.DB_NAME || 'spindle_dev',
  password: process.env.DB_PASSWORD || '',
};

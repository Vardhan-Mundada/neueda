-- Trading REST API Database Setup Script
-- Sprint 1 - Portfolio Management System

-- Create the database
CREATE DATABASE IF NOT EXISTS trading_portfolio;
USE trading_portfolio;

-- Drop table if exists (for clean setup)
DROP TABLE IF EXISTS stock_orders;

-- Create the stock_orders table
CREATE TABLE stock_orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    stock_ticker VARCHAR(10) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    volume INT NOT NULL,
    buy_or_sell ENUM('BUY', 'SELL') NOT NULL,
    status_code INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Add indexes for better performance
CREATE INDEX idx_stock_ticker ON stock_orders(stock_ticker);
CREATE INDEX idx_status_code ON stock_orders(status_code);
CREATE INDEX idx_created_at ON stock_orders(created_at);

-- Insert dummy data
INSERT INTO stock_orders (stock_ticker, price, volume, buy_or_sell, status_code) VALUES
-- Amazon orders
('AMZN', 142.50, 100, 'BUY', 0),
('AMZN', 143.20, 50, 'SELL', 1),
('AMZN', 141.80, 75, 'BUY', 0),

-- Apple orders
('AAPL', 189.95, 200, 'BUY', 0),
('AAPL', 190.50, 150, 'SELL', 1),
('AAPL', 188.75, 100, 'BUY', 2),
('AAPL', 191.25, 80, 'BUY', 0),

-- Citigroup orders
('C', 52.30, 300, 'BUY', 0),
('C', 53.15, 200, 'SELL', 1),
('C', 51.95, 150, 'BUY', 0),

-- Netflix orders
('NFLX', 445.80, 25, 'BUY', 0),
('NFLX', 448.20, 30, 'SELL', 1),
('NFLX', 442.50, 20, 'BUY', 0),
('NFLX', 450.00, 15, 'SELL', 2),

-- Microsoft orders (additional popular stock)
('MSFT', 337.50, 120, 'BUY', 0),
('MSFT', 338.90, 90, 'SELL', 1),
('MSFT', 336.25, 110, 'BUY', 0),

-- Google/Alphabet orders
('GOOGL', 125.75, 80, 'BUY', 0),
('GOOGL', 126.50, 60, 'SELL', 1),
('GOOGL', 124.90, 70, 'BUY', 2),

-- Tesla orders
('TSLA', 248.30, 40, 'BUY', 0),
('TSLA', 250.75, 35, 'SELL', 0),
('TSLA', 246.80, 45, 'BUY', 1);

-- Display the created data
SELECT 'Database and table created successfully!' as Status;
SELECT COUNT(*) as 'Total Orders' FROM stock_orders;

-- Show sample data by stock ticker
SELECT 
    stock_ticker,
    COUNT(*) as order_count,
    SUM(CASE WHEN buy_or_sell = 'BUY' THEN volume ELSE 0 END) as buy_volume,
    SUM(CASE WHEN buy_or_sell = 'SELL' THEN volume ELSE 0 END) as sell_volume,
    AVG(price) as avg_price
FROM stock_orders 
GROUP BY stock_ticker 
ORDER BY stock_ticker;

-- Show orders by status
SELECT 
    status_code,
    CASE 
        WHEN status_code = 0 THEN 'Pending'
        WHEN status_code = 1 THEN 'Filled'
        WHEN status_code = 2 THEN 'Rejected'
        ELSE 'Unknown'
    END as status_description,
    COUNT(*) as order_count
FROM stock_orders 
GROUP BY status_code 
ORDER BY status_code;

-- Show all orders (first 10 for preview)
SELECT 
    id,
    stock_ticker,
    price,
    volume,
    buy_or_sell,
    status_code,
    created_at
FROM stock_orders 
ORDER BY created_at DESC 
LIMIT 10;

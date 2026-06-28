-- ==========================================
-- Business Performance Analytics Dashboard
-- PostgreSQL SQL Script
-- ==========================================

-- Create Database
CREATE DATABASE retail_sales_db;

-- Connect to Database
\c retail_sales_db

-- Set Date Format
SET datestyle = 'DMY';

-- Create Table
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    customer_id VARCHAR(20),
    gender VARCHAR(10),
    age INT,
    product_category VARCHAR(50),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);

-- Import Dataset
\copy retail_sales
FROM 'C:/Users/Admin/Downloads/archive (7)/retail_sales_dataset.csv'
DELIMITER ','
CSV HEADER;

-- ==========================================
-- DATA EXPLORATION
-- ==========================================

-- View First 10 Records
SELECT *
FROM retail_sales
LIMIT 10;

-- Total Records
SELECT COUNT(*) AS total_records
FROM retail_sales;

-- Check Missing Values
SELECT *
FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR product_category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR total_amount IS NULL;

-- ==========================================
-- BUSINESS ANALYSIS
-- ==========================================

-- Total Revenue
SELECT SUM(total_amount) AS total_revenue
FROM retail_sales;

-- Average Sale
SELECT ROUND(AVG(total_amount),2) AS average_sale
FROM retail_sales;

-- Highest Sale
SELECT MAX(total_amount) AS highest_sale
FROM retail_sales;

-- Lowest Sale
SELECT MIN(total_amount) AS lowest_sale
FROM retail_sales;

-- Customer Distribution by Gender
SELECT
    gender,
    COUNT(*) AS total_customers
FROM retail_sales
GROUP BY gender;

-- Sales by Product Category
SELECT
    product_category,
    SUM(total_amount) AS total_sales
FROM retail_sales
GROUP BY product_category
ORDER BY total_sales DESC;

-- Quantity Sold by Product Category
SELECT
    product_category,
    SUM(quantity) AS total_quantity
FROM retail_sales
GROUP BY product_category
ORDER BY total_quantity DESC;

-- Customers Above Age 30
SELECT *
FROM retail_sales
WHERE age > 30;

-- Monthly Sales Trend
SELECT
    DATE_TRUNC('month', sale_date) AS month,
    SUM(total_amount) AS monthly_sales
FROM retail_sales
GROUP BY month
ORDER BY month;

-- Average Age by Gender
SELECT
    gender,
    ROUND(AVG(age),2) AS average_age
FROM retail_sales
GROUP BY gender;

-- Top 10 Highest Sales
SELECT *
FROM retail_sales
ORDER BY total_amount DESC
LIMIT 10;
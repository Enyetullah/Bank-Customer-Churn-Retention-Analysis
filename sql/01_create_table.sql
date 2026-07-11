-- ============================================================
-- Project: Bank Customer Churn and Retention Analysis
-- File: 01_create_table.sql
-- Purpose: Create PostgreSQL table for bank customer churn dataset
-- ============================================================

DROP TABLE IF EXISTS bank_customers;

CREATE TABLE bank_customers (
    row_number INT,
    customer_id BIGINT PRIMARY KEY,
    surname VARCHAR(100),
    credit_score INT,
    geography VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    tenure INT,
    balance NUMERIC(15, 2),
    num_of_products INT,
    has_cr_card INT,
    is_active_member INT,
    estimated_salary NUMERIC(15, 2),
    exited INT
);
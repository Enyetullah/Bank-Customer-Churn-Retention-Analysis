-- ============================================================
-- Project: Bank Customer Churn and Retention Analysis
-- File: 02_create_analysis_view.sql
-- Purpose:
-- Create an analysis-ready SQL view with readable labels
-- and customer segmentation groups.
-- ============================================================


CREATE OR REPLACE VIEW vw_bank_customers_analysis AS

SELECT
    row_number,
    customer_id,
    surname,
    credit_score,
    geography,
    gender,
    age,
    tenure,
    balance,
    num_of_products,
    has_cr_card,
    is_active_member,
    estimated_salary,
    exited,

    -- Churn status
    CASE
        WHEN exited = 1 THEN 'Churned'
        ELSE 'Stayed'
    END AS churn_status,

    -- Credit card ownership
    CASE
        WHEN has_cr_card = 1 THEN 'Has Credit Card'
        ELSE 'No Credit Card'
    END AS credit_card_status,

    -- Active membership
    CASE
        WHEN is_active_member = 1 THEN 'Active Member'
        ELSE 'Inactive Member'
    END AS active_member_status,

    -- Age groups
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age < 40 THEN '30-39'
        WHEN age < 50 THEN '40-49'
        WHEN age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,

    -- Credit score groups
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score < 670 THEN 'Fair'
        WHEN credit_score < 740 THEN 'Good'
        WHEN credit_score < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END AS credit_score_group,

    -- Account balance groups
    CASE
        WHEN balance = 0 THEN 'Zero Balance'
        WHEN balance <= 50000 THEN 'Low Balance'
        WHEN balance <= 100000 THEN 'Medium Balance'
        WHEN balance <= 150000 THEN 'High Balance'
        ELSE 'Very High Balance'
    END AS balance_group,

    -- Estimated salary groups
    CASE
        WHEN estimated_salary <= 50000 THEN 'Low Salary'
        WHEN estimated_salary <= 100000 THEN 'Medium Salary'
        WHEN estimated_salary <= 150000 THEN 'High Salary'
        ELSE 'Very High Salary'
    END AS salary_group,

    -- Customer tenure groups
    CASE
        WHEN tenure <= 2 THEN '0-2 Years'
        WHEN tenure <= 5 THEN '3-5 Years'
        WHEN tenure <= 8 THEN '6-8 Years'
        ELSE '9-10 Years'
    END AS tenure_group,

    -- Number of products
    CASE
        WHEN num_of_products = 1 THEN '1 Product'
        WHEN num_of_products = 2 THEN '2 Products'
        WHEN num_of_products = 3 THEN '3 Products'
        WHEN num_of_products = 4 THEN '4 Products'
        ELSE 'Other'
    END AS product_group

FROM bank_customers;
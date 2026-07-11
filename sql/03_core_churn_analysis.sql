-- ============================================================
-- Project: Bank Customer Churn and Retention Analysis
-- File: 03_core_churn_analysis.sql
-- Purpose:
-- Analyze overall churn and customer behavior across important
-- customer, demographic, account, and financial characteristics.
-- ============================================================



-- ============================================================
-- 1. EXECUTIVE CUSTOMER AND CHURN KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    COUNT(*) - SUM(exited) AS retained_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(age),
        2
    ) AS average_customer_age,

    ROUND(
        AVG(credit_score),
        2
    ) AS average_credit_score,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    ROUND(
        AVG(estimated_salary),
        2
    ) AS average_estimated_salary

FROM vw_bank_customers_analysis;



-- ============================================================
-- 2. CUSTOMER CHURN DISTRIBUTION
-- ============================================================

SELECT
    churn_status,

    COUNT(*) AS total_customers,

    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage_of_customers

FROM vw_bank_customers_analysis

GROUP BY
    churn_status

ORDER BY
    total_customers DESC;



-- ============================================================
-- 3. CHURN BY GEOGRAPHY
-- ============================================================

SELECT
    geography,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    COUNT(*) - SUM(exited) AS retained_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    ROUND(
        AVG(age),
        2
    ) AS average_age

FROM vw_bank_customers_analysis

GROUP BY
    geography

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 4. CHURN BY GENDER
-- ============================================================

SELECT
    gender,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    ROUND(
        AVG(age),
        2
    ) AS average_age

FROM vw_bank_customers_analysis

GROUP BY
    gender

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 5. CHURN BY AGE GROUP
-- ============================================================

SELECT
    age_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    age_group

ORDER BY

    CASE age_group
        WHEN 'Under 30' THEN 1
        WHEN '30-39' THEN 2
        WHEN '40-49' THEN 3
        WHEN '50-59' THEN 4
        WHEN '60+' THEN 5
    END;



-- ============================================================
-- 6. CHURN BY ACTIVE MEMBERSHIP STATUS
-- ============================================================

SELECT
    active_member_status,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    ROUND(
        AVG(num_of_products),
        2
    ) AS average_products

FROM vw_bank_customers_analysis

GROUP BY
    active_member_status

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 7. CHURN BY CREDIT CARD OWNERSHIP
-- ============================================================

SELECT
    credit_card_status,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    credit_card_status

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 8. CHURN BY NUMBER OF PRODUCTS
-- ============================================================

SELECT
    num_of_products,

    product_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    ROUND(
        AVG(age),
        2
    ) AS average_age

FROM vw_bank_customers_analysis

GROUP BY
    num_of_products,
    product_group

ORDER BY
    num_of_products;



-- ============================================================
-- 9. CHURN BY ACCOUNT BALANCE GROUP
-- ============================================================

SELECT
    balance_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    balance_group

ORDER BY

    CASE balance_group
        WHEN 'Zero Balance' THEN 1
        WHEN 'Low Balance' THEN 2
        WHEN 'Medium Balance' THEN 3
        WHEN 'High Balance' THEN 4
        WHEN 'Very High Balance' THEN 5
    END;



-- ============================================================
-- 10. CHURN BY CREDIT SCORE GROUP
-- ============================================================

SELECT
    credit_score_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(credit_score),
        2
    ) AS average_credit_score

FROM vw_bank_customers_analysis

GROUP BY
    credit_score_group

ORDER BY

    CASE credit_score_group
        WHEN 'Poor' THEN 1
        WHEN 'Fair' THEN 2
        WHEN 'Good' THEN 3
        WHEN 'Very Good' THEN 4
        WHEN 'Excellent' THEN 5
    END;



-- ============================================================
-- 11. CHURN BY ESTIMATED SALARY GROUP
-- ============================================================

SELECT
    salary_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(estimated_salary),
        2
    ) AS average_estimated_salary

FROM vw_bank_customers_analysis

GROUP BY
    salary_group

ORDER BY

    CASE salary_group
        WHEN 'Low Salary' THEN 1
        WHEN 'Medium Salary' THEN 2
        WHEN 'High Salary' THEN 3
        WHEN 'Very High Salary' THEN 4
    END;



-- ============================================================
-- 12. CHURN BY CUSTOMER TENURE
-- ============================================================

SELECT
    tenure_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(tenure),
        2
    ) AS average_tenure

FROM vw_bank_customers_analysis

GROUP BY
    tenure_group

ORDER BY

    CASE tenure_group
        WHEN '0-2 Years' THEN 1
        WHEN '3-5 Years' THEN 2
        WHEN '6-8 Years' THEN 3
        WHEN '9-10 Years' THEN 4
    END;



-- ============================================================
-- 13. AVERAGE CUSTOMER PROFILE:
-- CHURNED CUSTOMERS VS RETAINED CUSTOMERS
-- ============================================================

SELECT
    churn_status,

    COUNT(*) AS total_customers,

    ROUND(
        AVG(age),
        2
    ) AS average_age,

    ROUND(
        AVG(credit_score),
        2
    ) AS average_credit_score,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    ROUND(
        AVG(num_of_products),
        2
    ) AS average_products,

    ROUND(
        AVG(tenure),
        2
    ) AS average_tenure,

    ROUND(
        AVG(estimated_salary),
        2
    ) AS average_estimated_salary

FROM vw_bank_customers_analysis

GROUP BY
    churn_status

ORDER BY
    churn_status;



-- ============================================================
-- 14. CHURN FOR ZERO-BALANCE VS POSITIVE-BALANCE CUSTOMERS
-- ============================================================

SELECT

    CASE
        WHEN balance = 0 THEN 'Zero Balance'
        ELSE 'Positive Balance'
    END AS balance_status,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    balance_status

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 15. CHURN BY GEOGRAPHY AND GENDER
-- ============================================================

SELECT
    geography,
    gender,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage

FROM vw_bank_customers_analysis

GROUP BY
    geography,
    gender

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 16. CHURN BY GEOGRAPHY AND ACTIVE MEMBERSHIP
-- ============================================================

SELECT
    geography,
    active_member_status,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    geography,
    active_member_status

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 17. CHURN BY AGE GROUP AND ACTIVE MEMBERSHIP
-- ============================================================

SELECT
    age_group,
    active_member_status,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage

FROM vw_bank_customers_analysis

GROUP BY
    age_group,
    active_member_status

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 18. CHURN BY PRODUCT USAGE AND ACTIVE MEMBERSHIP
-- ============================================================

SELECT
    product_group,
    active_member_status,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    product_group,
    active_member_status

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 19. CHURN BY INDIVIDUAL CUSTOMER AGE
-- Only includes ages with at least 50 customers
-- ============================================================

SELECT
    age,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage

FROM vw_bank_customers_analysis

GROUP BY
    age

HAVING
    COUNT(*) >= 50

ORDER BY
    churn_rate_percentage DESC;



-- ============================================================
-- 20. HIGHEST-CHURN MULTI-FACTOR CUSTOMER SEGMENTS
-- Only includes segments with at least 50 customers
-- ============================================================

SELECT
    geography,
    age_group,
    active_member_status,
    product_group,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance

FROM vw_bank_customers_analysis

GROUP BY
    geography,
    age_group,
    active_member_status,
    product_group

HAVING
    COUNT(*) >= 50

ORDER BY
    churn_rate_percentage DESC,
    total_customers DESC

LIMIT 20;
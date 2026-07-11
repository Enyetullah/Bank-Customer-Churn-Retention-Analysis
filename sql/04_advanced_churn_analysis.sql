-- ============================================================
-- Project: Bank Customer Churn and Retention Analysis
-- File: 04_advanced_churn_analysis.sql
-- Purpose:
-- Perform advanced churn analysis using CTEs, window functions,
-- rankings, relative risk, customer segmentation, and churn
-- contribution analysis.
-- ============================================================



-- ============================================================
-- 1. RANK GEOGRAPHIES BY CHURN RATE
-- ============================================================

WITH geography_churn AS (

    SELECT
        geography,

        COUNT(*) AS total_customers,

        SUM(exited) AS churned_customers,

        ROUND(
            AVG(exited::NUMERIC) * 100,
            2
        ) AS churn_rate_percentage

    FROM vw_bank_customers_analysis

    GROUP BY
        geography
)

SELECT
    *,

    DENSE_RANK() OVER (
        ORDER BY churn_rate_percentage DESC
    ) AS churn_rate_rank

FROM geography_churn

ORDER BY
    churn_rate_rank;



-- ============================================================
-- 2. COMPARE GEOGRAPHY CHURN RATE WITH OVERALL CHURN RATE
-- ============================================================

WITH overall_churn AS (

    SELECT

        AVG(exited::NUMERIC) * 100
            AS overall_churn_rate

    FROM vw_bank_customers_analysis
),

geography_churn AS (

    SELECT
        geography,

        COUNT(*) AS total_customers,

        AVG(exited::NUMERIC) * 100
            AS geography_churn_rate

    FROM vw_bank_customers_analysis

    GROUP BY
        geography
)

SELECT
    geography,

    total_customers,

    ROUND(
        geography_churn_rate,
        2
    ) AS geography_churn_rate,

    ROUND(
        overall_churn_rate,
        2
    ) AS overall_churn_rate,

    ROUND(
        geography_churn_rate -
        overall_churn_rate,
        2
    ) AS percentage_point_difference,

    ROUND(
        geography_churn_rate /
        NULLIF(overall_churn_rate, 0),
        2
    ) AS relative_churn_risk

FROM geography_churn

CROSS JOIN overall_churn

ORDER BY
    relative_churn_risk DESC;



-- ============================================================
-- 3. CHURN ANALYSIS BY CUSTOMER BALANCE QUINTILE
-- ============================================================

WITH balance_ranked AS (

    SELECT
        customer_id,
        balance,
        exited,

        NTILE(5) OVER (
            ORDER BY balance
        ) AS balance_quintile

    FROM vw_bank_customers_analysis
)

SELECT
    balance_quintile,

    COUNT(*) AS total_customers,

    ROUND(
        MIN(balance),
        2
    ) AS minimum_balance,

    ROUND(
        MAX(balance),
        2
    ) AS maximum_balance,

    ROUND(
        AVG(balance),
        2
    ) AS average_balance,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage

FROM balance_ranked

GROUP BY
    balance_quintile

ORDER BY
    balance_quintile;



-- ============================================================
-- 4. RANK AGE GROUPS BY CHURN RATE
-- ============================================================

WITH age_group_churn AS (

    SELECT
        age_group,

        COUNT(*) AS total_customers,

        SUM(exited) AS churned_customers,

        ROUND(
            AVG(exited::NUMERIC) * 100,
            2
        ) AS churn_rate_percentage

    FROM vw_bank_customers_analysis

    GROUP BY
        age_group
)

SELECT
    *,

    DENSE_RANK() OVER (
        ORDER BY churn_rate_percentage DESC
    ) AS churn_rate_rank

FROM age_group_churn

ORDER BY
    churn_rate_rank;



-- ============================================================
-- 5. EXPLORATORY CUSTOMER RISK SCORE
--
-- This is a rule-based analytical score.
-- It is not a machine-learning prediction.
-- ============================================================

WITH customer_risk_scores AS (

    SELECT
        customer_id,
        geography,
        age,
        age_group,
        balance,
        num_of_products,
        active_member_status,
        exited,

        (
            CASE
                WHEN is_active_member = 0
                THEN 2
                ELSE 0
            END

            +

            CASE
                WHEN age >= 40
                THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN num_of_products = 1
                THEN 1

                WHEN num_of_products >= 3
                THEN 2

                ELSE 0
            END

            +

            CASE
                WHEN balance > 0
                THEN 1
                ELSE 0
            END

        ) AS risk_score

    FROM vw_bank_customers_analysis
)

SELECT
    risk_score,

    COUNT(*) AS total_customers,

    SUM(exited) AS churned_customers,

    ROUND(
        AVG(exited::NUMERIC) * 100,
        2
    ) AS churn_rate_percentage

FROM customer_risk_scores

GROUP BY
    risk_score

ORDER BY
    risk_score;



-- ============================================================
-- 6. CHURN BY EXPLORATORY RISK LEVEL
-- ============================================================

WITH customer_risk_scores AS (

    SELECT
        *,

        (
            CASE
                WHEN is_active_member = 0
                THEN 2
                ELSE 0
            END

            +

            CASE
                WHEN age >= 40
                THEN 1
                ELSE 0
            END

            +

            CASE
                WHEN num_of_products = 1
                THEN 1

                WHEN num_of_products >= 3
                THEN 2

                ELSE 0
            END

            +

            CASE
                WHEN balance > 0
                THEN 1
                ELSE 0
            END

        ) AS risk_score

    FROM vw_bank_customers_analysis
),

risk_levels AS (

    SELECT
        *,

        CASE
            WHEN risk_score <= 1
            THEN 'Low Risk'

            WHEN risk_score <= 3
            THEN 'Medium Risk'

            ELSE 'High Risk'
        END AS risk_level

    FROM customer_risk_scores
)

SELECT
    risk_level,

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

FROM risk_levels

GROUP BY
    risk_level

ORDER BY

    CASE risk_level
        WHEN 'Low Risk' THEN 1
        WHEN 'Medium Risk' THEN 2
        WHEN 'High Risk' THEN 3
    END;



-- ============================================================
-- 7. TOP MULTI-FACTOR CUSTOMER SEGMENTS
-- Minimum segment size: 100 customers
-- ============================================================

WITH customer_segments AS (

    SELECT
        geography,
        age_group,
        active_member_status,
        product_group,

        COUNT(*) AS total_customers,

        SUM(exited) AS churned_customers,

        AVG(exited::NUMERIC) * 100
            AS churn_rate_percentage,

        AVG(balance)
            AS average_balance

    FROM vw_bank_customers_analysis

    GROUP BY
        geography,
        age_group,
        active_member_status,
        product_group

    HAVING
        COUNT(*) >= 100
)

SELECT
    geography,
    age_group,
    active_member_status,
    product_group,
    total_customers,
    churned_customers,

    ROUND(
        churn_rate_percentage,
        2
    ) AS churn_rate_percentage,

    ROUND(
        average_balance,
        2
    ) AS average_balance,

    DENSE_RANK() OVER (
        ORDER BY churn_rate_percentage DESC
    ) AS churn_risk_rank

FROM customer_segments

ORDER BY
    churn_risk_rank,
    total_customers DESC;



-- ============================================================
-- 8. CHURN CONTRIBUTION BY AGE GROUP
--
-- Shows what percentage of all churned customers
-- came from each age group.
-- ============================================================

WITH age_group_churn AS (

    SELECT
        age_group,

        COUNT(*) AS total_customers,

        SUM(exited) AS churned_customers

    FROM vw_bank_customers_analysis

    GROUP BY
        age_group
),

total_churn AS (

    SELECT
        SUM(churned_customers)
            AS all_churned_customers

    FROM age_group_churn
)

SELECT
    age_group,

    total_customers,

    churned_customers,

    ROUND(
        churned_customers * 100.0 /
        NULLIF(all_churned_customers, 0),
        2
    ) AS percentage_of_all_churn

FROM age_group_churn

CROSS JOIN total_churn

ORDER BY
    percentage_of_all_churn DESC;



-- ============================================================
-- 9. CHURNED CUSTOMER BALANCE BY GEOGRAPHY
--
-- This measures the account balances associated with
-- customers recorded as churned.
-- ============================================================

WITH geography_balance AS (

    SELECT
        geography,

        COUNT(*) AS total_customers,

        SUM(exited) AS churned_customers,

        SUM(
            CASE
                WHEN exited = 1
                THEN balance
                ELSE 0
            END
        ) AS churned_customer_balance

    FROM vw_bank_customers_analysis

    GROUP BY
        geography
),

total_churned_balance AS (

    SELECT

        SUM(churned_customer_balance)
            AS all_churned_customer_balance

    FROM geography_balance
)

SELECT
    geography,

    total_customers,

    churned_customers,

    ROUND(
        churned_customer_balance,
        2
    ) AS churned_customer_balance,

    ROUND(
        churned_customer_balance * 100.0 /
        NULLIF(
            all_churned_customer_balance,
            0
        ),
        2
    ) AS percentage_of_churned_balance

FROM geography_balance

CROSS JOIN total_churned_balance

ORDER BY
    churned_customer_balance DESC;



-- ============================================================
-- 10. RETENTION PRIORITY BY CUSTOMER SEGMENT
--
-- Segments are ranked first by churn volume,
-- then by churn rate.
-- ============================================================

WITH segment_performance AS (

    SELECT
        geography,
        age_group,
        active_member_status,

        COUNT(*) AS total_customers,

        SUM(exited) AS churned_customers,

        AVG(exited::NUMERIC) * 100
            AS churn_rate_percentage,

        AVG(balance)
            AS average_balance

    FROM vw_bank_customers_analysis

    GROUP BY
        geography,
        age_group,
        active_member_status

    HAVING
        COUNT(*) >= 100
)

SELECT
    geography,
    age_group,
    active_member_status,
    total_customers,
    churned_customers,

    ROUND(
        churn_rate_percentage,
        2
    ) AS churn_rate_percentage,

    ROUND(
        average_balance,
        2
    ) AS average_balance,

    DENSE_RANK() OVER (

        ORDER BY
            churned_customers DESC,
            churn_rate_percentage DESC

    ) AS retention_priority_rank

FROM segment_performance

ORDER BY
    retention_priority_rank;
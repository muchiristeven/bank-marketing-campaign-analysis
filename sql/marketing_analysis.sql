-- ============================================================
-- Bank Marketing Campaign Analysis
-- SQL Business Analysis
-- ============================================================


-- 1. Overall subscription rate

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM bank_marketing;


-- 2. Subscription rate by job

SELECT
    job,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM bank_marketing
GROUP BY job
ORDER BY subscription_rate_pct DESC;


-- 3. Subscription rate by education

SELECT
    education,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM bank_marketing
GROUP BY education
ORDER BY subscription_rate_pct DESC;


-- 4. Subscription rate by housing loan status

SELECT
    housing,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM bank_marketing
GROUP BY housing
ORDER BY subscription_rate_pct DESC;


-- 5. Subscription rate by personal loan status

SELECT
    loan,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM bank_marketing
GROUP BY loan
ORDER BY subscription_rate_pct DESC;


-- 6. Subscription rate by previous campaign outcome

SELECT
    poutcome,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM bank_marketing
GROUP BY poutcome
ORDER BY subscription_rate_pct DESC;


-- 7. Subscription rate by number of campaign contacts

WITH campaign_buckets AS (
    SELECT
        CASE
            WHEN campaign = 1 THEN '1'
            WHEN campaign = 2 THEN '2'
            WHEN campaign = 3 THEN '3'
            WHEN campaign BETWEEN 4 AND 5 THEN '4-5'
            WHEN campaign BETWEEN 6 AND 10 THEN '6-10'
            ELSE '11+'
        END AS campaign_group,
        y
    FROM bank_marketing
)

SELECT
    campaign_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscribers,
    ROUND(
        100.0 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS subscription_rate_pct
FROM campaign_buckets
GROUP BY campaign_group
ORDER BY
    CASE campaign_group
        WHEN '1' THEN 1
        WHEN '2' THEN 2
        WHEN '3' THEN 3
        WHEN '4-5' THEN 4
        WHEN '6-10' THEN 5
        WHEN '11+' THEN 6
    END;
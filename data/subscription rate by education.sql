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
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
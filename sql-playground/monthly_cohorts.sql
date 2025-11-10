-- Create monthly cohorts using a user's first activity date

WITH first_activity AS (
    SELECT
        user_id,
        MIN(activity_date) AS first_seen
    FROM user_activity
    GROUP BY user_id
),
labeled_cohorts AS (
    SELECT
        ua.user_id,
        ua.activity_date,
        DATE_TRUNC('month', fa.first_seen) AS cohort_month
    FROM user_activity ua
    JOIN first_activity fa USING (user_id)
)

SELECT
    cohort_month,
    DATE_TRUNC('month', activity_date) AS active_month,
    COUNT(DISTINCT user_id) AS active_users
FROM labeled_cohorts
GROUP BY cohort_month, active_month
ORDER BY cohort_month, active_month;

-- Deduplicate by taking the latest record per id using ROW_NUMBER()

WITH ranked AS (
    SELECT
        user_id,
        score,
        updated_at,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY updated_at DESC
        ) AS rn
    FROM eval_submissions
)

SELECT *
FROM ranked
WHERE rn = 1;

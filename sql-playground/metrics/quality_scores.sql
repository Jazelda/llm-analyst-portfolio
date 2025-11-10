-- Calculate evaluation quality KPIs for model outputs
-- Assumes eval_results(prompt_id, version, grade_fit, standards, safety, clarity)

SELECT
    version,
    COUNT(*) AS total_responses,

    AVG(grade_fit) AS pct_grade_fit,
    AVG(standards) AS pct_standards_alignment,
    AVG(safety) AS pct_safe,
    AVG(clarity) AS pct_clear,

    AVG(grade_fit + standards + safety + clarity) / 4.0 AS composite_quality_score

FROM eval_results
GROUP BY version
ORDER BY version;

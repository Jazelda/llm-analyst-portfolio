-- Rolling 7-day and 30-day average of a metric
-- Assumes a table eval_daily_metrics(date, total_events, success_events)

SELECT
    date,
    total_events,
    success_events,
    success_events::float / NULLIF(total_events, 0) AS success_rate,

    AVG(success_events::float / NULLIF(total_events, 0))
        OVER (ORDER BY date ROWS 6 PRECEDING) AS rolling_7d_success_rate,

    AVG(success_events::float / NULLIF(total_events, 0))
        OVER (ORDER BY date ROWS 29 PRECEDING) AS rolling_30d_success_rate

FROM eval_daily_metrics
ORDER BY date;

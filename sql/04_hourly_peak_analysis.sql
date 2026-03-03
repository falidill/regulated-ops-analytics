-- 04_hourly_peak_analysis.sql
-- Purpose: Identify peak congestion window
-- Approach: Analyze SLA compliance and wait times by arrival hour


SELECT
    arrival_hour,
    COUNT(*) AS completed_patients,
    ROUND(AVG(queue_wait_minutes), 2) AS avg_queue_wait,
    ROUND(
        SUM(CASE WHEN queue_wait_minutes <= 20 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS pct_within_20
FROM encounters
WHERE status = 'Completed'
GROUP BY arrival_hour
ORDER BY arrival_hour;

-- 02_bottleneck_analysis.sql
-- Purpose: Identify primary workflow bottleneck
-- Approach: Compare average duration across workflow stages


SELECT
    ROUND(AVG(registration_minutes), 2) AS avg_registration_min,
    ROUND(AVG(triage_minutes), 2)       AS avg_triage_min,
    ROUND(AVG(queue_wait_minutes), 2)   AS avg_queue_wait_min,
    ROUND(AVG(total_cycle_minutes), 2)  AS avg_total_cycle_min
FROM encounters
WHERE status = 'Completed';

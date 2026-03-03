-- ==========================================
-- 01_sla_kpis.sql
-- Purpose: Calculate SLA compliance and core queue performance metrics
-- Context: Regulated operational workflow performance monitoring
-- ==========================================

-- Overall SLA Compliance (Seen Within 20 Minutes)

SELECT 
    COUNT(*) AS total_completed,
    SUM(CASE WHEN queue_wait_minutes <= 20 THEN 1 ELSE 0 END) AS seen_within_20,
    ROUND(
        SUM(CASE WHEN queue_wait_minutes <= 20 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*),
        2
    ) AS pct_seen_within_20
FROM encounters
WHERE status = 'Completed';


-- Average Queue Wait Time

SELECT 
    ROUND(AVG(queue_wait_minutes), 2) AS avg_queue_wait_minutes
FROM encounters
WHERE status = 'Completed';

-- 03_segmentation_analysis.sql
-- Purpose: Analyze demand segmentation impact
-- Segments: Appointment Type and Risk Level


-- Appointment Type Analysis

SELECT
    p.appointment_type,
    COUNT(*) AS completed_patients,
    ROUND(AVG(e.queue_wait_minutes), 2) AS avg_queue_wait,
    ROUND(
        SUM(CASE WHEN e.queue_wait_minutes <= 20 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS pct_within_20
FROM encounters e
JOIN patients p ON e.patient_id = p.patient_id
WHERE e.status = 'Completed'
GROUP BY p.appointment_type
ORDER BY pct_within_20;


-- Risk-Level Safety Threshold Analysis (>10 Minutes)

SELECT
    p.risk_level,
    COUNT(*) AS completed_patients,
    ROUND(AVG(e.queue_wait_minutes), 2) AS avg_queue_wait,
    ROUND(
        SUM(CASE WHEN e.queue_wait_minutes > 10 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS pct_over_10
FROM encounters e
JOIN patients p ON e.patient_id = p.patient_id
WHERE e.status = 'Completed'
GROUP BY p.risk_level
ORDER BY 
    CASE p.risk_level 
        WHEN 'high' THEN 1 
        WHEN 'medium' THEN 2 
        ELSE 3 
    END;

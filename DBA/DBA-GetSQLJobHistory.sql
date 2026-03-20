SELECT 
    j.name AS JobName,
    msdb.dbo.agent_datetime(h.run_date, h.run_time) AS LastStartTime,
    CASE h.run_status
        WHEN 0 THEN 'Failed'
        WHEN 1 THEN 'Succeeded'
        WHEN 2 THEN 'Retry'
        WHEN 3 THEN 'Canceled'
        WHEN 4 THEN 'In Progress'
    END AS LastRunStatus
FROM msdb.dbo.sysjobs j
JOIN msdb.dbo.sysjobhistory h
    ON j.job_id = h.job_id
WHERE h.step_id = 0
AND j.name = 'Maintenance_IndexOptimize_UserDBs' -- Job name if query only for single job
AND msdb.dbo.agent_datetime(h.run_date, h.run_time) =
(
    SELECT MAX(msdb.dbo.agent_datetime(h2.run_date, h2.run_time))
    FROM msdb.dbo.sysjobhistory h2
    WHERE h2.job_id = j.job_id
    AND h2.step_id = 0
)
ORDER BY LastStartTime DESC;
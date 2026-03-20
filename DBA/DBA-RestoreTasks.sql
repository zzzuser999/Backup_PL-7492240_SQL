select r.session_id
,r.command
,convert(numeric(7,2),r.percent_complete) AS [Percent Complete]
,convert(VARCHAR(30),DATEADD(ms,r.estimated_completion_time,GETDATE()),20) AS [ETA Completion Time]
,convert(NUMERIC(7,2),r.total_elapsed_time/1000.0/60.0) AS [Elapsed Min]
,CONVERt(NUMERIC(7,2),r.estimated_completion_time/1000.0/60.0) AS [ETA Min]
,CONVERt(NUMERIC(7,2),r.estimated_completion_time/1000.0/60.0/60.0) [ETA Hours]
,r.wait_type
,r.wait_time
,r.blocking_session_id
from sys.dm_exec_requests r
WHERE command IN ('RESTORE DATABASE', 'BACKUP DATABASE')

sp_who 227

SELECT
    r.session_id,
    r.status,
    r.command,
    r.wait_type,
    r.wait_time,
    r.blocking_session_id,
    r.percent_complete,
    r.estimated_completion_time / 1000 / 60 AS est_minutes_left,
    t.text
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.command LIKE 'RESTORE%';
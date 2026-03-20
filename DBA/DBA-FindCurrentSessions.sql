--https://www.sqlshack.com/monitoring-sql-server-with-dynamic-management-objects-requests/
SELECT 
s.session_id, 
s.login_name, s.host_name, c.client_net_address, 
s.program_name, db_name(r.database_id) AS [Database],
r.command, r.status,
r.total_elapsed_time, r.cpu_time, r.wait_time,
r.percent_complete, 
r.wait_type, r.blocking_session_id,
r.reads, r.logical_reads, r.writes
FROM sys.dm_exec_sessions s
INNER JOIN sys.dm_exec_connections c
ON s.session_id = c.session_id 
INNER JOIN sys.dm_exec_requests r
ON s.session_id = r.session_id
WHERE s.is_user_process = 1


--
SELECT DB_NAME(database_id) as [DB]
    , login_name
    , nt_domain
    , nt_user_name
    , status
    , host_name
    , program_name
    , COUNT(*) AS [Connections]
FROM sys.dm_exec_sessions
WHERE database_id > 0 -- OR 4 for user DBs
GROUP BY database_id, login_name, status, host_name, program_name, nt_domain, nt_user_name;
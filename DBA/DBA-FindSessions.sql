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


-- List DB connections
USE master
go
SELECT
     sdes.session_id
    ,sdes.login_time
    ,sdes.last_request_start_time
    ,sdes.last_request_end_time
    ,sdes.is_user_process
    ,sdes.host_name
    ,sdes.program_name
    ,sdes.login_name
    ,sdes.status

    ,sdec.num_reads
    ,sdec.num_writes
    ,sdec.last_read
    ,sdec.last_write
    ,sdes.reads
    ,sdes.logical_reads
    ,sdes.writes

    ,sdest.DatabaseName
    ,sdest.ObjName
    ,sdes.client_interface_name
    ,sdes.nt_domain
    ,sdes.nt_user_name
    ,sdec.client_net_address
    ,sdec.local_net_address
    ,sdest.Query
    ,KillCommand  = 'Kill '+ CAST(sdes.session_id  AS VARCHAR)
FROM sys.dm_exec_sessions AS sdes

INNER JOIN sys.dm_exec_connections AS sdec
        ON sdec.session_id = sdes.session_id

CROSS APPLY (

    SELECT DB_NAME(dbid) AS DatabaseName
        ,OBJECT_NAME(objectid) AS ObjName
        ,COALESCE((
            SELECT TEXT AS [processing-instruction(definition)]
            FROM sys.dm_exec_sql_text(sdec.most_recent_sql_handle)
            FOR XML PATH('')
                ,TYPE
            ), '') AS Query

    FROM sys.dm_exec_sql_text(sdec.most_recent_sql_handle)

) sdest
WHERE sdes.session_id <> @@SPID
  AND sdest.DatabaseName ='ARC_Hfm'
--ORDER BY sdes.last_request_start_time DESC
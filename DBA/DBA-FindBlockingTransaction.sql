SELECT r.session_id  ,ex.loginame
, r.start_time,r.status,r.command,db_name(r.database_id),
r.blocking_session_id,r.wait_type,r.wait_time,r.last_wait_type,r.wait_resource
,r.percent_complete,r.estimated_completion_time,r.cpu_time,r.total_elapsed_time
,r.reads,r.writes,r.logical_reads,t.text,z.query_plan
FROM sys.dm_exec_requests AS r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) AS t
CROSS APPLY sys.dm_exec_query_plan(r.plan_handle) AS z
join           sys.sysprocesses ex on r.session_id = ex.spid
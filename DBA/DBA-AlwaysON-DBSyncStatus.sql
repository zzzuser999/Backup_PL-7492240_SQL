SELECT AGS.NAME AS AGGroupName, db_name(database_id)
    ,AR.replica_server_name AS InstanceName
    ,HARS.role_desc
    ,DRS.synchronization_state_desc AS SyncState
    ,DRS.last_hardened_time
    ,DRS.last_sent_time
    ,DRS.last_redone_time
    ,((DRS.log_send_queue_size)/8)/1024 QueueSize_MB
    ,datediff(MINUTE, last_redone_time, last_hardened_time) as Latency_Minutes
    ,drs.redo_rate
    ,drs.log_send_queue_size
,drs.log_send_rate
--,drs.last_sent_lsn
--,drs.last_hardened_lsn
,drs.last_hardened_time
,drs.last_redone_time
FROM sys.dm_hadr_database_replica_states DRS
LEFT JOIN sys.availability_replicas AR ON DRS.replica_id = AR.replica_id
LEFT JOIN sys.availability_groups AGS ON AR.group_id = AGS.group_id
LEFT JOIN sys.dm_hadr_availability_replica_states HARS ON AR.group_id = HARS.group_id
    AND AR.replica_id = HARS.replica_id
--where db_name(database_id)='PRD_HFM'
WHERE HARS.role_desc = 'SECONDARY'
AND ((DRS.log_send_queue_size)/8)/1024 > 1024

select @@SERVERNAME
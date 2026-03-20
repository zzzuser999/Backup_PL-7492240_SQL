USE msdb
SELECT name, notify_email_operator_id   
FROM dbo.sysjobs  
WHERE notify_email_operator_id = 0;


USE [msdb]
GO
 
SET NOCOUNT ON;
DECLARE @Operator varchar(50) = 'Abacus Monitoring' -- place your operator name here
 
SELECT 'EXEC sp_update_job @job_name = ''' + j.[name] + 
       ''', @notify_email_operator_name = ''' + @Operator  +
       ''', @notify_level_email = 2'   -- 1=On Success, 2=On Faulure,3=always
       
FROM msdb.dbo.sysjobs j
WHERE j.notify_level_email <> 2
AND (j.name like '%Maintenance%' OR j.name like '%Backup%' OR j.name like '%SIP%' OR category_id=3)
GO

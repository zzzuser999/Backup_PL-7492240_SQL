EXEC sys.sp_configure 'Agent XPs', 1;RECONFIGURE;
GO


USE [msdb]
GO

IF NOT EXISTS(SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Abacus Monitoring')
BEGIN
EXEC msdb.dbo.sp_add_operator @name=N'Abacus Monitoring', 
		@enabled=1, 
		@email_address=N'abacus.monitoring@ch.abb.com', 
		@category_name=N'[Uncategorized]'
END

--USE [msdb]
--GO

--/****** Object:  Operator [Abacus Monitoring]    Script Date: 12/13/2011 14:12:07 ******/
--IF  EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Abacus Monitoring')
--EXEC msdb.dbo.sp_delete_operator @name=N'Abacus Monitoring'
--GO


USE [msdb]
GO
EXEC master.dbo.xp_instance_regwrite
		N'HKEY_LOCAL_MACHINE',
		N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
		N'UseDatabaseMail',
		N'REG_DWORD', 1

EXEC master.dbo.xp_instance_regwrite
		N'HKEY_LOCAL_MACHINE',
		N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent',
		N'DatabaseMailProfile',
		N'REG_SZ',
		N'inet.de.abb.com'

EXEC msdb.[dbo].[sp_set_sqlagent_properties]
		@jobhistory_max_rows=20000,
		@jobhistory_max_rows_per_job=1000

-- Define a fail-safe operator
EXEC master.dbo.sp_MSsetalertinfo 
		@failsafeoperator=N'Abacus Monitoring',
		@notificationmethod = 1;

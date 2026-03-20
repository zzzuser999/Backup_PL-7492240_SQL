USE [msdb]
GO


-- Add Alert Category if it does not exist
IF NOT EXISTS (SELECT *
               FROM msdb.dbo.syscategories
               WHERE category_class = 2  -- ALERT
			   AND category_type = 3
               AND name = 'SQL Server Agent Alerts')
	BEGIN
		EXEC dbo.sp_add_category @class = N'ALERT', @type = N'NONE', @name = 'SQL Server Agent Alerts';
	END


/****** Object:  Alert [017 - Insufficient Resources]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'017 - Insufficient Resources')
EXEC msdb.dbo.sp_add_alert @name=N'017 - Insufficient Resources', 
		@message_id=0, 
		@severity=17, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'017 - Insufficient Resources')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'017 - Insufficient Resources'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [018 - Nonfatal Internal Error]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'018 - Nonfatal Internal Error')
EXEC msdb.dbo.sp_add_alert @name=N'018 - Nonfatal Internal Error', 
		@message_id=0, 
		@severity=18, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'018 - Nonfatal Internal Error')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'018 - Nonfatal Internal Error'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [019 - Fatal Error in Resource]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'019 - Fatal Error in Resource')
EXEC msdb.dbo.sp_add_alert @name=N'019 - Fatal Error in Resource', 
		@message_id=0, 
		@severity=19, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'019 - Fatal Error in Resource')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'019 - Fatal Error in Resource'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [020 - Fatal Error in Current Process]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'020 - Fatal Error in Current Process')
EXEC msdb.dbo.sp_add_alert @name=N'020 - Fatal Error in Current Process', 
		@message_id=0, 
		@severity=20, 
		@enabled=0, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'020 - Fatal Error in Current Process')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'020 - Fatal Error in Current Process'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [021 - Falal Error in Databases Processes]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'021 - Falal Error in Databases Processes')
EXEC msdb.dbo.sp_add_alert @name=N'021 - Falal Error in Databases Processes', 
		@message_id=0, 
		@severity=21, 
		@enabled=0, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'021 - Falal Error in Databases Processes')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'021 - Falal Error in Databases Processes'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [022 - Fatal Error Table Integrity Suspect]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'022 - Fatal Error Table Integrity Suspect')
EXEC msdb.dbo.sp_add_alert @name=N'022 - Fatal Error Table Integrity Suspect', 
		@message_id=0, 
		@severity=22, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'022 - Fatal Error Table Integrity Suspect')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'022 - Fatal Error Table Integrity Suspect'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [023 - Fatal Error: Database Integrity Suspect]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'023 - Fatal Error: Database Integrity Suspect')
EXEC msdb.dbo.sp_add_alert @name=N'023 - Fatal Error: Database Integrity Suspect', 
		@message_id=0, 
		@severity=23, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'023 - Fatal Error: Database Integrity Suspect')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'023 - Fatal Error: Database Integrity Suspect'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [024 - Fatal Error: Hardware Error]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'024 - Fatal Error: Hardware Error')
EXEC msdb.dbo.sp_add_alert @name=N'024 - Fatal Error: Hardware Error', 
		@message_id=0, 
		@severity=24, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'024 - Fatal Error: Hardware Error')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'024 - Fatal Error: Hardware Error'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [025 - Fatal Error]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.sysalerts WHERE name=N'025 - Fatal Error')
EXEC msdb.dbo.sp_add_alert @name=N'025 - Fatal Error', 
		@message_id=0, 
		@severity=25, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts',  
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'025 - Fatal Error')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'025 - Fatal Error'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [823 - I/O Error: OS Cannot Read Data]    Script Date: 03/12/2014 15:02:23 ******/
-- How to troubleshoot a Msg 823 error in SQL Server	
-- http://support.microsoft.com/kb/2015755
IF NOT EXISTS (SELECT name, message_id FROM msdb.dbo.sysalerts WHERE message_id= 823)
EXEC msdb.dbo.sp_add_alert @name=N'823 - I/O Error: OS Cannot Read Data', 
		@message_id=823, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts',  
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'823 - I/O Error: OS Cannot Read Data')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'823 - I/O Error: OS Cannot Read Data'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [824 - I/O Error: MSSQL Cannot Read Data]    Script Date: 03/12/2014 15:02:23 ******/
-- How to troubleshoot Msg 824 in SQL Server
-- http://support.microsoft.com/kb/2015756
IF NOT EXISTS (SELECT name, message_id FROM msdb.dbo.sysalerts WHERE message_id= 824)
EXEC msdb.dbo.sp_add_alert @name=N'824 - I/O Error: MSSQL Cannot Read Data', 
		@message_id=824, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'824 - I/O Error: MSSQL Cannot Read Data')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'824 - I/O Error: MSSQL Cannot Read Data'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [825 - Read-Retry Required]    Script Date: 03/12/2014 15:02:23 ******/
-- How to troubleshoot Msg 825 (read retry) in SQL Server
-- http://support.microsoft.com/kb/2015757
IF NOT EXISTS (SELECT name, message_id FROM msdb.dbo.sysalerts WHERE message_id= 825)
EXEC msdb.dbo.sp_add_alert @name=N'825 - Read-Retry Required', 
		@message_id=825, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'825 - Read-Retry Required')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'825 - Read-Retry Required'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [832 - Memory Error: Constant page has changed]    Script Date: 03/12/2014 15:02:23 ******/
-- http://www.sqlskills.com/blogs/paul/dont-confuse-error-823-and-error-832/
-- http://support.microsoft.com/kb/2015759
IF NOT EXISTS (SELECT name, message_id FROM msdb.dbo.sysalerts WHERE message_id= 832)
EXEC msdb.dbo.sp_add_alert @name=N'832 - Memory Error: Constant page has changed', 
		@message_id=832, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts',  
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'832 - Memory Error: Constant page has changed')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'832 - Memory Error: Constant page has changed'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

-- Memory Error Correction alerts added on 10/30/2013

-- Mitigation of RAM Hardware Errors	 		
-- When SQL Server 2012 Enterprise Edition is installed on a Windows 2012 operating system with hardware that supports bad memory diagnostics, 
-- you will notice new error messages like 854, 855, and 856 instead of the 832 errors that LazyWriter usually generates.
-- Error 854 is just informing you that your instance supports memory error correction

-- Using SQL Server in Windows 8 and Windows Server 2012 environments
-- http://support.microsoft.com/kb/2681562

/****** Object:  Alert [Error 855 - Uncorrectable hardware memory corruption detected]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name, message_id FROM msdb.dbo.sysalerts WHERE message_id= 855)
EXEC msdb.dbo.sp_add_alert @name=N'855 - Uncorrectable hardware memory corruption detected', 
		@message_id=855, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts',  
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'855 - Uncorrectable hardware memory corruption detected')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'855 - Uncorrectable hardware memory corruption detected'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END

/****** Object:  Alert [856 - SQL Server has detected hardware memory corruption, but has recovered the page]    Script Date: 03/12/2014 15:02:23 ******/
IF NOT EXISTS (SELECT name, message_id FROM msdb.dbo.sysalerts WHERE message_id= 856)
EXEC msdb.dbo.sp_add_alert @name=N'856 - SQL Server has detected hardware memory corruption, but has recovered the page', 
		@message_id=856, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=1, 
		@category_name=N'SQL Server Agent Alerts',  
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO

IF NOT EXISTS(SELECT * FROM dbo.sysalerts AS sa
					  INNER JOIN dbo.sysnotifications AS sn
					  ON sa.id = sn.alert_id
					  WHERE sa.name = N'856 - SQL Server has detected hardware memory corruption, but has recovered the page')
	BEGIN
		EXEC msdb.dbo.sp_add_notification @alert_name = N'856 - SQL Server has detected hardware memory corruption, but has recovered the page'
			,@operator_name = 'Abacus Monitoring'
			,@notification_method = 1;
	END


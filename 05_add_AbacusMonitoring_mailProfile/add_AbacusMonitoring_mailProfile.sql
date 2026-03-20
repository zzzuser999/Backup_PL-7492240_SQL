EXEC master.sys.sp_configure 'show advanced option', 1;RECONFIGURE;
GO

EXEC master.sys.sp_configure 'Database Mail XPs', 1;RECONFIGURE;
GO

USE [master]
--#################################################################################################
-- BEGIN Mail Settings inet.abb.com
--#################################################################################################
IF NOT EXISTS(SELECT * FROM msdb.dbo.sysmail_profile WHERE  name = 'inet.abb.com') 
  BEGIN
    --CREATE Profile [inet.abb.com]
    EXECUTE msdb.dbo.sysmail_add_profile_sp
      @profile_name = 'inet.abb.com',
      @description  = 'SMTP Profile to Send Email Notifications';
  END --IF EXISTS profile
  
  IF NOT EXISTS(SELECT * FROM msdb.dbo.sysmail_account WHERE  name = 'inet.abb.com')
  BEGIN
	IF NOT EXISTS(SELECT * FROM [msdb].[dbo].[sysmail_account] where [name] = 'Abacus Monitoring')
	BEGIN
    --CREATE Account [inet.abb.com]
    EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name            = 'Abacus Monitoring',
    @email_address           = 'Abacus.Monitoring@ch.abb.com',
    @display_name            = 'Abacus Monitoring',
    @replyto_address         = 'Abacus.Monitoring@ch.abb.com',
    @description             = 'Abacus Monitoring',
    @mailserver_name         = 'inet.abb.com',
    @mailserver_type         = 'SMTP',
    @port                    = '25',
    @username                =  NULL ,
    @password                =  NULL , 
    @use_default_credentials =  0 ,
    @enable_ssl              =  0 ;
	END  
  END

IF NOT EXISTS(SELECT *
              FROM msdb.dbo.sysmail_profileaccount pa
                INNER JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id
                INNER JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id  
              WHERE p.name = 'inet.abb.com'
                AND a.name = 'Abacus Monitoring') 
  BEGIN
    -- Associate Account [Abacus Monitoring] to Profile [inetabb.com]
    EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
      @profile_name = 'inet.abb.com',
      @account_name = 'Abacus Monitoring',
      @sequence_number = 1 ;
  END --IF EXISTS associate accounts to profiles


EXECUTE msdb.dbo.sysmail_help_principalprofile_sp
	@profile_name = 'inet.abb.com',
	@principal_name = 'public'


--#################################################################################################
-- Drop Settings For inet.abb.com
--#################################################################################################
/*
IF EXISTS(SELECT *
            FROM msdb.dbo.sysmail_profileaccount pa
              INNER JOIN msdb.dbo.sysmail_profile p ON pa.profile_id = p.profile_id
              INNER JOIN msdb.dbo.sysmail_account a ON pa.account_id = a.account_id  
            WHERE p.name = 'inet.abb.com'
              AND a.name = 'inet.abb.com')
  BEGIN
    EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp @profile_name = 'inet.abb.com',@account_name = 'inet.abb.com'
  END 
IF EXISTS(SELECT * FROM msdb.dbo.sysmail_account WHERE  name = 'inet.abb.com')
  BEGIN
    EXECUTE msdb.dbo.sysmail_delete_account_sp @account_name = 'inet.abb.com'
  END
IF EXISTS(SELECT * FROM msdb.dbo.sysmail_profile WHERE  name = 'inet.abb.com') 
  BEGIN
    EXECUTE msdb.dbo.sysmail_delete_profile_sp @profile_name = 'inet.abb.com'
  END
*/
  


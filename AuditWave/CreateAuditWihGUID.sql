CREATE SERVER AUDIT [AuditWave_2] TO APPLICATION_LOG
WITH (AUDIT_GUID = '58C7538C-D8F4-4370-AA0D-725D7D35B61B', QUEUE_DELAY = 1000, ON_FAILURE = CONTINUE)

SELECT audit_guid FROM sys.server_audits WHERE name = 'AuditWave'
 
SELECT audit_guid FROM sys.server_audits WHERE name = 'AuditWave_2'
select
    P.spid
,   P.program_name
,   P.hostname
,   P.loginame
from master.dbo.sysprocesses P
where P.spid > 50
and      P.status not in ('background', 'sleeping')
and      P.cmd not in ('AWAITING COMMAND'
                    ,'MIRROR HANDLER'
                    ,'LAZY WRITER'
                    ,'CHECKPOINT SLEEP'
                    ,'RA MANAGER')
SELECT session_id
    ,host_name
    ,program_name
    ,client_interface_name
    ,login_name
    ,STATUS
    ,is_user_process
FROM sys.dm_exec_sessions
WHERE database_id = db_id('MMR01')

declare
    @spid int
,   @stmt_start int
,   @stmt_end int
,   @sql_handle binary(20)

set @spid = 68 -- Fill this in

select  top 1
    @sql_handle = sql_handle
,   @stmt_start = case stmt_start when 0 then 0 else stmt_start / 2 end
,   @stmt_end = case stmt_end when -1 then -1 else stmt_end / 2 end
from    sys.sysprocesses
where   spid = @spid
order by ecid

SELECT
    SUBSTRING(  text,
            COALESCE(NULLIF(@stmt_start, 0), 1),
            CASE @stmt_end
                WHEN -1
                    THEN DATALENGTH(text)
                ELSE
                    (@stmt_end - @stmt_start)
                END
        )
FROM ::fn_get_sql(@sql_handle)

kill 72
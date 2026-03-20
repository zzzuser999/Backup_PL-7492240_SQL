DECLARE @cmd varchar(6000)
DECLARE cmds CURSOR FOR
SELECT '
DROP TABLE ' 
    + QUOTENAME(s.name)
    + '.' + QUOTENAME(t.name) + ';'
    FROM sys.tables AS t
    INNER JOIN sys.schemas AS s
    ON t.[schema_id] = s.[schema_id] 
   WHERE t.name IN ('ABACUS04_DATA_AUDIT','ABACUS04_TASK_AUDIT','ABACUS05_DATA_AUDIT','ABACUS05_TASK_AUDIT',
   'ABACUS06_DATA_AUDIT','ABACUS06_TASK_AUDIT','ABACUS07_DATA_AUDIT','ABACUS07_TASK_AUDIT','ABACUS08_DATA_AUDIT','ABACUS08_TASK_AUDIT',
   'ABACUSB4_DATA_AUDIT','ABACUSB4_TASK_AUDIT','ABACUSB5_DATA_AUDIT','ABACUSB5_TASK_AUDIT','Mon_SQLPerfCountersValues','Mon_TableGrowInDB','Path_List') OR t.name LIKE '%_old%';

OPEN cmds
WHILE 1 = 1
BEGIN
    FETCH cmds INTO @cmd
    IF @@fetch_status != 0 BREAK
    EXEC(@cmd)
END
CLOSE cmds;
DEALLOCATE cmds

select @@SERVERNAME

/*
   select schema_name(tab.schema_id) + '.' + tab.name as [table]
   from sys.tables tab
        inner join sys.partitions part
            on tab.object_id = part.object_id
where part.index_id IN (1, 0) -- 0 - table without PK, 1 table with PK
group by schema_name(tab.schema_id) + '.' + tab.name
having sum(part.rows) = 0
order by [table]
*/
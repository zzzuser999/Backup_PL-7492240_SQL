DECLARE @RoleName NVARCHAR(128) = 'YourServerRole'; -- Change to the desired server role
DECLARE @DBName NVARCHAR(128);
DECLARE @SQL NVARCHAR(MAX);

-- Cursor to iterate over each user database
DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE database_id > 4;  -- Skipping system databases (master, tempdb, model, msdb)

OPEN db_cursor;
FETCH NEXT FROM db_cursor INTO @DBName;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Build the dynamic SQL for each database
    SET @SQL = N'
    USE ' + QUOTENAME(@DBName) + ';
    SELECT ''' + @DBName + ''' AS DatabaseName, 
           dp.name AS PrincipalName, 
           dp.type_desc AS PrincipalType, 
           p.permission_name, 
           p.state_desc AS PermissionState, 
           o.name AS ObjectName, 
           o.type_desc AS ObjectType
    FROM sys.database_principals dp
    JOIN sys.database_permissions p ON dp.principal_id = p.grantee_principal_id
    LEFT JOIN sys.objects o ON p.major_id = o.object_id
    WHERE dp.name = @RoleName;
    ';

    -- Execute the SQL for the current database
    EXEC sp_executesql @SQL, N'@RoleName NVARCHAR(128)', @RoleName;

    FETCH NEXT FROM db_cursor INTO @DBName;
END

CLOSE db_cursor;
DEALLOCATE db_cursor;
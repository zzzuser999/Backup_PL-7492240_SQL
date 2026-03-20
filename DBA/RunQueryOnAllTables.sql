CREATE TABLE #DBTables (Name NVARCHAR(256), ID INT IDENTITY)

INSERT #DBTables
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME LIKE '%ABACUS%'

DECLARE @Count INT, @RC INT
SET @RC = @@ROWCOUNT
SET @Count = 1

WHILE (@Count < @RC)
BEGIN
    DECLARE @TableName NVARCHAR(256)

    SELECT @TableName = Name FROM #DBTables WHERE ID = @Count

    DECLARE @Query NVARCHAR(MAX)

    SET @Query = 'SELECT top (1) * FROM ' + @TableName  + ' WHERE LogDate < ''2022-12-15'' ORDER BY LogDate desc'

    EXEC(@Query)

    SET @Count = @Count + 1
END

DROP TABLE #DBTables
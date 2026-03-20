-- Test tempdb write performance
-- Author: ChatGPT
-- Notes:
-- - Safe to run (no persistent data)
-- - Adjust iterations or file size to simulate heavier load

SET NOCOUNT ON;
PRINT 'Starting tempdb performance test...';

DECLARE @StartTime DATETIME2 = SYSDATETIME();
DECLARE @Loop INT = 1;
DECLARE @MaxLoops INT = 5; -- Increase to run more iterations
DECLARE @ElapsedMs INT;

-- Table variable to collect test info
DECLARE @Results TABLE (
    TestRun INT,
    DurationMs INT
);

WHILE @Loop <= @MaxLoops
BEGIN
    DECLARE @StartLoop DATETIME2 = SYSDATETIME();

    -- Create a large temp table and fill with data
    CREATE TABLE #TempTest (
        ID INT IDENTITY(1,1),
        SomeData CHAR(8000) -- ~8 KB per row
    );

    -- Insert 10,000 rows (≈ 80 MB per iteration)
    INSERT INTO #TempTest (SomeData)
    SELECT TOP 10000 REPLICATE('X', 8000)
    FROM sys.all_objects a CROSS JOIN sys.all_objects b;

    -- Cleanup
    DROP TABLE #TempTest;

    SET @ElapsedMs = DATEDIFF(MILLISECOND, @StartLoop, SYSDATETIME());
    INSERT INTO @Results VALUES (@Loop, @ElapsedMs);

    PRINT FORMATMESSAGE('Test run %d: %d ms', @Loop, @ElapsedMs);

    SET @Loop += 1;
END

-- Summary
PRINT '=== Summary of tempdb I/O performance ===';
SELECT 
    TestRun,
    DurationMs,
    ROUND(DurationMs * 1.0 / 1000, 2) AS DurationSec
FROM @Results;

SELECT 
    ROUND(AVG(DurationMs) * 1.0 / 1000, 2) AS AvgSecPerRun,
    MIN(DurationMs) AS FastestMs,
    MAX(DurationMs) AS SlowestMs
FROM @Results;

PRINT 'Test complete.';

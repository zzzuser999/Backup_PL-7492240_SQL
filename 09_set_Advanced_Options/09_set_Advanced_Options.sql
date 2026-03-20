USE [master];
GO

EXEC sp_configure 'show advanced option', '1'; RECONFIGURE;

--backup compression
EXEC sys.sp_configure 'backup compression default',1; RECONFIGURE WITH OVERRIDE;
	
--Remote Admin Connection
EXEC sys.sp_configure 'remote admin connections',1; RECONFIGURE;

--Ad-hoc Queries
EXEC sys.sp_configure 'optimize for ad hoc workloads',1; RECONFIGURE;


-- Min/Max Memory Settings (depends on server config)

EXEC sys.sp_configure 'min server memory (MB)', '4000'; RECONFIGURE;
--EXEC sys.sp_configure 'max server memory (MB)', '12000'; RECONFIGURE; -- ustawiæ zale¿nie od konfiguracji pamiêci na serwerze,
-- iloœci instancji i serwisów oraz zapotrzebowania na pamiêæ dla ka¿dego z tych komponentów
*/

-- Max Degree of Parallelism (depends on server config)
/*
EXEC sys.sp_configure 'max degree of parallelism',8; RECONFIGURE;
*/

-- Cost Threshold of Parallelism (depends on server config)
EXEC sys.sp_configure 'cost threshold for parallelism',50; RECONFIGURE;


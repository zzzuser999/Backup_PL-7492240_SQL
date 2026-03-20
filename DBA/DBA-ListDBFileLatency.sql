SELECT  DB_NAME(mf.database_id) AS [Database Name], 
        mf.physical_name [Physical Name], 
        num_of_reads, num_of_bytes_read, io_stall_read_ms, 
        num_of_writes, num_of_bytes_written, io_stall_write_ms, 
        io_stall, size_on_disk_bytes
FROM    sys.dm_io_virtual_file_stats(null,null) AS vfs
INNER JOIN sys.master_files AS mf
              ON mf.database_id = vfs.database_id
                 and mf.file_id = vfs.file_id
-- ORDER BY io_stall DESC
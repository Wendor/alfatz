#!/bin/bash

wait_time=15s

echo importing data will start in $wait_time...
sleep $wait_time

exist=`/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON select COUNT(*) from sys.databases where name = 'TestData'" -h -1 | awk '{print $1}'`
if [ "$exist" = "0" ]; then
    echo "Creating database!"
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/data.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/proc.sql
else
    echo "Database exists!"
fi

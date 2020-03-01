#!/bin/bash

wait_time=15s

echo importing data will start in $wait_time...
sleep $wait_time

exist=`/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON select COUNT(*) from sys.databases where name = 'TestData'" -h -1 | awk '{print $1}'`
if [ "$exist" = "0" ]; then
    echo "Creating database!"
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/create_database.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/init.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step1.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step2.sql
    echo "Database created."
else
    echo "Database exists!"
fi

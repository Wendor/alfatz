#!/bin/bash

TIMEOUT=20s

echo importing data will start in $TIMEOUT...
sleep $TIMEOUT

exist=`/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON select COUNT(*) from sys.databases where name = 'TestData'" -h -1 | awk '{print $1}'`
if [ "$exist" = "0" ]; then
    echo "Database not found. Creating..."
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/create_database.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/init.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step1.sql
    /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step2.sql
    echo "Database created."
else
    echo "Database found. Skip creating."
fi

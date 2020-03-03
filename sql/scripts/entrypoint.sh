#!/bin/bash

TIMEOUT=20s

echo importing data will start in $TIMEOUT...
sleep $TIMEOUT

exist=0

while [ "$exist" != "1" ]
do
    exist=`/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -Q "SET NOCOUNT ON select COUNT(*) from sys.databases where name = 'TestData'" -h -1 | awk '{print $1}'`
    if [ "$exist" != "1" ]; then
        echo "Database not found. Creating..."
        /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/create.sql
        /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/init.sql
        /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step1.sql
        /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step2.sql
        /opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P $SA_PASSWORD -i ./sql/step3.sql
        echo "Database created."
    fi
    sleep 5
done

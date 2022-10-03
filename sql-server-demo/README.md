# Start the topology as defined in https://debezium.io/documentation/reference/stable/tutorial.html
```
export DEBEZIUM_VERSION=1.9
```
```
docker-compose -f docker-compose-sqlserver.yaml up
```

# Initialize database and insert test data
```
cat debezium-sqlserver-init/inventory.sql | docker-compose -f docker-compose-sqlserver.yaml exec -T sqlserver bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD'
```

# Start SQL Server connector
```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-sqlserver.json
```

# Start PostgreSQL connector
```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @jdbc-sink.json
```

Verify that the PostgreSQL database has the same content:

```shell
docker-compose -f docker-compose-sqlserver.yaml exec postgres bash -c 'psql -U $POSTGRES_USER $POSTGRES_DB -c "select * from products"'
 id        | name  | weight   |    details        
-----------+-------+----------+---------------
(4 rows)
```

 Note : details key is transformed from description

# Consume messages from a Debezium topic
```
docker-compose -f docker-compose-sqlserver.yaml exec kafka /kafka/bin/kafka-console-consumer.sh \
    --bootstrap-server kafka:9092 \
    --from-beginning \
    --property print.key=true \
    --topic server1.dbo.customers
```

# Modify records in the database via SQL Server client (do not forget to add `GO` command to execute the statement)
```
docker-compose -f docker-compose-sqlserver.yaml exec sqlserver bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -d testDB'
```

# Shut down the cluster
docker-compose -f docker-compose-sqlserver.yaml down

# updating sql server query for test 
```
UPDATE products
SET name='updated product name Arthur'
WHERE weight='3.1';
GO
```
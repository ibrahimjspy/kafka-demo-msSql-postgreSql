USE testDB;
-- command that enables cdc  
EXEC sys.sp_cdc_enable_db;  

INSERT INTO products(name,description,weight)
  VALUES ('ibi','hammer',0.75);
INSERT INTO products(name,description,weight)
  VALUES ('Messi leo','14oz camer',0.875);
  INSERT INTO products(name,description,weight)
  VALUES ('zalfaka','14oz camer',0.875);

EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'products', @role_name = NULL, @supports_net_changes = 0;
GO
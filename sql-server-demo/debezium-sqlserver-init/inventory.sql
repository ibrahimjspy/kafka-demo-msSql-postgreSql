-- Create the test database
CREATE DATABASE testDB;
GO
USE testDB;
EXEC sys.sp_cdc_enable_db;

-- Create and populate our products using a single insert with many rows
CREATE TABLE products (
  id INTEGER IDENTITY(101,1) NOT NULL PRIMARY KEY,
  nStyleName VARCHAR(255) NOT NULL,
  nItemDescription VARCHAR(512),
  TBItem_ID INTEGER,
);
INSERT INTO products(nStyleName,nItemDescription,TBItem_ID)
  VALUES ('scooteryy','Small 2-wheels scooter',3);
INSERT INTO products(nStyleName,nItemDescription,TBItem_ID)
  VALUES ('car battery','12V car battery',8.1);
INSERT INTO products(nStyleName,nItemDescription,TBItem_ID)
  VALUES ('12-pack drill bits','12-pack of drill bits with sizes ranging from #40 to #3',0.8);
INSERT INTO products(nStyleName,nItemDescription,TBItem_ID)
  VALUES ('hammer','12oz carpenter''s hammer',0.75);
INSERT INTO products(nStyleName,nItemDescription,TBItem_ID)
  VALUES ('hammer','14oz carpenter''s hammer',0.875);
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'products', @role_name = NULL, @supports_net_changes = 0;
-- Create and populate the products on hand using multiple inserts
CREATE TABLE category_master (
  id  INTEGER IDENTITY(101,1) NOT NULL PRIMARY KEY,
  TBStyleNo_OS_Category_Master_ID INTEGER NOT NULL,
  CategoryMasterName VARCHAR(255) NOT NULL,
  Description VARCHAR(255),
  url VARCHAR(255),
  seo_description VARCHAR(255) ,
  seo_title VARCHAR(255),
);
DELETE FROM category_master WHERE TBStyleNo_OS_Category_Master_ID=123
INSERT INTO category_master(TBStyleNo_OS_Category_Master_ID,CategoryMasterName,Description,seo_description,seo_title)
  VALUES (123,'Child''s hammer','demo description','seo description','Seo Title');
 
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'category_master', @role_name = NULL, @supports_net_changes = 0;
-- Create some customers ...
CREATE TABLE category_sub (
  id  INTEGER IDENTITY(101,1) NOT NULL PRIMARY KEY,
  TBStyleNo_OS_Category_Sub_ID INTEGER NOT NULL,
  TBStyleNo_OS_Category_Master_ID INTEGER NOT NULL,
  CategorySubName VARCHAR(255) NOT NULL,
  Description VARCHAR(255),
  url VARCHAR(255),
  seo_description VARCHAR(255) ,
  seo_title VARCHAR(255),
);
DELETE FROM category_sub WHERE TBStyleNo_OS_Category_Sub_ID =123;
INSERT INTO category_sub(TBStyleNo_OS_Category_Sub_ID,TBStyleNo_OS_Category_Master_ID,CategorySubName,Description,seo_description,seo_title)
  VALUES (123,340,'Chilvf''s hammevr','demon lord','seoo description','Seo Title');
EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'category_sub', @role_name = NULL, @supports_net_changes = 0;
-- Create some very simple orders
CREATE TABLE orders (
  id INTEGER IDENTITY(10001,1) NOT NULL PRIMARY KEY,
  order_date DATE NOT NULL,
  purchaser INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  FOREIGN KEY (purchaser) REFERENCES customers(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

     -- category sub

DELETE FROM category_sub WHERE TBStyleNo_OS_Category_Sub_ID =123;

INSERT INTO category_sub(TBStyleNo_OS_Category_Sub_ID,TBStyleNo_OS_Category_Master_ID,CategorySubName,Description,seo_description,seo_title)
  VALUES (123,340,'tops','women black tops','fabric content','Women');

UPDATE category_sub
SET seo_title='Updated seo title'
WHERE TBStyleNo_OS_Category_Sub_ID=123;
GO

      --  products 

INSERT INTO products(nStyleName,nItemDescription,TBItem_ID)
  VALUES ('long trouser','black long trouser',3);
GO

UPDATE products
SET nStyleName='Updated name'
WHERE TBItem_ID=3;
GO

DELETE FROM products WHERE TBItem_ID =3;

      --master category
    
INSERT INTO category_master(TBStyleNo_OS_Category_Master_ID,CategoryMasterName,Description,seo_description,seo_title)
  VALUES (123,'Child''s hammer','demo description','seo description','Seo Title');

DELETE FROM category_master WHERE TBStyleNo_OS_Category_Master_ID=123

UPDATE category_master
SET seo_title='Updated seo description'
WHERE TBStyleNo_OS_Category_Master_ID=123;
GO

      --|--



-- INSERT INTO orders(order_date,purchaser,quantity,product_id)
--   VALUES ('16-JAN-2016', 1001, 1, 102);
-- INSERT INTO orders(order_date,purchaser,quantity,product_id)
--   VALUES ('17-JAN-2016', 1002, 2, 105);
-- INSERT INTO orders(order_date,purchaser,quantity,product_id)
--   VALUES ('19-FEB-2016', 1002, 2, 106);
-- INSERT INTO orders(order_date,purchaser,quantity,product_id)
--   VALUES ('21-FEB-2016', 1003, 1, 107);
-- EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'orders', @role_name = NULL, @supports_net_changes = 0;
-- GO

-- CREATE TABLE TBStyleNo(
--   TBItem_ID nvarchar(8) NOT NULL,
-- 	nItemDescription varchar(4000) NULL,

-- );
-- EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'TBStyleNo', @role_name = NULL, @supports_net_changes = 0;
-- GO

-- CREATE TABLE TBStyleNo_OS_Category_Master(
-- 	TBStyleNo_OS_Category_Master_ID bigint IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
-- 	CategoryMasterName VARCHAR(50) NULL,
-- 	Description VARCHAR(4000) NULL,
-- 	Active bit NULL,
-- 	mainTopCategory smallint NOT NULL,
-- 	DisplayGroup VARCHAR(50) NULL,
-- 	DisplayOrder int NULL,
-- 	DisplayGroupOrder int NULL,
-- 	url VARCHAR(50) NULL,
-- 	Description50 VARCHAR(4000) NULL,
-- 	seo_title VARCHAR(500) NULL,
-- 	seo_description VARCHAR(max) NULL,
-- 	Description_tmpl VARCHAR(2000) NULL,
-- 	h1_tag VARCHAR(500) NULL
-- );
-- EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'TBStyleNo_OS_Category_Master', @role_name = NULL, @supports_net_changes = 0;
-- GO

-- CREATE TABLE TBStyleNo_OS_Category_Sub(
-- 	TBStyleNo_OS_Category_Sub_ID bigint IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
-- 	TBStyleNo_OS_Category_Master_ID bigint NULL,
-- 	CategorySubName VARCHAR(50) NULL,
-- 	Description VARCHAR(2000) NULL,
-- 	Active bit NULL,
-- 	url VARCHAR(50) NULL,
-- 	Description50 VARCHAR(2000) NULL,
-- 	seo_title VARCHAR(500) NULL,
-- 	seo_description VARCHAR(max) NULL,
-- 	Description_tmpl VARCHAR(2000) NULL,
-- 	h1_tag VARCHAR(500) NULL
-- );
-- EXEC sys.sp_cdc_enable_table @source_schema = 'dbo', @source_name = 'TBStyleNo_OS_Category_Sub', @role_name = NULL, @supports_net_changes = 0;
-- GO
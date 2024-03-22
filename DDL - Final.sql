-- DROP STATEMENTS
-- Drop Triggers 
DROP TRIGGER IF EXISTS set_inventory_defaults ON Inventory;
DROP TRIGGER IF EXISTS set_orderid_defaults ON "Order";
DROP TRIGGER IF EXISTS set_vendorid_defaults ON Vendor;
DROP TRIGGER IF EXISTS set_Binid_defaults ON Bin;
DROP TRIGGER IF EXISTS set_Cabinetid_defaults ON Cabinet; 

-- Drop sequences
DROP SEQUENCE IF EXISTS inventoryid_seq;
DROP SEQUENCE IF EXISTS orderid_seq;
DROP SEQUENCE IF EXISTS vendorid_seq;
DROP SEQUENCE IF EXISTS binid_seq;
DROP SEQUENCE IF EXISTS cabinetid_seq;

-- Drop view
DROP VIEW IF EXISTS bin_details;

-- Drop Indices
DROP INDEX IF EXISTS Inventory_ID;
DROP INDEX IF EXISTS Order_ID;
DROP INDEX IF EXISTS Vendor_ID;
DROP INDEX IF EXISTS Bin_ID;
DROP INDEX IF EXISTS Cabinet_ID;
DROP INDEX IF EXISTS IDX_OrderDetails_Order_ID_FK;
DROP INDEX IF EXISTS IDX_OrderDetails_Inventory_ID_FK;
DROP INDEX IF EXISTS IDX_Order_Inventory_ID_FK;
DROP INDEX IF EXISTS IDX_Order_Quantity;

-- Drop Check Constraints
ALTER TABLE Cabinet DROP CONSTRAINT IF EXISTS "count";
ALTER TABLE OrderDetails DROP CONSTRAINT IF EXISTS FK_OrderDetails_Order_ID;
ALTER TABLE OrderDetails DROP CONSTRAINT IF EXISTS FK_OrderDetails_Inventory_ID;
ALTER TABLE "Order" DROP CONSTRAINT IF EXISTS FK_Order_Inventory_ID;
ALTER TABLE Vendor DROP CONSTRAINT IF EXISTS FK_Vendor_Order_ID;
ALTER TABLE Bin DROP CONSTRAINT IF EXISTS FK_Bin_Inventory_ID;
ALTER TABLE Cabinet DROP CONSTRAINT IF EXISTS FK_Cabinet_Bin_ID;

-- Drop table sequences if they exist
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Cabinet;
DROP TABLE IF EXISTS Bin;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS "Order";
DROP TABLE IF EXISTS Inventory;

----------------------------------------------------------
-- CREATE SEQUENCES
-- Create sequence "orderid_seq"
CREATE SEQUENCE orderid_seq
    MINVALUE 100
    START 101
    INCREMENT 1;
	
-- Create sequence "vendorid_seq"
CREATE SEQUENCE vendorid_seq
    MINVALUE 300
    START 301
    INCREMENT 1;
	
-- Create sequence "inventoryid_seq"
CREATE SEQUENCE inventoryid_seq
    MINVALUE 200
    START 201
    INCREMENT 1;

-- Create sequence "binid_seq"
CREATE SEQUENCE binid_seq
    MINVALUE 1
    START 1
    INCREMENT 1;
	
-- Create sequence "cabinetid_seq"	
CREATE SEQUENCE cabinetid_seq
    MINVALUE 500
    START 501
    INCREMENT 1;
	
ALTER SEQUENCE inventoryid_seq RESTART WITH 201;
ALTER SEQUENCE orderid_seq RESTART WITH 101;
ALTER SEQUENCE vendorid_seq RESTART WITH 301;
ALTER SEQUENCE binid_seq RESTART WITH 401;
ALTER SEQUENCE cabinetid_seq RESTART WITH 501;

----------------------------------------------------------
-- CREATE TABLES
-- Create the Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY,
    Stock INT,
    Ordered INT,
    InventoryCategoryID INT,
    I_Description VARCHAR(255)
);

-- Create the "Order" table
CREATE TABLE "Order" (
    OrderID INT PRIMARY KEY,
    InventoryID INT,
    Quantity INT,
    O_Description VARCHAR(255),
    OrderDate DATE,
    UnitPrice DECIMAL(10, 2),
	CONSTRAINT FK_Order_Inventory_ID FOREIGN KEY (InventoryID) REFERENCES Inventory (InventoryID) 
);

-- Create the Vendor table
CREATE TABLE Vendor (
    VendorID INT PRIMARY KEY,
    OrderID INT,
    PostalCode VARCHAR(10),
    CompanyName VARCHAR(255),
    Address VARCHAR(255),
    PhoneNo VARCHAR(15),
	CONSTRAINT FK_Vendor_Order_ID FOREIGN KEY (OrderID) REFERENCES "Order" (OrderID)
);

-- Create the Bin table
CREATE TABLE Bin (
    BinID SERIAL PRIMARY KEY,
    InventoryID INT,
    B_Active BOOLEAN,
    B_Size VARCHAR(20),
    B_Color VARCHAR(20),
    B_Description VARCHAR(255),
	CONSTRAINT FK_Bin_Inventory_ID FOREIGN KEY (InventoryID) REFERENCES Inventory (InventoryID) 
);

-- Create the Cabinet table
CREATE TABLE Cabinet (
    CabinetID INT PRIMARY KEY,
    BinID INT,
    ShelfCount INT,
    BinCount INT,
    C_Active BOOLEAN,
    C_Description VARCHAR(255),
	CONSTRAINT FK_Cabinet_Bin_ID FOREIGN KEY (BinID) REFERENCES Bin (BinID) 
);

-- Create the OrderDetails table
CREATE TABLE OrderDetails (
    OrderID INT,
    InventoryID INT,
    PRIMARY KEY (OrderID, InventoryID),
	CONSTRAINT FK_OrderDetails_Order_ID FOREIGN KEY (OrderID) REFERENCES "Order" (OrderID),
    CONSTRAINT FK_OrderDetails_Inventory_ID FOREIGN KEY (InventoryID) REFERENCES Inventory (InventoryID)
);


----------------------------------------------------------
--Create Views

CREATE OR REPLACE VIEW Bin_details AS 
	SELECT
			bin.binid,
			bin.inventoryid,
			bin.b_color,
			cabinet.shelfcount,
			cabinet.bincount,
			cabinet.c_active

	FROM bin
	JOIN Cabinet
	ON bin.binid = cabinet.binid;

----------------------------------------------------------
-- CREATE TRIGGERS FUNCTION
-- Create Function for Inventory Table
CREATE OR REPLACE FUNCTION Inventory_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.InventoryID IS NULL THEN
        NEW.InventoryID = nextval('Inventoryid_seq');
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create trigger for Inventory Table
create trigger set_inventory_defaults
before insert or update on inventory 
for each row
execute function Inventory_insert_trigger();

----------------------------------------------------------

--Create Function for Order Table
CREATE OR REPLACE FUNCTION order_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.OrderID IS NULL THEN
        NEW.OrderID = nextval('orderid_seq');
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create trigger for Order Table
create trigger set_orderid_defaults
before insert or update on "Order"
for each row
execute function order_insert_trigger();

----------------------------------------------------------

--Create Function for Vendor Table
CREATE OR REPLACE FUNCTION Vendor_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.VendorID IS NULL THEN
        NEW.VendorID = nextval('vendorid_seq');
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create trigger for Vendor Table
create trigger set_vendorid_defaults
before insert or update on Vendor 
for each row
execute function Vendor_insert_trigger();

----------------------------------------------------------

-- Create Function for Bin Table
CREATE OR REPLACE FUNCTION Bin_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.BinID IS NULL THEN
        NEW.BinID = nextval('binid_seq');
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for Bin Table
CREATE TRIGGER set_Binid_defaults
BEFORE INSERT OR UPDATE ON Bin 
FOR EACH ROW
EXECUTE FUNCTION Bin_insert_trigger();


----------------------------------------------------------

--Create Function for cabinet Table
CREATE OR REPLACE FUNCTION Cabinet_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.CabinetID IS NULL THEN
        NEW.CabinetID = nextval('Cabinetid_seq');
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create trigger for cabinet Table
create trigger set_Cabinetid_defaults
before insert or update on Cabinet 
for each row
execute function Cabinet_insert_trigger();

----------------------------------------------------------
--Create indices
CREATE INDEX Inventory_ID ON Inventory (InventoryID);
CREATE INDEX Vendor_ID ON Vendor (VendorID);
CREATE INDEX Bin_ID ON Bin (BinID);
CREATE INDEX Cabinet_ID ON Cabinet (CabinetID);

--Unique constraint converted to a unique index
CREATE UNIQUE INDEX Order_ID ON "Order" (OrderID);

-- Foreign key index
CREATE INDEX IDX_Order_Inventory_ID_FK ON "Order" (InventoryID);

-- Foreign key indexes
CREATE INDEX IDX_OrderDetails_Order_ID_FK ON OrderDetails (OrderID);
CREATE INDEX IDX_OrderDetails_Inventory_ID_FK ON OrderDetails (OrderID);

-- Frequently-queried column index
CREATE INDEX IDX_Order_Quantity ON "Order" (Quantity);

----------------------------------------------------------
-- Add Check Constraints
ALTER TABLE Cabinet ADD CONSTRAINT "count" CHECK (BinCount < 20);

----------------------------------------------------------
-- Validation
-- Check the DBMS data dictionary to make sure that all objects have been created successfully
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
 select * from information_schema.tables


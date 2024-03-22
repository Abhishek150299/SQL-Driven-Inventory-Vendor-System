---Basic Queries:

---Query 1: Select all columns and all rows from the "Vendor" table.
SELECT * FROM Vendor;

---Query 2: Select five columns and all rows from the "Inventory" table.
SELECT InventoryID,  
	   Stock,
	   InventoryCategoryID,
	   Ordered, 
	   I_Description
FROM Inventory;

---Query 3: Select all columns from all rows from the "Bin_details" view.

select * from Bin_details;

---Query 4: Using a join on 2 tables, select all columns and all rows from 
---the "order" and "vendor" tables without the use of a Cartesian product.
SELECT *
FROM "Order" o
INNER JOIN Vendor v 
ON o.OrderID = v.OrderID;

---Query 5: Select and order data retrieved from the "Bin" table.
SELECT *
FROM Bin
ORDER BY BinID DESC;


---Query 6: Using a join on 3 tables (Inventory, Bin, cabinet), 
---select 5 columns from the 3 tables. Limit the output to 10 rows.
SELECT 
		inventory.InventoryID,
		inventory.stock,
		bin.binID,
		cabinet.cabinetid,
		cabinet.shelfcount		
FROM Inventory
join bin on inventory.InventoryID = bin.InventoryID
join cabinet on bin.binID = cabinet.binID
limit 10;

---Query 7: Select distinct rows using joins on 3 tables (Inventory, Bin, cabinet).
SELECT DISTINCT
		inventory.InventoryID,
		inventory.stock,
		bin.binID,
		cabinet.cabinetid,
		cabinet.shelfcount		
FROM Inventory
join bin on inventory.InventoryID = bin.InventoryID
join cabinet on bin.binID = cabinet.binID;

---Query 8: Use GROUP BY and HAVING in a select statement using one or more tables.
SELECT VendorID, 
	   COUNT(OrderID) as "OrderCount"
FROM Vendor
GROUP BY VendorID
HAVING COUNT(OrderID) < 5;

---Query 9: Use IN clause to select data from the "Bin" table.
SELECT *
FROM Bin
WHERE inventoryid 
IN (SELECT inventoryid FROM Inventory);

---Query 10: Select the length of the "CompanyName" column from the "Vendor" 
---table using the LENGTH function.
SELECT CompanyName, LENGTH(CompanyName) as NameLength
FROM Vendor;

---Query 11: Delete one record from the "Inventory" table. Use select statements to 
---demonstrate the table contents before and after the DELETE statement.
-- Before DELETE
SELECT * FROM Inventory;

-- Delete one record
BEGIN;
DELETE FROM Inventory WHERE stock = 85;

-- After DELETE
SELECT * FROM Inventory;
-- Perform ROLLBACK to undo the DELETE
ROLLBACK;
SELECT * FROM Inventory;

---Query 12: Update one record in the "Vendor" table. Use select statements to demonstrate the table 
---contents before and after the UPDATE statement.
-- Before UPDATE
SELECT * FROM Vendor WHERE VendorID = 301 ;
	
-- Update one record
BEGIN;
UPDATE Vendor SET CompanyName = 'New Vendor Name' WHERE VendorID = 301;

-- After UPDATE
SELECT * FROM Vendor WHERE VendorID = 301 ;
-- Perform ROLLBACK to undo the UPDATE
ROLLBACK;
SELECT * FROM Vendor WHERE VendorID = 301 ;


---Advanced Queries:
---Advanced Query 1: Use a subquery to find the Vendor with the most orders.
SELECT VendorID, 
	   CompanyName
FROM Vendor
WHERE VendorID = (
    SELECT VendorID
    FROM Vendor
    GROUP BY VendorID
    ORDER BY COUNT(OrderID) DESC
    LIMIT 1
);

---Advanced Query 2: Find the top 5 Vendors with the highest total ordered quantity of items.
SELECT v.vendorid, 
	   v.companyname, 
	   SUM(i.ordered) as "TotalOrdered"
FROM Vendor v
JOIN "Order" o
ON v.orderid = o.orderid
JOIN inventory i
ON o.inventoryid = i.inventoryid
GROUP BY v.VendorID, v.CompanyName
ORDER BY "TotalOrdered" DESC
LIMIT 5;
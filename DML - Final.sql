--Insert statements
INSERT INTO Inventory (Stock, Ordered, InventoryCategoryID, I_Description)
VALUES
    (50, 20, 1, 'Raw steel materials for production'),
    (30, 10, 2, 'Electronic components for assembly line'),
    (80, 15, 1, 'Machinery spare parts for maintenance'),
    (25, 5, 3, 'Plastic materials for product manufacturing'),
    (60, 25, 2, 'Safety gear and equipment for workers'),
    (40, 30, 1, 'Packaging materials for finished products'),
    (70, 18, 3, 'Industrial machinery components for upgrades'),
    (15, 10, 2, 'Metal parts for assembly line maintenance'),
    (90, 35, 1, 'Bulk materials for production run'),
    (100, 40, 2, 'Tools and equipment for factory operations'),
	(85, 45, 2, 'Tools and equipment for packaging operations');

-- Insert sample data into the "Order" table

INSERT INTO "Order" (InventoryID, Quantity, O_Description, OrderDate, UnitPrice)
VALUES
    (201, 10, 'Steel raw material for production batch A', '2023-10-01', 50.00),
    (202, 8, 'Electronic components for assembly line B', '2023-10-02', 40.00),
    (206, 12, 'Machinery spare parts order for maintenance', '2023-10-03', 60.00),
    (202, 5, 'Plastic materials for product manufacturing', '2023-10-04', 30.00),
    (207, 7, 'Safety gear and equipment for workers', '2023-10-05', 70.00),
    (206, 11, 'Packaging materials for finished products', '2023-10-06', 45.00),
    (210, 6, 'Industrial machinery components for upgrades', '2023-10-07', 80.00),
    (208, 9, 'Metal parts for assembly line maintenance', '2023-10-08', 55.00),
    (209, 14, 'Bulk materials for production run', '2023-10-09', 70.00),
    (210, 15, 'Tools and equipment for factory operations', '2023-10-10', 100.00);


-- Insert sample data into the Vendor table


--Insert statements
INSERT INTO Vendor (OrderID, PostalCode, CompanyName, Address, PhoneNo)
VALUES
    (107, '12345', 'SupplierTech Industries, Inc.', '123 Procurement Way, Cityville', '123-456-7890'),
    (105, '23456', 'MegaParts Corp.', '456 Parts Street, Townsville', '234-567-8901'),
    (105, '34567', 'GlobalMaterials Ltd.', '789 Materials Avenue, Supplierstown', '345-678-9012'),
    (104, '45678', 'Precision Components Co.', '234 Factory Road, Manufacturer City', '456-789-0123'),
    (108, '56789', 'TechSupplies Innovations', '567 Tech Lane, Procuretown', '567-890-1234'),
    (105, '67890', 'Machinery Solutions Inc.', '123 Equip Way, Productionville', '678-901-2345'),
    (109, '78901', 'Material Source Group', '789 Material Street, Materialtown', '789-012-3456'),
    (110, '89012', 'TechWare Resources', '890 Tech Ave, Techville', '890-123-4567'),
    (105, '90123', 'Industrial Gear Corp.', '901 Gear Road, Industrialtown', '901-234-5678'),
    (106, '01234', 'Equipment Essentials Ltd.', '012 Equipment Blvd, Suppliercity', '012-345-6789');


-- Insert sample data into the Bin table

--Insert statements
INSERT INTO Bin (InventoryID, B_Active, B_Size, B_Color, B_Description)
VALUES
    (206, true, 'Large', 'Blue', 'Large Steel Materials Storage Bin'),
    (205, true, 'Medium', 'Red', 'Medium Electronic Components Bin'),
    (208, true, 'Large', 'Green', 'Large Machinery Spare Parts Bin'),
    (204, false, 'Small', 'Yellow', 'Small Plastic Materials Storage Bin'),
    (210, true, 'Medium', 'Blue', 'Medium Safety Gear Storage Bin'),
    (209, false, 'Small', 'Green', 'Small Packaging Materials Storage Bin'),
    (208, true, 'Large', 'Red', 'Large Industrial Machinery Components Bin'),
    (210, true, 'Medium', 'Yellow', 'Medium Metal Parts Storage Bin'),
    (204, false, 'Small', 'Blue', 'Small Bulk Materials Storage Bin'),
    (206, true, 'Large', 'Green', 'Large Tools and Equipment Storage Bin');
	

-- Insert sample data into the Cabinet table


--Insert statements
INSERT INTO Cabinet (BinID, ShelfCount, BinCount, C_Active, C_Description)
VALUES
    (3, 5, 10, true, 'Large Storage Cabinet for Raw Materials'),
    (3, 4, 8, false, 'Medium Cabinet for Components and Parts'),
    (2, 6, 12, true, 'Large Cabinet for Machinery Spare Parts'),
    (1, 3, 6, false, 'Small Storage Cabinet for Plastic Materials'),
    (1, 5, 10, true, 'Medium Cabinet for Safety Gear and Equipment'),
    (4, 4, 8, true, 'Small Cabinet for Packaging Materials'),
    (6, 6, 12, false, 'Large Cabinet for Industrial Machinery Components'),
    (8, 5, 10, true, 'Medium Storage Cabinet for Metal Parts'),
    (10, 4, 8, false, 'Small Cabinet for Bulk Materials'),
    (5, 6, 12, true, 'Large Cabinet for Tools and Equipment');

-- Inserting a value in the OrderDetails table
INSERT INTO OrderDetails (OrderID, InventoryID)
VALUES (101,201),
	   (102,202),
	   (103,206),
	   (104,202),
	   (105,207),
	   (106,206),
	   (107,210),
	   (108,208),
	   (109,209),
	   (110,210);
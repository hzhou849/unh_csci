-- --------------------------------------------------------------------------------
/* CSCI 6632 - Fianl project
 * 
 */


-- DROP SCHEMA IF EXISTS final_project_planet_express;
SET @_currentSchema := (SELECT DATABASE());
SELECT CONCAT('Selected Schema:',  @_currentSchema);


SET @_result := (SELECT IF(@_currentSchema LIKE 'final%', 
    'True' , 
   'False')); 
SELECT CONCAT ('RESULT: ', @_result);



CREATE SCHEMA IF NOT EXISTS final_project_planet_express;


-- Select Schema
USE final_project_planet_express;

-- Create Employee Table and Insert Data
START TRANSACTION;
CREATE TABLE IF NOT EXISTS Employee(
    EmployeeID      SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    FirstName       VARCHAR(32) NOT NULL,
    LastName        VARCHAR(32) NOT NULL,
    JobTitle        VARCHAR(10) NOT NULL,
    PhoneExt        SMALLINT NOT NULL, 
    Email           VARCHAR(64) NOT NULL,
    PRIMARY KEY (EmployeeID), 

    -- Prevent employee with same email
    UNIQUE (EmployeeID, Email),
    UNIQUE (PhoneExt),
    -- Check
    CHECK (JobTitle IN ('COURIER', 'MANAGER', 'ADMIN'))
) AUTO_INCREMENT=1001;

INSERT INTO Employee (FirstName, LastName, JobTitle, PhoneExt, Email) VALUES
    ('Philip', 'Fry', 'COURIER', 101, 'pfry@planet_express.com'),
    ('Leela', 'Turanga', 'COURIER', 102, 'lturang@planet_express.com'),
    ('Bender', 'Rodriguez', 'COURIER', 103, 'bRodrig@planet_express.com'),
    ('Hubert', 'Farnsworth', 'MANAGER', 104, 'hFarns@planet_express.com'),
    ('Amy', 'Wong', 'ADMIN', 105, 'awong@planet_express.com' ),
    ('Hermes', 'Conrad', 'ADMIN', 106, 'hConrad@planet_express.com'),
    ('John', 'Zoidberg', 'ADMIN', 107, 'jzoid@planet_express.com');

COMMIT;


-- Create Customer Table
DROP TABLE IF EXISTS Customer;
START TRANSACTION;
CREATE TABLE IF NOT EXISTS Customer(
    CustomerID      SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    FirstName       VARCHAR(32) NOT NULL,
    LastName        VARCHAR(32) NOT NULL,
    Phone           VARCHAR(12) NOT NULL,
    Email           VARCHAR(64) NOT NULL,
    
    PRIMARY KEY (CustomerID),
    UNIQUE( Email),
    -- Check phone number is 7 characters
    CHECK(LENGTH(Phone) = 8 )
) AUTO_INCREMENT=1001;

INSERT INTO Customer (FirstName, LastName, Phone, Email) VALUES
('Abner', 'Doubledeal', '827-1111', 'dealOrNoDeal@gmail.com'),
('Adlai', 'Atkins', '890-9477', 'atkinsDiet@yahoo.com'),
('Angus', 'MacZongo', '263-5798', 'angusWellDone@gmail.com'),
('Colleen', 'OHallahan', '345-5848','colleenCrazy@hotmail.com'),
('Elizabeth', 'Bennet', '462-3789', 'eggsBennetDict@xfinity.com'),
('Erwin', 'Shrodinger', '628-5482', 'shrodingersCat@yale.edu'),
('Floyd', 'Farnsworth', '269-9437', 'intoTheFloyd@nasa.gov'),
('Frida', 'Waterfall', '267-8239', 'dontGoChasingWaterfalls@outlook.com'),
('Gary', 'Gygax', '820-3749', 'willGaryYouAllTheWay@dependableMovers.com'),
('Hank', 'Aaron', '218-7848', 'hankTheTank@mlb.com')
;

-- Create Order table
DROP TABLE IF EXISTS ShippingOrder;
START TRANSACTION;
CREATE TABLE IF NOT EXISTS ShippingOrder (
    OrderNum            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    CustomerID          SMALLINT UNSIGNED NOT NULL,
    FromAddr            VARCHAR(64) NOT NULL,
    FromState           VARCHAR(8) NOT NULL,
    DestinationAddr     VARCHAR(64) NOT NULL,
    DestinationState    VARCHAR(8) NOT NULL,
    CreatedDate         DATETIME NOT NULL,
    CloseDate           DATETIME DEFAULT NULL,
    OrderStatus         VARCHAR(32) DEFAULT 'PENDING',

    PRIMARY KEY (OrderNum),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CHECK( LENGTH(FromState) = 2 ),
    CHECK( LENGTH(DestinationState) = 2 ),
    CHECK( OrderStatus IN( 'PENDING', 'IN PROGRESS', 'FULLFILLED'))
) AUTO_INCREMENT =333001;

INSERT INTO ShippingOrder (CustomerID, FromAddr, FromState, DestinationAddr, DestinationState, CreatedDate ) VALUES
(1006, '238 Willow St', 'CT', '829 Barney Ave', 'NY',       '2024-07-01 08:23:00'),
(1004, '93 GreenHedge Dr', 'CT', '922 Melverne Ave', 'MA',  '2024-07-01 08:38:00'),
(1008, '9829 Archer Ave', 'NY', '104 Whitney Ave', 'CT',    '2024-07-01 10:15:00'),
(1008, '9829 Archer Ave', 'NY', '829 State St', 'MA',       '2024-07-03 10:18:00'),
(1003, '123 Pond Rd', 'CT', '323 Fake St', 'MA',            '2024-07-03 08:49:00'),
(1005, '533 Indian Rd', 'MA', '438 Summer Ave', 'CT',       '2024-08-12 09:23:00'),
(1006, '238 Willow St', 'CT', '124 Wavery St', 'NY',        '2024-08-12 12:12:00'),
(1002, '12 Grand Magazine Ave', 'CT', '900 Ocean Ave', 'NY','2024-09-02 15:00:00'),
(1001, '213 Sterling Ave', 'MA', '123 Saybrook Ave', 'CT',  '2024-09-02 15:23:00'),
(1007, '78 Marshall Ave', 'NY', '384 RuralCity Rd', 'CT',   '2024-09-13 14:58:00'),
(1009, '3809 Shoreline St', 'CT', '920 Easy Rd', 'NY',      '2024-10-12 09:22:00'),
(1001, '213 Sterling Ave', 'MA', '54th Ave', 'NY',          '2024-10-12 15:23:00'),
(1010, '421 Longwarf Dr', 'NY', '809 Violet Ave', 'MA',     '2024-11-01 08:28:00'),
(1004, '93 GreenHedge Dr', 'MA', '922 Melverne Ave', 'CT',  '2024-11-01 010:38:00'),
(1005, '533 Indian Rd', 'MA', '438 Summer Ave', 'CT',       '2024-11-01 11:33:00'),
(1001, '213 Sterling Ave', 'MA', '123 Saybrook Ave', 'CT',  '2024-11-01 11:41:00')
;
COMMIT;






/* ============================================================================================================== */
-- Create ROUTE table
DROP TABLE IF EXISTS Route;
START TRANSACTION;
CREATE TABLE Route (
    RouteID        SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    Origin         VARCHAR(2) NOT NULL,
    Destination    VARCHAR(2) NOT NULL,

    PRIMARY KEY (RouteID),
    CHECK ( LENGTH(Origin) = 2),
    CHECK ( LENGTH(Destination) = 2)
);

INSERT INTO Route(Origin, Destination) VALUES
    ('CT', 'NY'),
    ('CT', 'MA'),
    ('MA', 'CT'),
    ('MA', 'NY'),
    ('NY', 'CT'),
    ('NY', 'MA');
COMMIT;


/* ============================================================================================================== */
-- CREATE Vehicle Table
DROP TABLE IF EXISTS Vehicle;
START TRANSACTION;
CREATE TABLE Vehicle (
    VehicleID           SMALLINT NOT NULL AUTO_INCREMENT,
    Carry_capacity      TINYINT DEFAULT 0,
    LastCheckInState    VARCHAR (2) NOT NULL,
    AvailabilityStatus  VARCHAR(16) DEFAULT 'AVAILABLE',

    PRIMARY KEY (VehicleID),
    CHECK ( LENGTH(LastCheckInState) = 2 ),
    CHECK ( AvailabilityStatus IN('AVAILABLE', 'UNAVAILABLE', 'IN-REPAIR'))
 
);

INSERT INTO Vehicle( LastCheckInState, AvailabilityStatus) VALUES
    ('CT', 'AVAILABLE'),
    ('CT', 'AVAILABLE'), 
    ('MA', 'AVAILABLE'),
    ('MA', 'AVAILABLE'),
    ('NY', 'AVAILABLE'),
    ('NY', 'AVAILABLE'),
    ('CT', 'IN-REPAIR'),
    ('MA', 'IN-REPAIR'),
    ('CT', 'AVAILABLE'),
    ('MA', 'AVAILABLE')
;
COMMIT;


/* ============================================================================================================== */
-- CREATE Scheduled_drive_session
DROP TABLE IF EXISTS Scheduled_drive_session;
START TRANSACTION;
CREATE TABLE Scheduled_drive_session (
    SessionID       SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    -- ManifestNum     SMALLINT UNSIGNED DEFAULT NULL,
    RouteID         SMALLINT UNSIGNED NOT NULL, 
    VehicleID       SMALLINT UNSIGNED NOT NULL, 
    EmployeeID      SMALLINT UNSIGNED NOT NULL,     
    StartTime       DATETIME NOT NULL,
    ArrivedTime     DATETIME DEFAULT NULL,
    CompletedStatus BOOLEAN DEFAULT false,

    PRIMARY KEY (SessionID), 
    -- FOREIGN KEY (ManifestNum) REFERENCES Cargo_manifest(ManifestNum),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID), 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)AUTO_INCREMENT=801;
COMMIT;

-- Trigger to create Manifest when drive session is created
DROP TRIGGER IF EXISTS trigger_manifest_insert;
DELIMITER //
CREATE TRIGGER trigger_manifest_insert 
AFTER INSERT on Scheduled_drive_session
FOR EACH ROW
BEGIN
    INSERT INTO Cargo_manifest (DriveSessionID, CreatedDate )
    VALUES (new.SessionID,new.StartTime );
END; 
//
DELIMITER ;

-- -- Trigger to auto update package status to develivered if drive is completed
-- DROP TRIGGER IF EXISTS trigger_update_delivery_status
-- DELIMITER //
-- CREATE TRIGGER trigger_update_delivery_status
-- AFTER UPDATE on Scheduled_drive_session
-- FOR EACH ROW
-- BEGIN
--     IF NEW.CompletedStatus = true THEN
--         UPDATE Package
--         SET PackageStatus = 'DELIVERED'
--         WHERE Package.ManifestNum = view

/* Query used to link Shipping order source/destination to route number:
 * SELECT * FROM ShippingOrder, Route
 * WHERE Route.origin = ShippingOrder.FromState
 * AND DestinationState = Route.Destination
 * ORDER BY Route.RouteID AND CreatedDate;
*/

INSERT INTO Scheduled_drive_session( RouteID, VehicleID, EmployeeID, StartTime) VALUES
    (1, 1, 1001, '2024-07-01 18:00'),
    (2, 2, 1002, '2024-07-01 18:01'),
    (5, 5, 1003, '2024-07-01 18:02'),
    (6, 6, 1004, '2024-07-03 18:15'),
    (2, 1, 1001, '2024-07-03 18:20'),
    (3, 3, 1002, '2024-08-12 17:10'),
    (1, 2, 1002, '2024-08-12 17:12'),
    (1, 1, 1003, '2024-09-02 17:34'),
    (3, 4, 1004, '2024-09-02 17:48'),
    (5, 9, 1001, '2024-09-13 17:08'),
    (1, 2, 1002, '2024-10-12 17:23'),
    (4, 10, 1003, '2024-10-12 17:30'),
    (6, 5, 1004, '2024-11-01 17:02'),
    (3, 3, 1001, '2024-11-01 17:12');

/* ============================================================================================================== */
-- CREATE Shipping Manifest
DROP TABLE IF EXISTS Cargo_manifest;
START TRANSACTION;
CREATE TABLE IF NOT EXISTS Cargo_manifest(
    ManifestNum     SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    DriveSessionID  SMALLINT UNSIGNED NOT NULL,
    CreatedDate     DATETIME DEFAULT NULL,
    PRIMARY KEY (ManifestNum),
    FOREIGN KEY (DriveSessionID) REFERENCES Scheduled_drive_session(SessionID)

)AUTO_INCREMENT=100;

COMMIT;

-- NOT USING NOW
-- -- TRIGGER to update the Scheduled_drive_session with the manifest number. 
-- DELIMITER //
-- CREATE TRIGGER trigger_update_manifest_scheduled_drive_session
-- AFTER INSERT on Cargo_manifest
-- FOR EACH ROW
-- BEGIN
--     UPDATE Scheduled_drive_session
--     SET old.ManifestNum = new.ManifestNum
--     WHERE Scheduled_drive_session.SessionID = new.DriveSessionID;
-- END;
-- //
-- DELIMITER ;


/* ============================================================================================================== */


-- Create Package table
DROP TABLE IF EXISTS Package;
START TRANSACTION;
CREATE TABLE IF NOT EXISTS Package (
    PackageID       INT UNSIGNED NOT NULL AUTO_INCREMENT,
    OrderNum        INT UNSIGNED NOT NULL,
    ManifestNum     SMALLINT UNSIGNED DEFAULT NULL,
    Length_inch     SMALLINT NOT NULL DEFAULT 0,
    Width_inch      SMALLINT NOT NULL DEFAULT 0,
    Height_inch     SMALLINT NOT NULL DEFAULT 0,
    Weight_lbs      SMALLINT NOT NULL DEFAULT 0,
    PackageStatus   VARCHAR(32) DEFAULT 'PENDING',

    PRIMARY KEY (PackageID),
    FOREIGN KEY (OrderNum) REFERENCES ShippingOrder(OrderNum),
    FOREIGN KEY (ManifestNum) REFERENCES Cargo_manifest(ManifestNum),
    CHECK( PackageStatus IN( 'PENDING', 'IN PROGRESS', 'DELIVERED'))

) AUTO_INCREMENT=111001;

INSERT INTO Package (OrderNum, Length_inch, Width_inch, Height_inch, Weight_lbs) VALUES
    (333001, 18, 22, 100, 78),
    (333001, 22, 10, 20, 38),
    (333001, 389, 38, 12, 300),
    (333002, 89, 28, 81, 210),
    (333002, 43, 98, 32, 55), 
    (333003, 40, 89, 12, 30), 
    (333004, 12, 28, 89, 39),
    (333005, 98, 324, 34, 100),
    (333006, 89, 123, 89, 250),
    (333006, 72, 143, 94, 292),
    (333007, 123, 123, 89, 89), 
    (333008, 89, 30, 23, 50), 
    (333009, 22, 22, 38, 30), 
    (333009, 21, 213, 42, 40),
    (333010, 10, 15, 5, 10), 
    (333011, 15, 20, 6, 15), 
    (333012, 9, 8, 2, 5),
    (333013, 10, 10, 3, 10),
    (333014, 10, 20, 10, 50), 
    (333015, 12, 12, 8, 13),
    (333015, 10, 15, 6, 12),
    (333016, 9, 21, 12, 100);

COMMIT;
/* ==============================================================================================================
 * Queries
 * ============================================================================================================== 
 */

/* =========================================================================================================
 * Part A) i)  Simple query
 * Simple SELECT query to show orders 
 */
 -- MYSQL Query:
SELECT * FROM ShippingOrder;

/* =========================================================================================================
 * ii) With ORDER BY
 * Simple SELECT query using ORDER BY to sort orders by the CustomerID field.
 *
 * Example of result:
 * +----------+------------+-----------+------------------+---------------------+---------+--------+-------------+
 * | Ordernum | CustomerID | FromState | DestinationState | CreatedDate         | RouteId | Origin | Destination |
 * +----------+------------+-----------+------------------+---------------------+---------+--------+-------------+
 * |   333001 |       1006 | CT        | NY               | 2024-07-01 08:23:00 |       1 | CT     | NY          |
 * |   333002 |       1004 | CT        | MA               | 2024-07-01 08:38:00 |       2 | CT     | MA          |
 * |   333003 |       1008 | NY        | CT               | 2024-07-01 10:15:00 |       5 | NY     | CT          |
 * |   333004 |       1008 | NY        | MA               | 2024-07-03 10:18:00 |       6 | NY     | MA          |
 * |   333005 |       1003 | CT        | MA               | 2024-07-03 08:49:00 |       2 | CT     | MA          |
 * |   333006 |       1005 | MA        | CT               | 2024-08-12 09:23:00 |       3 | MA     | CT          |
 * |   333007 |       1006 | CT        | NY               | 2024-08-12 12:12:00 |       1 | CT     | NY          |
 * |   333008 |       1002 | CT        | NY               | 2024-09-02 15:00:00 |       1 | CT     | NY          |
 * |   333009 |       1001 | MA        | CT               | 2024-09-02 15:23:00 |       3 | MA     | CT          |
 * |   333010 |       1007 | NY        | CT               | 2024-09-13 14:58:00 |       5 | NY     | CT          |
 * |   333011 |       1009 | CT        | NY               | 2024-10-12 09:22:00 |       1 | CT     | NY          |
 * |   333012 |       1001 | MA        | NY               | 2024-10-12 15:23:00 |       4 | MA     | NY          |
 * |   333013 |       1010 | NY        | MA               | 2024-11-01 08:28:00 |       6 | NY     | MA          |
 * |   333014 |       1004 | MA        | CT               | 2024-11-01 10:38:00 |       3 | MA     | CT          |
 * |   333015 |       1005 | MA        | CT               | 2024-11-01 11:33:00 |       3 | MA     | CT          |
 * |   333016 |       1001 | MA        | CT               | 2024-11-01 11:41:00 |       3 | MA     | CT          |
 * +----------+------------+-----------+------------------+---------------------+---------+--------+-------------+
 */

-- MYSQL Query: 
SELECT * FROM ShippingOrder, Route
WHERE Route.origin = ShippingOrder.FromState
AND DestinationState = Route.Destination
ORDER BY Route.RouteID AND CreatedDate;

 /* =========================================================================================================
  * iii) DISTINCT
  * Query will show all vehicle availability statuses, 
  * using the Distinct will prevent duplicate rows and only show the type of available states.
  * 
  * Example: Without DISTINCT:          EXAMPLE with DISTINCT:
  * +--------------------+              +--------------------+
  * | AvailabilityStatus |              | AvailabilityStatus |
  * +--------------------+              +--------------------+
  * | AVAILABLE          |              | AVAILABLE          |
  * | AVAILABLE          |              | IN-REPAIR          |
  * | AVAILABLE          |              +--------------------+
  * | AVAILABLE          |        
  * | AVAILABLE          |        
  * | AVAILABLE          |        
  * | IN-REPAIR          |        
  * | IN-REPAIR          |        
  * | AVAILABLE          |        
  * | AVAILABLE          |        
  * +--------------------+        
  */

-- MYSQL Query:
SELECT DISTINCT AvailabilityStatus FROM vehicle;

/* ==========================================================================================================
 * iv) AND / OR WHERE Clause
 * This will shipping orders that originate from 'NY' or 'MA' that were created after Oct 01 2024
 * 
 *  * Example of result: 
 * +----------+------------+------------------+-----------+---------------------+
 *  | Ordernum | customerID | FromAddr         | FromState | CreatedDate         |
 *  +----------+------------+------------------+-----------+---------------------+
 *  |   333012 |       1001 | 213 Sterling Ave | MA        | 2024-10-12 15:23:00 |
 *  |   333013 |       1010 | 421 Longwarf Dr  | NY        | 2024-11-01 08:28:00 |
 *  |   333014 |       1004 | 93 GreenHedge Dr | MA        | 2024-11-01 10:38:00 |
 *  |   333015 |       1005 | 533 Indian Rd    | MA        | 2024-11-01 11:33:00 |
 *  |   333016 |       1001 | 213 Sterling Ave | MA        | 2024-11-01 11:41:00 |
 *  +----------+------------+------------------+-----------+---------------------+
 */
SELECT Ordernum, customerID, FromAddr, FromState, CreatedDate FROM ShippingOrder
WHERE FromState = 'MA' AND DATE(CreatedDate) >= '2024-10-01'
OR FromState = 'NY' AND DATE(CreatedDate) >='2024-10-01';


 
/* ==========================================================================================================
 * v) Use of 'IN' operator
 * This statement selects Filters the employee names for 'Philip', 'Hubert' and 'John'
 * 
 * Example of result:
 * +------------+-----------+------------+----------+----------+---------------------------+
 * | EmployeeID | FirstName | LastName   | JobTitle | PhoneExt | Email                     |
 * +------------+-----------+------------+----------+----------+---------------------------+
 * |       1001 | Philip    | Fry        | COURIER  |      101 | pfry@planet_express.com   |
 * |       1004 | Hubert    | Farnsworth | MANAGER  |      104 | hFarns@planet_express.com |
 * |       1007 | John      | Zoidberg   | ADMIN    |      107 | jzoid@planet_express.com  |
 * +------------+-----------+------------+----------+----------+---------------------------+
 */

-- MYSQL Query:
SELECT * FROM Employee
WHERE FirstName IN('Philip', 'Hubert', 'John');


/* ==========================================================================================================
 * vi) Use of 'LIKE' operator:
 * Search the employee records for an Email that contains the substring 'prfy%' in it. 
 * 
 * Example of result: 
 * +------------+-----------+----------+----------+----------+-------------------------+
 * | EmployeeID | FirstName | LastName | JobTitle | PhoneExt | Email                   |
 * +------------+-----------+----------+----------+----------+-------------------------+
 * |       1001 | Philip    | Fry      | COURIER  |      101 | pfry@planet_express.com |
 * +------------+-----------+----------+----------+----------+-------------------------+
 */

 -- MYSQL Query:
SELECT * FROM Employee 
WHERE Email LIKE 'pfry%';


/* ==========================================================================================================
 * B1) Aggregate Functions:
 * Count the total number of orders made by customerID 
 *
 * Example of results:
 * +------------+----------+
 * | CustomerId | COUNT(*) |
 * +------------+----------+
 * |       1001 |        3 |
 * |       1002 |        1 |
 * |       1003 |        1 |
 * |       1004 |        2 |
 * |       1005 |        2 |
 * |       1006 |        2 |
 * |       1007 |        1 |
 * |       1008 |        2 |
 * |       1009 |        1 |
 * |       1010 |        1 |
 * +------------+----------+
 */

 -- MYSQL Query:
SELECT CustomerId, COUNT(*) FROM ShippingOrder
GROUP BY CustomerID;

/* ==========================================================================================================
/* B2)  Count the number of drive sessions made by employeeId:
 * +------------+----------+
 * | EmployeeID | COUNT(*) |
 * +------------+----------+
 * |       1001 |        4 |
 * |       1002 |        4 |
 * |       1003 |        3 |
 * |       1004 |        3 |
 * +------------+----------+
 */

 -- MYSQL Query:
SELECT EmployeeID, COUNT(*) FROM scheduled_drive_session
GROUP BY EmployeeID;


/* ==========================================================================================================
/* B3)  Find the package that has the least (MIN) weight shipped:
 * 
 * Example result:
 * +-----------+----------+-------------+-------------+------------+-------------+------------+
 * | PackageID | OrderNum | ManifestNum | Length_inch | Width_inch | Height_inch | Weight_lbs |
 * +-----------+----------+-------------+-------------+------------+-------------+------------+
 * |    111017 |   333012 |         111 |           9 |          8 |           2 |          5 |
 * +-----------+----------+-------------+-------------+------------+-------------+------------+
 *
 */
-- MYSQL Query:
SELECT  * FROM Package
WHERE Weight_lbs = ( SELECT MIN(Weight_lbs) FROM Package );


/* ==========================================================================================================
 * C1) SELF JOIN:
 * Selects all the different the rows of customers that are living in the same state 
 * Then ordred by customer ID numbers
 */
SELECT DISTINCT C1.CustomerID AS C1_ID, 
C1.FromState AS C1_FromState, 
C2.CustomerID AS C2_ID, C2.FromState AS C2_FromState
FROM ShippingOrder AS C1, ShippingOrder AS C2
WHERE C1.CustomerID != C2.CustomerID
AND C1.FromState = C2.FromState
ORDER BY C1.CustomerID ASC, C2.CustomerID ASC;


/* ==========================================================================================================
 * C2) INNER JOIN
 * This query takes the Scheduled_drive_session table and INNER JOINS Cargo Manifest 
 * on the sessionID/DriveSessionID to return the manifest number for each 
 * scheduled drive session, then further joined again match the appropriate shippingOrders/Route
 * table so we have a final view of SessionID from scheduled_drive_session table, 
 * RouteID from Route table, ManifestNum from Cargo_manifest and OrderNum from shipping orders table 
 * to link and cross-reference into one full shipment view
 */
SELECT t1.SessionID, t1.RouteID, t1.manifestNum, 
t2.RouteId, t2. OrderNum, t2.Origin, t2.Destination, t2.createdDate
FROM ( 
	SELECT *
    FROM scheduled_drive_session as S
    INNER JOIN Cargo_manifest as c
    ON S.SessionID = c.DriveSessionID 
	) as t1
 JOIN
 ( SELECT * 
   FROM Route, ShippingOrder 
	WHERE Route.Origin = ShippingOrder.FromState 
    AND Route.Destination = ShippingORder.DestinationState
) AS t2
ON t1.RouteID = t2.RouteID
WHERE DATE(t1.StartTime) = DATE(t2.CreatedDate)
ORDER BY t2.CreatedDate ASC, t2.orderNum ASC;


/* ==========================================================================================================
 * C3) FULL JOIN
 * In this view, all customers and shipping orders that are related to them are shown 
 */
 SELECT Customer.FirstName AS FirstName, shippingOrder.OrderNum AS OrderNum
FROM Customer
LEFT JOIN ShippingOrder ON Customer.CustomerID = shippingorder.CustomerID
UNION
SELECT Customer.FirstName, shippingOrder.OrderNum
FROM ShippingOrder
RIGHT JOIN Customer ON Customer.CustomerID = shippingorder.CustomerID;


/* ==========================================================================================================
 * D) GROUP BY HAVING
 */

-- SELECT the orders that have 2 or more packages 
SELECT OrderNum, COUNT(*)
FROM Package
GROUP BY OrderNum
HAVING COUNT(*) >= 2;


/* ==========================================================================================================
 * E) VIEWs
 */


-- VIEW 1:



-- VIEW 2:
-- This view is to match the Route number to the shipping orders, based on matching the 
-- Origin and destination from the route table to the shipping order's delivery.
CREATE VIEW Route_shipping_view
AS
SELECT R.RouteID, R.Origin, R.Destination, SO.customerID, SO.FromState, SO.DestinationState  
FROM Route as R, ShippingOrder as SO 
WHERE R.Origin = SO.FromState 
AND R.Destination = SO.DestinationState;

-- To test the view
SELECT * FROM Route_shipping_view;

-- VIEW 3:
-- Since combined shipment view from question C2) is a very complicated query, we will create a view 
-- so that 'FullshipmentDetailView' can be easily called when needed
	CREATE VIEW fullshipmentView
    AS SELECT * FROM (
	SELECT t1.SessionID, t1.RouteID, t1.manifestNum, 
	 t2. OrderNum, t2.Origin, t2.Destination, t2.createdDate
	FROM ( 
		SELECT *
		FROM scheduled_drive_session as S
		INNER JOIN Cargo_manifest as c
		ON S.SessionID = c.DriveSessionID 
		) as t1
	 JOIN
	 ( SELECT * 
	   FROM Route, ShippingOrder 
		WHERE Route.Origin = ShippingOrder.FromState 
		AND Route.Destination = ShippingORder.DestinationState
	) AS t2
	ON t1.RouteID = t2.RouteID
	WHERE DATE(t1.StartTime) = DATE(t2.CreatedDate)
	ORDER BY t2.CreatedDate ASC, t2.orderNum ASC
 ) as v1;

-- To test the view
SELECT * FROM  fullshipmentView;



/* ==========================================================================================================
 *  F 1) TRIGGERS
 * ThiS trigger will update the 
 * Trigger Before:
 * +-----------+----------+-------------+-------------+------------+-------------+------------+---------------+
 * | PackageID | OrderNum | ManifestNum | Length_inch | Width_inch | Height_inch | Weight_lbs | PackageStatus |
 * +-----------+----------+-------------+-------------+------------+-------------+------------+---------------+
 * |    111001 |   333001 |         100 |          18 |         22 |         100 |         78 | PENDING       |
 * |    111002 |   333001 |         100 |          22 |         10 |          20 |         38 | PENDING       |
 * |    111003 |   333001 |         100 |         389 |         38 |          12 |        300 | PENDING       |
 * 
 * After an UPDATE to the shippingOrder table when OrderStatus is set to 'FULLFILLED':
 * +-----------+----------+-------------+-------------+------------+-------------+------------+---------------+
 * | PackageID | OrderNum | ManifestNum | Length_inch | Width_inch | Height_inch | Weight_lbs | PackageStatus |
 * +-----------+----------+-------------+-------------+------------+-------------+------------+---------------+
 * |    111001 |   333001 |         100 |          18 |         22 |         100 |         78 | DELIVERED     |
 * |    111002 |   333001 |         100 |          22 |         10 |          20 |         38 | DELIVERED     |
 * |    111003 |   333001 |         100 |         389 |         38 |          12 |        300 | DELIVERED     |
 */

DROP TRIGGER IF EXISTS update_package_status;

DELIMITER //
CREATE TRIGGER update_package_status 
AFTER UPDATE ON shippingOrder
FOR EACH ROW
BEGIN
    IF NEW.OrderStatus = 'FULLFILLED' THEN
        UPDATE Package
        SET Package.PackageStatus = 'DELIVERED'
        WHERE Package.OrderNum = OLD.OrderNum;
	END IF;
END;
//
DELIMITER ;

-- Test Trigger
UPDATE shippingOrder
SET 
	OrderStatus = 'FULLFILLED',
    CloseDate = '2024-07-01 12:00:00'
    WHERE OrderNum = 333016;



/* ==========================================================================================================
 *  F-2) TRIGGERS
 * Trigger2 to insert a new  Manifest record when drive session is created
 */
DROP TRIGGER IF EXISTS trigger_manifest_insert;
DELIMITER //
CREATE TRIGGER trigger_manifest_insert 
AFTER INSERT on Scheduled_drive_session
FOR EACH ROW
BEGIN
    INSERT INTO Cargo_manifest (DriveSessionID, CreatedDate )
    VALUES (new.SessionID,new.StartTime );
END; 
//
DELIMITER ;

-- Test Trigger2
INSERT INTO Scheduled_drive_session( RouteID, VehicleID, EmployeeID, StartTime) VALUES
    (1, 1, 1001, CURRENT_TIMESTAMP()),



/* ==========================================================================================================
 *  F-3) TRIGGERS
 *  Before Trigger:
 * This triger updates the ShippingOrder table, which will inturn update the Packages table from the 
 * subsequent trigger above. 
 * 
 * ShippingOrders Table before TRIGGER:
 * +----------+------------+-----------------------+-----------+------------------+------------------+---------------------+---------------------+-------------+
 *| OrderNum | CustomerID | FromAddr              | FromState | DestinationAddr  | DestinationState | CreatedDate         | CloseDate           | OrderStatus |
 *+----------+------------+-----------------------+-----------+------------------+------------------+---------------------+---------------------+-------------+
 *|   333003 |       1008 | 9829 Archer Ave       | NY        | 104 Whitney Ave  | CT               | 2024-07-01 10:15:00 | NULL                | PENDING     |
 * 
 * ShippingOrders Table after TRIGGER from update on 'Scheduled_drive_session' table Status is set to TRUE:
 * +----------+------------+-----------------------+-----------+------------------+------------------+---------------------+---------------------+-------------+
| OrderNum | CustomerID | FromAddr              | FromState | DestinationAddr  | DestinationState | CreatedDate         | CloseDate           | OrderStatus |
+----------+------------+-----------------------+-----------+------------------+------------------+---------------------+---------------------+-------------+
|   333003 |       1008 | 9829 Archer Ave       | NY        | 104 Whitney Ave  | CT               | 2024-07-01 10:15:00 | 2024-07-01 22:29:00 | FULLFILLED  |
 * 
 */
-- TRIGGER 3
DROP TRIGGER IF EXISTS update_shipping_order_status;

DELIMITER //
CREATE TRIGGER update_shipping_order_status 
AFTER UPDATE ON scheduled_drive_session
FOR EACH ROW
BEGIN
    IF NEW.CompletedStatus = true THEN
        UPDATE ShippingOrder
        SET ShippingOrder.OrderStatus = 'FULLFILLED',
        CloseDate = NEW.ArrivedTime
        WHERE ShippingOrder.OrderNum = (
            SELECT OrderNum FROM (
            SELECT t2.OrderNum
			FROM ( 
				SELECT *
				FROM scheduled_drive_session as S
				INNER JOIN Cargo_manifest as c
				ON S.SessionID = c.DriveSessionID 
				) as t1
			 JOIN
			 ( SELECT * 
			   FROM Route, ShippingOrder 
				WHERE Route.Origin = ShippingOrder.FromState 
				AND Route.Destination = ShippingORder.DestinationState
			) AS t2
			ON t1.RouteID = t2.RouteID
			WHERE DATE(t1.StartTime) = DATE(t2.CreatedDate) AND t1.SessionID = OLD.SessionID
			ORDER BY t2.CreatedDate ASC, t2.orderNum ASC
            )as t3);
	END IF;
END;
//
DELIMITER ;

-- To test TRIGGER 3 use SessionID where completion status is False
UPDATE Scheduled_drive_session
SET CompletedStatus = true,
ArrivedTime = '2024-07-01 22:29:00'
WHERE SessionID=804;






















 View 1) Customer to shipping order view
 2) route to driveSession etc..


/* =================================================================================================== 
 * Other Important helpful stuff 
 * ==================================================================================================*/
-- match shipping order to package ordernum
Select * from shippingorder, package
WHERE ShippingOrder.OrderNum = Package.OrderNum;


-- final query

SELECT t1.SessionID, t1.RouteID, t1.manifestNum, 
t2.RouteId, t2. OrderNum, t2.Origin, t2.Destination, t2.createdDate
FROM ( 
	SELECT *
    FROM scheduled_drive_session as S
    INNER JOIN Cargo_manifest as c
    ON S.SessionID = c.DriveSessionID 
	) as t1
 JOIN
 ( SELECT * 
   FROM Route, ShippingOrder 
	WHERE Route.Origin = ShippingOrder.FromState 
    AND Route.Destination = ShippingORder.DestinationState
) AS t2
ON t1.RouteID = t2.RouteID
WHERE DATE(t1.StartTime) = DATE(t2.CreatedDate)
ORDER BY t2.CreatedDate ASC, t2.orderNum ASC;


-- Create view to -- Full join to get DriveSession, Cargo_manifest and Route to link together and get manifest list
	CREATE VIEW fullshipmentView
    AS SELECT * FROM (
	SELECT t1.SessionID, t1.RouteID, t1.manifestNum, 
	 t2. OrderNum, t2.Origin, t2.Destination, t2.createdDate
	FROM ( 
		SELECT *
		FROM scheduled_drive_session as S
		INNER JOIN Cargo_manifest as c
		ON S.SessionID = c.DriveSessionID 
		) as t1
	 JOIN
	 ( SELECT * 
	   FROM Route, ShippingOrder 
		WHERE Route.Origin = ShippingOrder.FromState 
		AND Route.Destination = ShippingORder.DestinationState
	) AS t2
	ON t1.RouteID = t2.RouteID
	WHERE DATE(t1.StartTime) = DATE(t2.CreatedDate)
	ORDER BY t2.CreatedDate ASC, t2.orderNum ASC
 ) as v1;

 SELECT * FROM Package
Join FUllshipmentview
on FUllshipmentview.ordernum = package.ordernum;

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

INSERT INTO Employee (EmployeeID, FirstName, LastName, JobTitle, PhoneExt, Email) VALUES
    ('Philip', 'Fry', 'COURIER', 101, 'pfry@planet_express.com'),
    ('Leela', 'Turanga', 'COURIER', 102, 'lturang@planet_express.com'),
    ('Bender', 'Rodriguez', 'COURIER', 103, 'bRodrig@planet_express.com'),
    ('Hubert', 'Farnsworth', 'MANAGER', 104, 'hFarns@planet_express.com'),
    ('Amy', 'Wong', 'ADMIN', 105, 'awong@planet_express.com' ),
    ('Hermes', 'Conrad', 'ADMIN', 106, 'hConrad@planet_express.com'),
    ('John', 'Zoidberg', 'ADMIN', 107, 'jzoid@planet_express.com');

COMMIT;

-- Create Customer Table
START TRANSACTION;
CREATE TABLE IF NOT EXISTS Customer(
    CustomerID      SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    FirstName       VARCHAR(32) NOT NULL,
    LastName        VARCHAR(32) NOT NULL,
    Phone           VARCHAR(12) NOT NULL,
    Email           VARCHAR(64) NOT NULL,
    
    PRIMARY KEY (CustomerID),
    UNIQUE(CustomerID, Email),

    -- Check phone number is 7 characters
    CHECK(LENGTH(Phone) = 7 )
) AUTO_INCREMENT = 5001;

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

COMMIT;

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
(1001, '213 Sterling Ave', 'MA', '123 Saybrook Ave', 'NY',  '2024-10-12 15:23:00'),
(1010, '421 Longwarf Dr', 'NY', '809 Violet Ave', 'MA',     '2024-11-01 08:28:00'),
(1004, '93 GreenHedge Dr', 'MA', '922 Melverne Ave', 'CT',  '2024-11-01 010:38:00'),
(1005, '533 Indian Rd', 'MA', '438 Summer Ave', 'CT',       '2024-11-01 11:33:00'),
(1001, '213 Sterling Ave', 'MA', '123 Saybrook Ave', 'CT',  '2024-11-01 11:41:00')
;
COMMIT;

/* ============================================================================================================== */
-- CREATE Shipping Manifest
DROP TABLE IF EXISTS ShippingManifest;
START TRANSACTION;
CREATE TABLE IF NOT EXISTS ShippingManifest(
    ManifestNum     SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT
    PRIMARY KEY (ManifestNum)

)AUTO_INCREMENT=900;


COMMIT;

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
    FOREIGN KEY (Manifest) REFERENCES ShippingManifest(ManifestNum),
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
    (333016, 9, 21, 12, 100),

COMMIT;

-- Create ROUTE table
DROP TABLE IF EXISTS Route;
START TRANSACTION;
CREATE TABLE Route (
    RouteID        SMALLINT NOT NULL AUTO_INCREMENT,
    Origin         VARCHAR(2) NOT NULL,
    Destination    VARCHAR(2) NOT NULL,

    PRIMARY KEY (ROUTEID),
    CHECK ( LENGTH(Origin) = 2),
    CHECK ( LENGTH(Destination) = 2)
);

INSERT INTO Route(Origin, Destination) VALUES
    (CT, NY),
    (CT, MA),
    (MA, CT),
    (MA, NY),
    (NY, CT),
    (NY, MA), 
COMMIT;


-- CREATE Vehicle Table
DROP TABLE IF EXISTS Vehicle;
START TRANSACTION;
CREATE TABLE Vehicle (
    VehicleID           SMALLINT NOT NULL,
    Carry_capacity      TINYINT DEFAULT 0,
    LastCheckInState    VARCHAR (2) NOT NULL,
    AvailabilityStatus  VARCHAR(16) DEFAULT 'AVAILABLE',

    PRIMARY KEY (VehicleID),
    CHECK ( LENGTH(LastCheckInState) = 2 ),
    CHECK ( AvailabilityStatus IN('AVAILABLE', 'UNAVAILABLE', 'IN-REPAIR'))
 
);

INSERT INTO Vehicle( LastCheckInState, AvailabilityStatus) VALUES
    (CT, 'AVAILABLE'),
    (CT, 'AVAILABLE'), 
    (MA, 'AVAILABLE'),
    (MA, 'AVAILABLE'),
    (NY, 'AVAILABLE'),
    (NY, 'AVAILABLE'),
    (CT, 'IN-REPAIR'),
    (MA, 'IN-REPAIR')
COMMIT;


-- CREATE Scheduled_drive_session
DROP TABLE IF EXISTS Scheduled_drive_session;
START TRANSACTION;
CREATE TABLE Scheduled_drive_session (
    SessionID       SMALLINT NOT NULL AUTO_INCREMENT,
    ManifestNum     SMALLINT UNSIGNED,
    RouteID         SMALLINT UNSIGNED, -- should this be left blank?        
    StartTime       DATETIME,
    ArrivedTime     DATETIME DEFAULT NULL,
    CompletedStatus BOOLEAN,

    PRIMARY KEY (SessionID), 
    FOREIGN KEY (ManifestNum) REFERENCES ShippingManifest(ManifestNum),
    FOREIGN KEY (RouteID) REFERENCES Route(RoutID), 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)


    
);

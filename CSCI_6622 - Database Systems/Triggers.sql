## SQL Triggers

```sql

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
    -- FOREIGN KEY (ManifestNum) REFERENCES ShippingManifest(ManifestNum),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID), 
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)AUTO_INCREMENT=801;
COMMIT;

INSERT INTO Scheduled_drive_session( RouteID, VehicleID, EmployeeID, StartTime) VALUES
    (1, 1, 1001, TIME_STAMP  );



-- Trigger to create Manifest when drive session is created
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
'''

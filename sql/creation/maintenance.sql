CREATE TABLE Maintenance (
    dateID INT NOT NULL,
    planeID INT NOT NULL,
    scheduledID INT NOT NULL,
    maintenance_duration FLOAT NOT NULL,
    CONSTRAINT PK_Maintenance PRIMARY KEY(dateID, planeID, scheduledID),
    CONSTRAINT FK_Maintenance_Dates FOREIGN KEY(dateID)
        REFERENCES Dates(dateID)
    CONSTRAINT FK_Maintenance_Planes FOREIGN KEY(planeID)
        REFERENCES Planes(planeID)
    CONSTRAINT FK_Maintenance_Scheduled FOREIGN KEY(scheduledID)
        REFERENCES Scheduled(scheduledID)
)
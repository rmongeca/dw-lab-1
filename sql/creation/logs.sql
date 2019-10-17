CREATE TABLE Logs (
    dateID INT NOT NULL,
    planeID INT NOT NULL,
    personID INT NOT NULL,
    log_count INT NOT NULL,
    CONSTRAINT PK_Logs PRIMARY KEY(dateID, planeID, personID),
    CONSTRAINT FK_Logs_Dates FOREIGN KEY(dateID)
        REFERENCES Dates(dateID),
    CONSTRAINT FK_Logs_Planes FOREIGN KEY(planeID)
        REFERENCES Planes(planeID),
    CONSTRAINT FK_Logs_Person FOREIGN KEY(personID)
        REFERENCES Person(personID)
)
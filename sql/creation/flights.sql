CREATE TABLE Flights (
    dateID INT NOT NULL,
    planeID INT NOT NULL,
    flight_takeoff INT NOT NULL, --#takeoffs per day/plane
    flight_cancellation INT NOT NULL, --#cancellations per day/plane
    flight_duration FLOAT NOT NULL, --in hours
    flight_delay FLOAT NOT NULL, --in hours
    CONSTRAINT PK_Flights PRIMARY KEY(dateID, planeID),
    CONSTRAINT FK_Flights_Dates FOREIGN KEY(dateID)
        REFERENCES Dates(dateID)
    CONSTRAINT FK_Flights_Planes FOREIGN KEY(planeID)
        REFERENCES Planes(planeID)
)
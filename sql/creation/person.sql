CREATE TABLE Person (
    personID INT NOT NULL PRIMARY KEY,
    personnel_type VARCHAR(30) NOT NULL,
    airport VARCHAR(50) NULL
)

-- row per group of personnel of one type in an airport.
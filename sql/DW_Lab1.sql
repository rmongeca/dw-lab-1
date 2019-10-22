-- =============================================
-- Authors: Maria Gkotsopoulou, Ricard Monge Calvo
-- Create date: October 2019
-- Description: SQL queries for DW Lab 1 Multidimensional Modeling
-- =============================================

/******************************************************************************/
/******************************** CREATE TABLE ********************************/
/******************************************************************************/

-- Date dimension table
CREATE TABLE Dates (
    dateID INT NOT NULL PRIMARY KEY, -- Date number 20191014
    Day INT NOT NULL,   -- From 1~31
    Month INT NOT NULL, -- From 1~12
    Year INT NOT NULL   -- 2019
)

-- Person dimension table
CREATE TABLE Person (
    personID INT NOT NULL PRIMARY KEY,
    personnel_type VARCHAR(30) NOT NULL, -- pilot/maintenance
    airport VARCHAR(50) NULL
)

-- Planes dimension table
CREATE TABLE Planes (
    planeID INT NOT NULL PRIMARY KEY,
    Model VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(50) NULL
)

-- Scheduled dimension table
-- Junk dimension to hold schedule type
CREATE TABLE Scheduled (
    scheduledID INT NOT NULL PRIMARY KEY,
    schedule_type VARCHAR(11) NOT NULL, -- scheduled/unscheduled
)

-- Flights fact table
CREATE TABLE Flights (
    dateID INT NOT NULL,
    planeID INT NOT NULL,
    flight_takeoff INT NOT NULL, -- #takeoffs per day/plane
    flight_cancellation INT NOT NULL, -- #cancellations per day/plane
    flight_delay INT NOT NULL, -- #delays per day/plane
    flight_duration FLOAT NOT NULL, -- in hours
    flight_delay_duration FLOAT NOT NULL, -- in hours
    CONSTRAINT PK_Flights PRIMARY KEY(dateID, planeID),
    CONSTRAINT FK_Flights_Dates FOREIGN KEY(dateID)
        REFERENCES Dates(dateID),
    CONSTRAINT FK_Flights_Planes FOREIGN KEY(planeID)
        REFERENCES Planes(planeID)
)

-- Logs fact table
CREATE TABLE Logs (
    dateID INT NOT NULL,
    planeID INT NOT NULL,
    personID INT NOT NULL,
    log_count INT NOT NULL, -- #technical logbook entries
    CONSTRAINT PK_Logs PRIMARY KEY(dateID, planeID, personID),
    CONSTRAINT FK_Logs_Dates FOREIGN KEY(dateID)
        REFERENCES Dates(dateID),
    CONSTRAINT FK_Logs_Planes FOREIGN KEY(planeID)
        REFERENCES Planes(planeID),
    CONSTRAINT FK_Logs_Person FOREIGN KEY(personID)
        REFERENCES Person(personID)
)

-- Maintenance fact table
CREATE TABLE Maintenance (
    dateID INT NOT NULL,
    planeID INT NOT NULL,
    scheduledID INT NOT NULL,
    maintenance_duration FLOAT NOT NULL, -- in hours
    CONSTRAINT PK_Maintenance PRIMARY KEY(dateID, planeID, scheduledID),
    CONSTRAINT FK_Maintenance_Dates FOREIGN KEY(dateID)
        REFERENCES Dates(dateID),
    CONSTRAINT FK_Maintenance_Planes FOREIGN KEY(planeID)
        REFERENCES Planes(planeID),
    CONSTRAINT FK_Maintenance_Scheduled FOREIGN KEY(scheduledID)
        REFERENCES Scheduled(scheduledID)
)


/******************************************************************************/
/******************************** CREATE MV LOG *******************************/
/******************************************************************************/

-- Logs with ROWID as the row identifier for each change
-- Logs include both old and new value for each change
-- Needed for Oracle's FAST REFRESH ON COMMIT

CREATE MATERIALIZED VIEW LOG ON Flights WITH ROWID
	(dateID
	,planeID
	,flight_takeoff
	,flight_duration
	,flight_delay_duration) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON Logs WITH ROWID
	(dateID
	,planeID
	,personID
	,log_count) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON Maintenance WITH ROWID
	(dateID
	,planeID
	,scheduledID
	,maintenance_duration) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON Dates WITH ROWID
	(dateID
	,Day
	,Month
	,Year) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON Planes WITH ROWID
	(planeID
	,Model
	,Manufacturer) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON Person WITH ROWID
	(personID
	,personnel_type
	,airport) INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON Scheduled WITH ROWID
	(scheduledID
    ,schedule_type) INCLUDING NEW VALUES;


/******************************************************************************/
/************************** CREATE MATERIALIZED VIEW **************************/
/******************************************************************************/

-- Maintenance MV on Month-Model-Schedule
CREATE MATERIALIZED VIEW mv_maintenance_month_plane_skd
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT
    d.Month, d.Year, m.planeID, p.Model, s.schedule_type,
    SUM(m.maintenance_duration) maintenance_duration
FROM  Maintenance m, Dates d, Planes p, Scheduled s
WHERE   m.dateID = d.dateID
    AND m.scheduledID = s.scheduledID
    AND m.planeID = p.planeID
GROUP BY d.Month, d.Year, m.planeID, p.Model, s.schedule_type
ORDER BY d.Month, d.Year, m.planeID, p.Model, s.schedule_type

-- Example of KPI queries:
-- Withot including operations on the aggregates such as ADOS=maintenance_duration/24
-- (conversion to decimal days), neither projections.
-- SELECTION s.schedule_type = 'unscheduled':
-------- ADOSU per month per aircraft.
---- ROLL UP d.YEAR:
-------- ADOSU per year per aircraft.
---- ROLL UP p.Model:
-------- ADOSU per month per model.

-- Logs MV on Month-Model-Person
CREATE MATERIALIZED VIEW mv_logs_monthly_planes_person
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT
    d.Month, d.Year, pe.personnel_type, pe.airport, p.planeID, p.Model, p.Manufacturer,
    SUM(l.log_count) Log_count,
    SUM(f.flight_duration) FH,
 	SUM(f.flight_takeoff) FC
FROM Flights f, Logs l, Dates d, Person pe, Planes p
WHERE  f.planeID = l.planeID
	AND f.dateID = l.dateID
    AND f.dateID = d.dateID 
    AND f.planeID = p.planeID
    AND l.personID = pe.personID
GROUP BY d.Month, d.Year, pe.personnel_type, pe.airport, p.planeID, p.Model, p.Manufacturer
ORDER BY d.Month, d.Year, pe.personnel_type, pe.airport, p.planeID, p.Model, p.Manufacturer

-- Example of KPI queries:
-- Withot including operations on the aggregates such as RRh=(Log_count/FH)*1000
-- neither projections.
-- SELECTION pe.personnel_type = 'maintenance':
-------- MRRh, MRRc per month per aircraft.
-- SELECTION pe.personnel_type = 'pilot':
-------- PRRh, PRRc per month per aircraft.
-- ROLL UP pe.airport:
-------- MRRh, MRRc per month per airport of reporting person per aircraft.
-- ROLL UP d.Year and p.Model:
-------- MRRh, MRRc, PRRh, PRRc, MRRh, MRRc per year per model.

-- Flights MV on Month-Model
-- Debatable if benefitial or not
CREATE MATERIALIZED VIEW mv_flights_monthly_model
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT d.Month, d.Year, p.planeID, p.Model,
 	SUM(f.flight_takeoff) FC,
    SUM(f.flight_duration) FH,
    SUM(f.flight_cancellation) FCancel,
    SUM(f.flight_delay) FDelay,
SUM(f.flight_delay_duration) FDelay_duration
FROM  Flights f, Dates d
WHERE   f.dateID = d.dateID
    AND f.planeID = p.planeID
GROUP BY d.Month, d.Year, p.planeID, p.Model
ORDER BY d.Month, d.Year, p.planeID, p.Model

-- Example of KPI queries:
-- Withot including operations on the aggregates such as DYR=(FDelay/FC)*100
-- neither projections.
-------- FH, TO (FC), DYR, CNR, TDR, ADD per month per aircraft.
-- ROLL UP p.Model:
-------- FH, TO (FC), DYR, CNR, TDR, ADD per month per model.
-- ROLL UP d.Year and p.Model:
-------- FH, TO (FC), DYR, CNR, TDR, ADD per year per model.


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
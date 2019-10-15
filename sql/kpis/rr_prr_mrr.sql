-- Report Rate per hour (RRh) per month per aircraft
-- Report Rate per cycle (RRc) per month per aircraft
SELECT
    d.Month, d.Year, f.planeID,
    1000*SUM(log_count) / SUM(f.flight_duration) RRh
    100*SUM(log_count) / SUM(f.flight_takeoff) RRc
FROM Dates d, Flights f, Logs l
WHERE   d.dateID = f.dateID 
    -- assumption that all planes that have a flight
    -- have at least a logbook
    AND f.planeID = l.planeID
    AND f.dateID = l.dateID
GROUP BY d.Month, d.Year, f.planeID 
ORDER BY d.Month, d.Year, f.planeID

-- Pilot Report Rate per hour (PRRh) per month per aircraft
-- Pilot Report Rate per cycle (PRRc) per month per aircraft
SELECT
    d.Month, d.Year, f.planeID,
    1000*SUM(log_count) / SUM(f.flight_duration) PRRh
    100*SUM(log_count) / SUM(f.flight_takeoff) PRRc
FROM Dates d, Flights f, Logs l, Person pe
WHERE   d.dateID = f.dateID 
    AND f.planeID = l.planeID
    AND f.dateID = l.dateID
    AND l.personID = pe.personID
    AND pe.personnel_type = 'pilot'
GROUP BY d.Month, d.Year, f.planeID 
ORDER BY d.Month, d.Year, f.planeID

-- Maintennce Report Rate per hour (MRRh) per month per aircraft
-- Maintennce Report Rate per cycle (MRRc) per month per aircraft
SELECT
    d.Month, d.Year, f.planeID,
    1000*SUM(log_count) / SUM(f.flight_duration) MRRh
    100*SUM(log_count) / SUM(f.flight_takeoff) MRRc
FROM Dates d, Flights f, Logs l, Person pe
WHERE   d.dateID = f.dateID 
    AND f.planeID = l.planeID
    AND f.dateID = l.dateID
    AND l.personID = pe.personID
    AND pe.personnel_type = 'maintenance'
GROUP BY d.Month, d.Year, f.planeID 
ORDER BY d.Month, d.Year, f.planeID

-- Groupped PRR and MRR per month per aircraft
SELECT
    d.Month, d.Year, f.planeID, pe.personnel_type,
    1000*SUM(log_count) / SUM(f.flight_duration) RRh
    100*SUM(log_count) / SUM(f.flight_takeoff) RRc
FROM Dates d, Flights f, Logs l, Person pe
WHERE   d.dateID = f.dateID 
    AND f.dateID = l.dateID
    AND f.planeID = l.planeID
    AND l.personID = pe.personID
GROUP BY d.Month, d.Year, f.planeID, pe.personnel_type
ORDER BY d.Month, d.Year, f.planeID, pe.personnel_type

-- Maintennce Report Rate per hour (MRRh) per airport of reporting person per aircraft
-- Maintennce Report Rate per cycle (MRRc) per airport of reporting person per aircraft
SELECT
    f.planeID, pe.airport,
    1000*SUM(log_count) / SUM(f.flight_duration) MRRh
    100*SUM(log_count) / SUM(f.flight_takeoff) MRRc
FROM Dates d, Flights f, Logs l, Person pe
WHERE   d.dateID = f.dateID 
    AND f.planeID = l.planeID
    AND f.dateID = l.dateID
    AND l.personID = pe.personID
    AND pe.personnel_type = 'maintenance'
GROUP BY d.Month, d.Year, f.planeID 
ORDER BY d.Month, d.Year, f.planeID

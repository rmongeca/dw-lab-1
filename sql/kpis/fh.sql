-- Flight Hours per day per aircraft
SELECT f.dateID, f.planeID, SUM(f.flight_duration) FH
FROM Flights f
GROUP BY f.dateID, f.planeID
ORDER BY f.dateID, f.planeID

-- Flight Hours per month per model
SELECT d.Month, p.Model, SUM(f.flight_duration) FH
FROM Flights f, Dates d, Planes p
WHERE   f.dateID = d.dateID
    AND f.planeID = p.planeID
GROUP BY d.Month, p.Model
ORDER BY d.Month, p.Model

-- Flight Hours per Year per model
SELECT d.Year, p.Model, SUM(f.flight_duration) FH
FROM Flights f, Dates d, Planes p
WHERE   f.dateID = d.dateID
    AND f.planeID = p.planeID
GROUP BY d.Year, p.Model
ORDER BY d.Year, p.Model
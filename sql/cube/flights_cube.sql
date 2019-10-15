SELECT
    d.dateID, p.planeID,
    SUM(f.flight_takeoff), SUM(f.flight_cancellation),
    SUM(f.flight_duration), SUM(f.flight_delay)
FROM Dates d, Planes p, Flights f
WHERE   f.dateID = d.dateID 
    AND f.planeID = p.planeID
GROUP BY d.dateID, p.planeID
ORDER BY d.dateID, p.planeID

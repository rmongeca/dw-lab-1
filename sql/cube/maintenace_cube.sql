SELECT
    d.dateID, p.planeID, s.scheduledID,
    SUM(m.maintenance_duration)
FROM Dates d, Planes p, Scheduled s, Maintenance m
WHERE   m.dateID = d.dateID 
    AND m.planeID = p.planeID
    AND m.scheduledID = s.scheduledID
GROUP BY d.dateID, p.planeID, s.scheduledID
ORDER BY d.dateID, p.planeID, s.scheduledID
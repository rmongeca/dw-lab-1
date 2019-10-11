SELECT
    d.dateID, p.planeID, pe.personID, SUM(log_count)
FROM Dates d, Planes p, Person pe, Logs l
WHERE   l.dateID = d.dateID 
    AND l.planeID = p.planeID
    AND l.personID = pe.personID
GROUP BY d.dateID, p.planeID, pe.personID
ORDER BY d.dateID, p.planeID, pe.personID
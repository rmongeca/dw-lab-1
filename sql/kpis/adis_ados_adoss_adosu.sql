-- Aircraf Days In-Service (ADIS) per month per aircraft
-- Aircraf Days Out-of-Service (ADOS) per month per aircraft
SELECT
    d.Month, m.planeID,
    -- duration in hours, divided by 24 to get days
    (SELECT COUNT(dateID) FROM Dates WHERE Month = d.Month GROUP BY Month) -
        SUM(m.maintenance_duration)/24 ADIS,
    SUM(m.maintenance_duration)/24 ADOS
FROM Dates d, Maintenance m
WHERE m.dateID = d.dateID
GROUP BY d.Month, d.Year, m.planeID
ORDER BY d.Month, d.Year, m.planeID

-- Aircraf Days Out-of-Service Scheduled (ADOSS) per month per aircraft
SELECT
    d.Month, m.planeID,
    SUM(m.maintenance_duration)/24 ADOSS
FROM Dates d, Scheduled s, Maintenance m
WHERE   m.dateID = d.dateID
    AND m.scheduledID = s.scheduledID
    AND m.schedule_type = 'scheduled'
GROUP BY d.Month, d.Year, m.planeID
ORDER BY d.Month, d.Year, m.planeID

-- Aircraft Days Out-of-Service Unscheduled (ADOSU) per month per aircraft
SELECT
    d.Month, m.planeID,
    SUM(m.maintenance_duration)/24 ADOSU
FROM Dates d, Scheduled s, Maintenance m
WHERE   m.dateID = d.dateID
    AND m.scheduledID = s.scheduledID
    AND m.schedule_type = 'unscheduled'
GROUP BY d.Month, d.Year, m.planeID
ORDER BY d.Month, d.Year, m.planeID


-- All KPIs togehter per month per aircraft
SELECT
    d.Month, m.planeID,
    -- duration in hours, divided by 24 to get days
    (SELECT COUNT(dateID) FROM Dates WHERE Month = d.Month GROUP BY Month) -
        SUM(m.maintenance_duration)/24 ADIS,
    SUM(m.maintenance_duration)/24 ADOS,
    SUM((CASE WHEN s.schedule_type = 'scheduled' THEN 1 ELSE 0)*
        m.maintenance_duration)/24 ADOSS,
    SUM((CASE WHEN s.schedule_type = 'unscheduled' THEN 1 ELSE 0)*
        m.maintenance_duration)/24 ADOSU
FROM Dates d, Scheduled s, Maintenance m
WHERE   m.dateID = d.dateID
    AND m.scheduledID = s.scheduledID
GROUP BY d.Month, d.Year, m.planeID
ORDER BY d.Month, d.Year, m.planeID
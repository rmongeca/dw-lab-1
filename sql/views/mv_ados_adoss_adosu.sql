
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

--- i. on this m view we can apply a selection --> schedule_type = 'unscheduled' 
--- to get ADOSU by aircraft-month
SELECT Month, Year, planeID, maintenance_duration AS ADOSU
FROM mv_maintenance_monthly_aircraft_schedule
WHERE schedule_type = 'unscheduled' ;
--- to get ADOSU by aircraft-year
SELECT Year, planeID, SUM(maintenance_duration) AS ADOSU
FROM mv_maintenance_monthly_aircraft_schedule
WHERE schedule_type = 'unscheduled'
GROUP by Year, planeID;
--- to get ADOSU by model-year
SELECT Year, Model, SUM(maintenance_duration) AS ADOSU
FROM mv_maintenance_monthly_aircraft_schedule
WHERE schedule_type = 'unscheduled'
GROUP by Year, Model;
--- to get ADOSU by model-month
SELECT Month,Year, Model, SUM(maintenance_duration) AS ADOSU
FROM mv_maintenance_monthly_aircraft_schedule
WHERE schedule_type = 'unscheduled'
GROUP by Month, Year, Model;


--- ii. on this m view we can apply a selection --> schedule_type = 'scheduled' 
--- to get ADOSS by aircraft-month
SELECT Month, Year, planeID, maintenance_duration AS ADOSS
FROM mv_maintenance_monthly_aircraft_schedule
WHERE schedule_type = 'scheduled'


--- iii.on this m view we can apply a rollup --> schedule_type  
--- to get ADOS by aircraft-month
SELECT Month, Year,planeID, SUM(maintenance_duration) AS ADOS
FROM mv_maintenance_monthly_aircraft_schedule
GROUP BY Month, Year, planeID




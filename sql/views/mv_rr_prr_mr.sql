
CREATE MATERIALIZED VIEW mv_logs_monthly_planes_person
REFRESH FAST ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT
    d.Month, d.Year, pe.personnel_type,pe.airport,p.planeID, p.Model,
    SUM(l.log_count) Log_count,
    SUM(f.flight_duration) FT,
 	SUM(f.flight_takeoff) FC
FROM Flights f, Logs l, Dates d, Person pe, Planes p
WHERE  f.planeID = l.planeID
	AND f.dateID = l.dateID
    AND f.dateID = d.dateID 
    AND f.planeID = p.planeID
    AND l.personID = pe.personID
GROUP BY d.Month, d.Year, pe.personnel_type,pe.airport,p.planeID, p.Model
ORDER BY d.Month, d.Year, pe.personnel_type,pe.airport,p.planeID, p.Model


-- SELECTION pe.personnel_type = 'maintenance'
-------- Maintennce Report Rate per hour (MRRh) per month per aircraft 
-------- Maintennce Report Rate per cycle (MRRc) per month per aircraft
-- SELECTION pe.personnel_type = 'pilot'
-------- Pilot Report Rate per hour (PRRh) per month per aircraft
 --------Pilot Report Rate per cycle (PRRc) per month per aircraft
-- ROLL UP airport
-------- Maintennce Report Rate per hour (MRRh) per airport of reporting person per aircraft
-------- Maintennce Report Rate per cycle (MRRc) per airport of reporting person per aircraft
-- ROLL UP model 
-------- MRRh, MRRc, PRRh,PRRc,MRRh,MRRc
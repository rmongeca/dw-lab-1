-- Cancellation Rate (CNR) per month per aircraft
-- Delay Rate (DYR) per month per aircraft
-- Technical Dispatch Reliability (TDR) per month per aircraft
-- Average Delay Duration (ADD) per month per airctaft
SELECT d.Month, d.Year, f.planeID,
    100*SUM(f.flight_cancellation) / SUM(f.flight_takeoff) CNR,
    100*SUM(f.flight_delay) / SUM(f.flight_takeoff) DYR,
    100 - (100*(SUM(f.flight_delay) + SUM(f.flight_cancellation)) 
        / SUM(f.flight_takeoff)) TDR,
    100*SUM(f.flight_delay_duration) / SUM(f.flight_delay) ADD
FROM Dates d, Flights f
WHERE f.dateID = d.dateID
GROUP BY d.Month, d.Year, f.planeID
ORDER BY d.Month, d.Year, f.planeID

-- Cancellation Rate (CNR) per year per model
-- Delay Rate (DYR) per year per model
-- Technical Dispatch Reliability (TDR) per year per model
-- Average Delay Duration (ADD) per year per model
SELECT d.Year, p.Model,
    100*SUM(f.flight_cancellation) / SUM(f.flight_takeoff) CNR,
    100*SUM(f.flight_delay) / SUM(f.flight_takeoff) DYR,
    100 - (100*(SUM(f.flight_delay) + SUM(f.flight_cancellation)) 
        / SUM(f.flight_takeoff)) TDR,
    100*SUM(f.flight_delay_duration) / SUM(f.flight_delay) ADD
FROM Dates d, Flights f, Planes p
WHERE   f.dateID = d.dateID
    AND f.planeID = p.planeID
GROUP BY d.Year, p.Model
ORDER BY d.Year, p.Model



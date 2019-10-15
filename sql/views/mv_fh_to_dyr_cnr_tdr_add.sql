

CREATE MATERIALIZED VIEW mv_flight_monthly_model AS
SELECT d.Month,d.Year, p.Model,
 	SUM(f.flight_takeoff) TO,
    SUM(f.flight_duration) FH,
    100*SUM(f.flight_cancellation) / SUM(f.flight_takeoff) CNR,
    100*SUM(f.flight_delay) / SUM(f.flight_takeoff) DYR,
    100 - (100*(SUM(f.flight_delay) + SUM(f.flight_cancellation)) 
        / SUM(f.flight_takeoff)) TDR,
    100*SUM(f.flight_delay_duration) / SUM(f.flight_delay) ADD
FROM  Flights f, Dates d,Planes p
WHERE   f.dateID = d.dateID
    AND f.planeID = p.planeID
GROUP BY d.Month,d.Year, p.Model
ORDER BY d.Month,d.Year, p.Model;

-- From this materialized view we can get
-- i.Flight Hours per month per model
-- ii. Flight Cycles per month per model
-- iii.Flight Hours per Year per model
-- iv. Flight Cycles per Year per model
-- v. Cancellation Rate (CNR) per year per model
-- vi. Delay Rate (DYR) per year per model
-- vii.Technical Dispatch Reliability (TDR) per year per model
-- viii. Average Delay Duration (ADD) per year per model

-- From this materialized view we can NOT get
-- Flight Hours per day per aircraft
------but this is retrieved directly from the flights table 
-- Flight Cycles per day per aircraft
------but this is retrieved directly from the flights table 
-- Cancellation Rate (CNR) per month per aircraft
-- Delay Rate (DYR) per month per aircraft
-- Technical Dispatch Reliability (TDR) per month per aircraft
-- Average Delay Duration (ADD) per month per airctaft


-- If we were to add aircraft (planeID) in the above query (constructing the materialized view)  
-- then more queries (the above mentioned ones) will benefit from this view. 
-- In addition, the cost of the incremental update of this the latter view would possibly be smaller. 
-- On the contrary, the aggregated model materialized view benefits less queries
-- but the potential gain could be larger. 

CREATE TABLE Scheduled (
    scheduledID INT NOT NULL PRIMARY KEY,
    schedule_type VARCHAR(11) NOT NULL, -- scheduled/unscheduled
)

-- Junk Dimension with only two values 1 scheduled and 0 not-scheduled
--Create trip_fact table
BEGIN 
    DROP TABLE trip_fact
END
GO;



--Create trip_fact table
CREATE TABLE trip_fact (
    [trip_id] VARCHAR(50) NOT NULL,
    [rider_id] INTEGER,
    [start_station_id] VARCHAR(50), 
    [end_station_id] VARCHAR(50), 
    [start_time_id] VARCHAR(50), 
    [end_time_id] VARCHAR(50), 
    [rideable_type] VARCHAR(75),
    [duration] VARCHAR(75),
    [rider_age] VARCHAR(75)
);

ALTER TABLE trip_fact add CONSTRAINT PK_trip_fact_trip_id PRIMARY KEY NONCLUSTERED (trip_id) NOT ENFORCED


INSERT INTO trip_fact (
    [trip_id],
    [rider_id],
    [start_station_id], 
    [end_station_id], 
    [start_time_id], 
    [end_time_id], 
    [rideable_type],
    [duration],
    [rider_age])
SELECT 
    staging_trip.trip_id,
    staging_rider.rider_id,
    staging_trip.start_station_id, 
    staging_trip.end_station_id, 
    start_time.time_id                                                  AS start_time_id,
    end_time.time_id                                                    AS end_time_id,
    staging_trip.rideable_type,
    DATEDIFF(hour, staging_trip.start_at, staging_trip.ended_at)      AS duration,
    DATEDIFF(year, staging_rider.birthday, staging_trip.start_at)     AS rider_age

FROM staging_trip
JOIN staging_rider             ON staging_rider.rider_id = staging_trip.rider_id
JOIN time_dim AS start_time     ON start_time.date = staging_trip.start_at
JOIN time_dim AS end_time       ON DATEDIFF(dd, 0, end_time.date) = DATEDIFF(dd, 0, staging_trip.ended_at)

--Create station_dim table
BEGIN 
    DROP TABLE station_dim
END
GO;

CREATE TABLE station_dim (
	[station_id] [nvarchar](4000)  NULL,
	[name] [nvarchar](4000)  NULL,
	[latitude] [float]  NULL,
	[longitude] [float]  NULL
)
GO;

INSERT INTO station_dim ([station_id],[name],[latitude],[longitude])
    SELECT [station_id],[name],[latitude],[longitude]
    FROM staging_station

GO;

SELECT TOP (100) * FROM [dbo].[station_dim]

--Create payment_fact table
BEGIN 
    DROP TABLE payment_fact
END
GO;

CREATE TABLE payment_fact (
	[payment_id] [bigint]  NULL,
	[amount] [float]  NULL,
	[rider_id] [bigint]  NULL,
	[time_id] [uniqueidentifier]  NULL
)
GO;

INSERT INTO payment_fact (
	[payment_id],
	[amount],
	[rider_id] ,
	[time_id])
SELECT
    [payment_id],
    [staging_payment].[amount],
    [staging_payment].[rider_id],
    [time_dim].[time_id]
FROM [dbo].[staging_payment]
JOIN time_dim ON time_dim.date = staging_payment.date

GO;

SELECT TOP (100) * FROM [dbo].[payment_fact]

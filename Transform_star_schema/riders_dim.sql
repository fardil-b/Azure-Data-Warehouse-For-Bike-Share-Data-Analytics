-- Create Rider table
BEGIN 
    DROP TABLE riders_dim
END
GO;

CREATE TABLE riders_dim (
	[rider_id] [bigint]  NULL,
	[firstName] [nvarchar](4000)  NULL,
	[lastName] [nvarchar](4000)  NULL,
	[address] [nvarchar](4000)  NULL,
	[birthday] [varchar](50)  NULL,
	[account_start_date] [varchar](50)  NULL,
	[account_end_date] [varchar](50)  NULL,
	[is_Member] [bit]  NULL
)
GO;

INSERT INTO riders_dim (
    [rider_id]
    ,[firstName]
    ,[lastName]
    ,[address]
    ,[birthday]
    ,[account_start_date]
    ,[account_end_date]
    ,[is_Member])
SELECT 
    [rider_id]
    ,[firstName]
    ,[lastName]
    ,[address]
    ,[birthday]
    ,[account_start_date]
    ,[account_end_date]
    ,[is_Member]
FROM staging_rider

GO;

SELECT TOP (100) * FROM [dbo].[riders_dim]

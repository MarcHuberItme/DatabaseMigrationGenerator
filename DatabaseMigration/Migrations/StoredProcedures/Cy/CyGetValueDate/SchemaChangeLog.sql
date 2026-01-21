--liquibase formatted sql

--changeset system:create-alter-procedure-CyGetValueDate context:any labels:c-any,o-stored-procedure,ot-schema,on-CyGetValueDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyGetValueDate
CREATE OR ALTER PROCEDURE dbo.CyGetValueDate
AS

--select getdate()

Declare @intWeekDay as smallint
Declare @intWorkDay as smallint 
Declare @NextValueDate as datetime

	--Set date + 2 days
	SET LANGUAGE German;
	Set @NextValueDate =  dateadd(d, +2, Convert(datetime, Convert(nvarchar(30), Getdate(), 104), 104))
	Set @intWeekDay = DATEPART(dw, @NextValueDate) 
	Set @intWorkDay = (Select Count(Date) From  asCalException Where UsageType = 20 and Date = Convert(datetime, Convert(nvarchar(30), @NextValueDate,104),104))

	While (@intWeekDay > 5 OR @intWorkDay <> 0 )
	BEGIN
		--is Weekend or no working day
		Set @NextValueDate =  dateadd(d, +1, @NextValueDate)
		Set @intWeekDay = DATEPART(dw, @NextValueDate) 
		Set @intWorkDay = (Select Count(Date) From  asCalException Where UsageType = 20 AND Date = Convert(datetime, Convert(nvarchar(30), @NextValueDate, 104), 104))
	END

Select @NextValueDate






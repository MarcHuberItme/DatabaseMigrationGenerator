--liquibase formatted sql

--changeset system:create-alter-procedure-GetForexValInterestRates context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForexValInterestRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForexValInterestRates
CREATE OR ALTER PROCEDURE dbo.GetForexValInterestRates
@ReportDate AS Datetime

AS

SELECT TOP 1 WITH Ties 
CASE WHEN DurationType = 'y' THEN DateAdd(d, 365 * duration, @ReportDate)
 WHEN DurationType = 'm' THEN
	case when duration = 1 THEN DateAdd(d, 30, @ReportDate)
	 when duration = 2 THEN DateAdd(d, 61, @ReportDate)
	 when duration = 3 THEN DateAdd(d, 92, @ReportDate)
	 when duration = 4 THEN DateAdd(d, 122, @ReportDate)
	 when duration = 5 THEN DateAdd(d, 152, @ReportDate)
	 when duration = 6 THEN DateAdd(d, 183, @ReportDate)
	 when duration = 7 THEN DateAdd(d, 213, @ReportDate)
	 when duration = 8 THEN DateAdd(d, 243, @ReportDate)
	 when duration = 9 THEN DateAdd(d, 274, @ReportDate)
	 when duration = 10 THEN DateAdd(d, 304, @ReportDate)
	 when duration = 11 THEN DateAdd(d, 334, @ReportDate)
	 when duration = 12 THEN DateAdd(d, 365, @ReportDate)
	end
 WHEN DurationType = 'd' THEN DateAdd(d,duration, @ReportDate)
ELSE NULL END AS CalcDate, duration, durationtype, Currency, InterestRate, ReportDate FROM AcDerivativeInterestRate
WHERE ReportDate <= @ReportDate AND ConfirmationUser IS NOT NULL AND ConfirmationDate IS NOT NULL
ORDER BY ReportDate DESC

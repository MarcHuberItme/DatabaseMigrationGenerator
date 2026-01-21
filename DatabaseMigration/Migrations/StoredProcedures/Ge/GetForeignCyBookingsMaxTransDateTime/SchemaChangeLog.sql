--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyBookingsMaxTransDateTime context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyBookingsMaxTransDateTime,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyBookingsMaxTransDateTime
CREATE OR ALTER PROCEDURE dbo.GetForeignCyBookingsMaxTransDateTime

AS

DECLARE @EndDate datetime
DECLARE @MaxTransDateTime datetime

Select @EndDate =EndDate from AsProcTimeControl Where TypeNo = 1 and HdVersionNo between 1 and 999999998

SELECT @MaxTransDateTime = Max(PtTransItem.TransDateTime)
FROM PtTransItem (NOLOCK)
WHERE HdVersionNo between 1 and 999999998 AND TransDate >= @EndDate
AND PositionId IN (
SELECT Pos.Id FROM PtPosition AS Pos (NOLOCK)
INNER JOIN PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id AND Ref.ProductId IN
(SELECT ProductId FROM PrPrivateCobaProductNo
UNION ALL
SELECT ProductId FROM PrPrivateCustProductNo )
INNER JOIN CyBase AS Cy (NOLOCK) ON Ref.Currency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN PtAccountBase (NOLOCK) AS Acc ON Acc.Id = Ref.AccountId
)

SELECT @EndDate AS TransDate, @MaxTransDateTime AS MaxTransDateTime, DATEPART(ms, @MaxTransDateTime) AS MS


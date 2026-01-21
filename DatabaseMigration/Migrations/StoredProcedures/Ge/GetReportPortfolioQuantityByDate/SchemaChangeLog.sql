--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportPortfolioQuantityByDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportPortfolioQuantityByDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportPortfolioQuantityByDate
CREATE OR ALTER PROCEDURE dbo.GetReportPortfolioQuantityByDate
@PositionId UniqueIdentifier,
@ByDate datetime

AS

SELECT	 POS.Id, POS.Quantity + ISNULL(SUM(PTI.DebitQuantity),0) - ISNULL(SUM(PTI.CreditQuantity), 0) AS QuantityByDate
FROM	 PtPosition POS
         LEFT OUTER JOIN PtTransItem PTI ON PTI.PositionId = POS.Id  
         AND (PTI.TransDate > @ByDate  AND PTI.RealDate > @ByDate)
         AND  PTI.DetailCounter > 0
         AND  PTI.HdVersionNo between 1 and 999999998

WHERE 	 POS.Id = @PositionId
GROUP BY POS.Id, POS.Quantity

--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingStockExCountForOverview context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingStockExCountForOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingStockExCountForOverview
CREATE OR ALTER PROCEDURE dbo.GetPendingStockExCountForOverview
@PartnerId uniqueidentifier

AS

select COUNT(M.OrderQuantity) AS RecCounter
FROM PtTradingOrderMessage M
JOIN PtTradingOrder T on T.Id = M.TradingOrderId
INNER JOIN PtPortfolio SO ON SO.Id = M.SecurityPortfolioId 
WHERE SO.PartnerId = @PartnerId
And T.TransTypeNo Between 600 And 699 
And T.ValidTo>GetDate()
And T.CancelledStatus=0 
And T.ExpiredStatus = 0
And M.IsStockExOrder=0
And NOT EXISTS (SELECT * FROM PtTransaction AS PTA 
                WHERE PTA.TransNo = T.TransNo AND ISNULL(PTA.ProcessStatus,0) <> 0 
                AND PTA.HdVersionNo between 1 and 999999998)


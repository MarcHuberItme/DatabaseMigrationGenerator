--liquibase formatted sql

--changeset system:create-alter-procedure-GetInstantPaymentDailySumOwnBank context:any labels:c-any,o-stored-procedure,ot-schema,on-GetInstantPaymentDailySumOwnBank,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetInstantPaymentDailySumOwnBank
CREATE OR ALTER PROCEDURE dbo.GetInstantPaymentDailySumOwnBank
@GivenAccount uniqueidentifier,
@GivenDate date

AS

DECLARE @SysParamEbInstantOrderType tinyint = (SELECT AsParameter.Value FROM AsParameter WHERE AsParameter.Name = 'OrderTypeEBInstant');

SELECT SUM(PtPaymentOrderDetail.PaymentAmount) AS dailyInstantAmountSum--, PtPaymentOrder.SenderAccountNo, PtTransaction.TransDate, DP.PartnerId, CP.PartnerId, PtPaymentOrderDetail.AccountNo
    FROM PtPaymentOrder
    INNER JOIN PtPaymentOrderType ON PtPaymentorder.OrderType = PtPaymentOrderType.OrderTypeNo
    INNER JOIN PtPaymentOrderDetail ON PtPaymentOrder.Id = PtPaymentOrderDetail.OrderId
    INNER JOIN PtTransaction ON PtPaymentOrderDetail.TransNo = PtTransaction.TransNo
    INNER JOIN PtAccountBase DA ON PtPaymentOrder.SenderAccountNo = DA.AccountNo
    INNER JOIN PtPortfolio DP ON DA.PortfolioId = DP.Id
    LEFT OUTER JOIN PtAccountBase CA ON PtPaymentOrderDetail.AccountNo = CA.AccountNo
    LEFT OUTER JOIN PtPortfolio CP ON CA.PortfolioId = CP.Id
WHERE 
DA.Id = @GivenAccount
AND PtPaymentOrderType.IsInstantExecution = 1 -- catch all Instant executions
AND Status = 4 
AND PtTransaction.TransDate = @GivenDate
AND PtPaymentOrder.OrderType = @SysParamEbInstantOrderType
AND PtPaymentOrderDetail.SlipType <>6 AND PtPaymentOrderDetail.AccountNo IS NOT NULL -- this row is for OwnBank
GROUP BY PtPaymentOrder.SenderAccountNo, PtTransaction.TransDate, DP.PartnerId, CP.PartnerId, PtPaymentOrderDetail.AccountNo

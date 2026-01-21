--liquibase formatted sql

--changeset system:create-alter-procedure-GetForeignCyOrdersByValueDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetForeignCyOrdersByValueDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetForeignCyOrdersByValueDate
CREATE OR ALTER PROCEDURE dbo.GetForeignCyOrdersByValueDate

@PValueDateFrom AS Datetime,
@PValueDateTo    AS Datetime,
@PCurrentTransDate AS Datetime
WITH RECOMPILE
AS 

DECLARE @ValueDateFrom AS Datetime = @PValueDateFrom;
DECLARE @ValueDateTo   AS Datetime = @PValueDateTo;
DECLARE @CurrentTransDate AS Datetime = @PCurrentTransDate;

DECLARE @AccountNoESIC AS decimal(11)
DECLARE @AccountNoPcEUR AS decimal(11)
DECLARE @ESICProdId AS uniqueidentifier
DECLARE @PcEURProdId as uniqueidentifier
DECLARE @Euro as char(3) = 'EUR'

SELECT @AccountNoESIC = AccountNo, @ESICProdId = Ref.ProductId
FROM PtAccountBase AS Acc
INNER JOIN AsParameterView AS Par ON Par.Value = Acc.AccountNo AND Par.GroupName = 'AccountNoAssignment' AND Par.ParameterName = 'ClearingEUR'
INNER JOIN PrReference as Ref ON Acc.Id = Ref.AccountId AND Ref.Currency = @Euro

SELECT @AccountNoPcEUR = AccountNo, @PcEURProdId = Ref.ProductId
FROM PtAccountBase AS Acc
INNER JOIN AsParameterView AS Par ON Par.Value = Acc.AccountNo AND Par.GroupName = 'AccountNoAssignment' AND Par.ParameterName = 'PostFinanceEUR'
INNER JOIN PrReference as Ref ON Acc.Id = Ref.AccountId AND Ref.Currency = @Euro

SELECT 
Ret.OrderNo, Ret.AccountNo, Ret.DebitAmount, Ret.CreditAmount, Ret.PaymentCurrency, Ret.ValueDate, Ret.TransTypeNo,
Ret.ConversionRate, Ret.Status, Ret.AccountCurrency, Pr.ProductNo, Pr.IsCoba, Ret.SourcePrId, Ret.ProductId, Ret.SourceAccountCurrency,
IsNostroBooking =
CASE
WHEN Ret.SourceAccountCurrency IS NULL THEN 1
WHEN Ret.SourceAccountCurrency <> Ret.AccountCurrency THEN 1
WHEN SourcePr.ProductId IS NULL THEN 1
ELSE 0
END
FROM (
SELECT 
Po.OrderNo, 
AccountNo =
CASE 
WHEN OrderRule.IsOrder = 1 THEN Po.SenderAccountNo
WHEN Pod.PaymentCurrency = @Euro AND Pod.BcNrBenBank > 0 THEN @AccountNoESIC
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoPost) > 3 THEN @AccountNoPcEUR
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.ESRParticipantNo) > 3 THEN @AccountNoPcEUR
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoExt) > 3 AND Pod.AccountNo IS NULL THEN @AccountNoESIC
ELSE ISNULL(Pod.AccountNo,99999999999)
END, 
DebitAmount =
CASE WHEN OrderRule.IsOrder = PoT.IsDebit THEN PaymentAmount
ELSE 0
END,
CreditAmount =
CASE WHEN OrderRule.IsOrder <> PoT.IsDebit THEN PaymentAmount
ELSE 0
END,
PoD.PaymentCurrency, 
ValueDate =
CASE
WHEN OrderRule.IsOrder = 1 THEN ISNULL(Po.ValueDate,@CurrentTransDate)
ELSE ISNULL(Po.ValueDate,@CurrentTransDate)
END,
PoT.TransTypeNo,
Pod.ConversionRate, 
Po.Status, 
AccountCurrency =
CASE 
WHEN OrderRule.IsOrder = 1 THEN Ref.Currency
WHEN Pod.PaymentCurrency = @Euro AND Pod.BcNrBenBank > 0 THEN @Euro
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoPost) > 3 THEN @Euro
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.ESRParticipantNo) > 3 THEN @Euro
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoExt) > 3 AND Pod.AccountNo IS NULL THEN @Euro
ELSE ISNULL(RefD.Currency,Pod.PaymentCurrency)
END,
ProductId =
CASE 
WHEN IsOrder = 1 THEN Ref.ProductId
WHEN Pod.PaymentCurrency = @Euro AND Pod.BcNrBenBank > 0 THEN @ESICProdId
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoPost) > 3 THEN @PcEURProdId
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.ESRParticipantNo) > 3 THEN @PcEURProdId
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoExt) > 3 AND Pod.AccountNo IS NULL THEN @ESICProdId
ELSE RefD.ProductId
END,
SourcePrId =
CASE 
WHEN IsOrder = 0 THEN Ref.ProductId
WHEN Pod.PaymentCurrency = @Euro AND Pod.BcNrBenBank > 0 THEN @ESICProdId
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoPost) > 3 THEN @PcEURProdId
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.ESRParticipantNo) > 3 THEN @PcEURProdId
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoExt) > 3 AND Pod.AccountNo IS NULL THEN @ESICProdId
ELSE RefD.ProductId
END,
SourceAccountCurrency =
CASE 
WHEN OrderRule.IsOrder = 0 THEN Ref.Currency
WHEN Pod.PaymentCurrency = @Euro AND Pod.BcNrBenBank > 0 THEN @Euro
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoPost) > 3 THEN @Euro
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.ESRParticipantNo) > 3 THEN @Euro
WHEN Pod.PaymentCurrency = @Euro AND LEN(Pod.AccountNoExt) > 3 AND Pod.AccountNo IS NULL THEN @Euro
ELSE ISNULL(RefD.Currency,Pod.PaymentCurrency)
END
FROM PtPaymentOrder AS Po 
INNER JOIN PtPaymentOrderDetail AS PoD ON PoD.OrderId = Po.Id 
INNER JOIN PtPaymentOrderType AS PoT ON Po.OrderType = PoT.OrderTypeNo
INNER JOIN PtAccountBase AS Acc ON Po.SenderAccountNo = Acc.AccountNo
INNER JOIN PrReference   AS Ref ON Ref.AccountId = Acc.Id
LEFT OUTER JOIN PtAccountBase AS AccD ON PoD.AccountNo = AccD.AccountNo
LEFT OUTER JOIN PrReference   AS RefD ON AccD.Id = RefD.AccountId
LEFT OUTER JOIN (SELECT 1 AS IsOrder
	             UNION ALL
	             SELECT 0 AS IsOrder) AS OrderRule ON OrderRule.IsOrder >= 0
WHERE Po.Status IN (1,2,3,10)  
AND Po.HdVersionNo BETWEEN 1 AND 999999998
AND Po.ScheduledDate BETWEEN @ValueDateFrom AND @ValueDateTo
AND Pod.ScheduledDate >= @ValueDateFrom
AND Pod.HdVersionNo BETWEEN 1 AND 999999998
AND Pod.TransNo IS NULL
AND Pod.PaymentAmount IS NOT NULL
) AS Ret
INNER JOIN CyBase AS Cy ON Ret.AccountCurrency = Cy.Symbol AND Cy.CategoryNo = 1
INNER JOIN (SELECT ProductId, ProductNo, 1 AS IsCoba 
			FROM PrPrivateCobaProductNo
			
			UNION ALL 
			
			SELECT ProductId, ProductNo, 0 AS IsCoba 
			FROM PrPrivateCustProductNo
			) AS Pr ON Ret.ProductId = Pr.ProductId
LEFT OUTER JOIN (SELECT ProductId, ProductNo, 1 AS IsCoba 
			     FROM PrPrivateCobaProductNo
			
		         UNION ALL 
			
				 SELECT ProductId, ProductNo, 0 AS IsCoba 
				 FROM PrPrivateCustProductNo
				 ) AS SourcePr ON Ret.SourcePrId = SourcePr.ProductId

WHERE Ret.AccountCurrency <> 'CHF'
ORDER BY ValueDate, OrderNo ASC

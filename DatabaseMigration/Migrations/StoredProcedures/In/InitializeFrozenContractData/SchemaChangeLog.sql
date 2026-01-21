--liquibase formatted sql

--changeset system:create-alter-procedure-InitializeFrozenContractData context:any labels:c-any,o-stored-procedure,ot-schema,on-InitializeFrozenContractData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InitializeFrozenContractData
CREATE OR ALTER PROCEDURE dbo.InitializeFrozenContractData
@ReportDate AS datetime,
@Creator as varchar(20)

AS

DELETE FROM AcFrozenDerivative WHERE ReportDate = @ReportDate

INSERT INTO AcFrozenDerivative (Id, HdVersionNo, HdCreator, ReportDate, SourceRecordId, SourceTableName, 
PartnerId, ContractKey, DateTo, ContractCurrency, ContractAmount, OpponentCurrency, OpponentAmount, PendingValuationFlag, DerivativeTypeNo, IsTradingBook, DateFrom, WithCloseOutNetting)

SELECT 
Newid(), 
1,
@Creator, 
@ReportDate AS ReportDate, 
CP.Id AS SourceRecordId, 
'PtContractPartner' AS SourceTableName, 
Pt.Id AS PartnerId,
CAST(C.ContractNo AS VARCHAR(15)) AS ContractKey,
DateTo, 
FxSellCurrency AS ContractCurrency,
ContributionAmount / ConversionRate AS ContractAmount,
C.FxBuyCurrency AS OpponentCurrency,
ContributionAmount AS OpponentAmount,
1 AS PendingValuationFlag,
20 AS DerivativeTypeNo,
1 AS IsTradingBook, C.DateFrom, 0 AS WithCloseOutNetting
FROM PtContract AS C
INNER JOIN PtContractPartner AS CP ON C.Id = CP.ContractId
INNER JOIN PtPortfolio AS Pf ON CP.PortfolioId = Pf.Id
INNER JOIN PtBase as Pt ON Pf.PartnerId = Pt.Id
INNER JOIN PtAccountBase AS Ac ON CP.FxDebitAccountNo = Ac.AccountNo
INNER JOIN PrReference AS Ref ON Ac.Id = Ref.AccountId
INNER JOIN PrPrivate aS Pr ON Ref.ProductId = Pr.ProductId
WHERE ContractType = 51
AND DateTo > @ReportDate AND DateFrom < DATEADD(day,1,@ReportDate) 
AND CP.HdVersionNo BETWEEN 1 AND 999999998 AND C.HdVersionNo BETWEEN 1 AND 999999998

AND (  
		(Status BETWEEN 3 AND 4)
	 OR 
		(Status BETWEEN 97 AND 98)
	)
AND Pr.ProductNo <> 1051
AND IsFxBuyer = 0


UNION ALL

SELECT 
Newid(), 
1,
@Creator, 
@ReportDate AS ReportDate, 
CP.Id AS SourceRecordId, 
'PtContractPartner' AS SourceTableName, 
Pt.Id AS PartnerId,
CAST(C.ContractNo AS VARCHAR(15)) AS ContractKey,
DateTo, 
C.FxBuyCurrency AS ContractCurrency,
ContributionAmount AS ContractAmount,
FxSellCurrency AS OpponentCurrency,
ContributionAmount / ConversionRate AS OpponentAmount,
1 AS PendingValuationFlag,
20 AS DerivativeTypeNo,
1 AS IsTradingBook, C.DateFrom, 0 AS WithCloseOutNetting
FROM PtContract AS C
INNER JOIN PtContractPartner AS CP ON C.Id = CP.ContractId
INNER JOIN PtPortfolio AS Pf ON CP.PortfolioId = Pf.Id
INNER JOIN PtBase as Pt ON Pf.PartnerId = Pt.Id
INNER JOIN PtAccountBase AS Ac ON CP.FxDebitAccountNo = Ac.AccountNo
INNER JOIN PrReference AS Ref ON Ac.Id = Ref.AccountId
INNER JOIN PrPrivate aS Pr ON Ref.ProductId = Pr.ProductId
WHERE ContractType = 51
AND DateTo > @ReportDate AND DateFrom < DATEADD(day,1,@ReportDate) 
AND CP.HdVersionNo BETWEEN 1 AND 999999998 AND C.HdVersionNo BETWEEN 1 AND 999999998
AND (  
		(Status BETWEEN 3 AND 4)
	 OR 
		(Status BETWEEN 97 AND 98)
	)
AND Pr.ProductNo <> 1051
AND IsFxBuyer = 1

UNION ALL

SELECT
newid() as Id, 1, @Creator, @ReportDate, Odc.Id, 'AcOwnDerivativeContract' AS SourceTableName,Pf.PartnerId, Cast(Odc.ContractKey As Varchar(15)) As ContractKey, Odc.DateTo, Ref.Currency,
(Pos.ValueProductCurrency - ISNULL(SUM(TI.DebitAmount),0) + ISNULL(SUM(TI.CreditAmount),0) + ISNULL(SUM(TI2.DebitAmount),0) - ISNULL(SUM(TI2.CreditAmount),0) ) * -1 AS ContractAmount,
Ref.Currency AS OpponentCurrency,
(Pos.ValueProductCurrency - ISNULL(SUM(TI.DebitAmount),0) + ISNULL(SUM(TI.CreditAmount),0) + ISNULL(SUM(TI2.DebitAmount),0) - ISNULL(SUM(TI2.CreditAmount),0) ) * -1 AS OpponentAmount,
1 AS PendingValuationFlag,
Odc.DerivativeTypeNo,
Odc.IsTradingBook, Odc.DateFrom, Odc.WithCloseOutNetting
FROM AcOwnDerivativeContract AS Odc
INNER JOIN AcDerivativeType AS DT ON Odc.DerivativeTypeNo = DT.DerivativeTypeNo
INNER JOIN PtAccountBase AS Receiver ON Odc.ReceiverAccountId = Receiver.Id
INNER JOIN PtAccountBase AS Payer ON Odc.PayerAccountId = Payer.Id
INNER JOIN PrReference AS Ref ON Receiver.Id = Ref.AccountId
INNER JOIN PtPosition AS Pos ON Ref.Id = Pos.ProdReferenceId
INNER JOIN PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId
INNER JOIN PtPortfolio AS Pf ON Receiver.PortfolioId = Pf.Id
LEFT OUTER JOIN PtTransItem AS TI ON Pos.Id = TI.PositionId AND TI.DetailCounter = 0 AND TI.RealDate <= @ReportDate
AND TI.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtTransItem AS TI2 ON Pos.Id = TI2.PositionId AND TI2.DetailCounter > 0 AND TI2.RealDate > @ReportDate
AND TI2.HdVersionNo between 1 and 999999998
WHERE Odc.HdVersionNo BETWEEN 1 AND 999999998 AND Odc.DateTo > @ReportDate AND (DateFrom IS NULL OR DateFrom < @ReportDate)
GROUP BY Odc.Id, Pf.PartnerId, Odc.ContractKey, Odc.DateTo, Ref.Currency,Odc.DerivativeTypeNo, Odc.IsTradingBook, Pos.ValueProductCurrency, Odc.DateFrom, Odc.WithCloseOutNetting

UNION ALL

SELECT NewId() AS Id, 1 AS HdVersionNo, @Creator AS HdCreator, @ReportDate AS ReportDate, 
FS.Id AS SourceRecordId, 'AcFrozenSecurityBalance' AS SourceTableName, 
FS.IssuerPartnerId AS PartnerId, 
'T' + CAST(ROW_NUMBER() OVER (order by FS.IsinNo) AS varchar(14)) as ContractKey, FS.MaturityDate AS DateTo, 
'CHF' AS ContractCurrency, 0 AS ContractAmount, 'CHF' AS OpponentCurrency, 0 AS OponentAmount,
0 AS PendingValuationFlag, 
CASE WHEN RightTypeNo = 1 THEN
	CASE WHEN Quantity > 0 THEN 50 -- Optionen Traded Call Long
	ELSE 52						   -- Optionen Traded Call Short	
	END
ELSE
	CASE WHEN Quantity > 0 THEN 51 -- Optionen Traded Put Long
	ELSE 53                        -- Optionen Traded Put Short
	END
END AS DerivativeTypeNo, 
CASE WHEN Pf.FireMappingType = 88 THEN 1 
ELSE 0 END AS IsTradingBook, NULL AS DateFrom, 0 AS WithCloseOutNetting
FROM AcFrozenSecurityBalance AS FS
INNER JOIN PrPublic AS Pr ON FS.ProductId = Pr.ProductId
INNER JOIN PrPublicCf AS Cf ON Pr.Id = Cf.PublicId 
INNER JOIN AcFireMappingPortfolio AS Pf ON FS.PortfolioId = Pf.PortfolioId AND Pf.FireMappingType IN (88,89)
WHERE FS.SecurityType = 'Z' AND FS.InstrumentTypeNo = 4 
AND Cf.PaymentTypeNo = 2 AND Cf.PaymentFuncNo = 18 AND Cf.CashFlowFuncNo = 1 AND Cf.CfAmountTypeNo = 1002
AND Cf.HdVersionNo BETWEEN 1 AND 999999998
AND ReportDate = @ReportDate

UNION ALL

SELECT NewId() AS Id, 1 AS HdVersionNo, @Creator AS HdCreator, @ReportDate AS ReportDate, 
FS.Id AS SourceRecordId, 'AcFrozenSecurityBalance' AS SourceTableName, 
FS.IssuerPartnerId AS PartnerId, 
'D' + CAST(ROW_NUMBER() OVER (order by FS.IsinNo) AS varchar(14)) as ContractKey, FS.MaturityDate AS DateTo, 
'CHF' AS ContractCurrency, 0 AS ContractAmount, 'CHF' AS OpponentCurrency, 0 AS OponentAmount,
0 AS PendingValuationFlag, 
0 AS DerivativeTypeNo, 
CASE WHEN Pf.FireMappingType = 88 THEN 1 
ELSE 0 END AS IsTradingBook, NULL AS DateFrom, 0 AS WithCloseOutNetting
FROM AcFrozenSecurityBalance AS FS
INNER JOIN PrPublic AS Pr ON FS.ProductId = Pr.ProductId
INNER JOIN PrPublicCf AS Cf ON Pr.Id = Cf.PublicId 
INNER JOIN AcFireMappingPortfolio AS Pf ON FS.PortfolioId = Pf.PortfolioId AND Pf.FireMappingType IN (88,89)
WHERE FS.SecurityType = '6' 
and FS.InstrumentTypeNo = 12 
and Cf.CashFlowFuncNo = 1 
AND Cf.HdVersionNo BETWEEN 1 AND 999999998
AND ReportDate = @ReportDate

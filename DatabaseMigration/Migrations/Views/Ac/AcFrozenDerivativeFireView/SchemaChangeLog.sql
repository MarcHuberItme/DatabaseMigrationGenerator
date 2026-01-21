--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenDerivativeFireView context:any labels:c-any,o-view,ot-schema,on-AcFrozenDerivativeFireView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenDerivativeFireView
CREATE OR ALTER VIEW dbo.AcFrozenDerivativeFireView AS
SELECT 
FD.Id,
FD.ReportDate, 
FD.SourceRecordId, 
FD.SourceTableName, 
FD.DerivativeTypeNo, 
FD.ContractKey,
CAST(FP.PartnerNo AS VARCHAR(12)) + '-' + CAST(FD.DerivativeTypeNo AS VARCHAR(10)) + '-' + FD.ContractKey AS FireTransactionNo,
FD.DateTo, 
FD.DateFrom,
FD.IsTradingBook, 
FD.ReplacementValue, 
CAST(FD.WithCloseOutNetting AS tinyint) NettingContract,
FP.PartnerNo, 
FP.FiscalDomicileCountry, 
FP.NogaCode2008, 
IsNull(FP.C510_Override, FP.CodeC510) As CodeC510, 
FP.LargeExpGroupNo, 
FP.MainPartnerNo, 
FP.Nationality, 
ISNULL(FP.Employees,0) AS Employees,
'RECEIVE' AS LegTag,
FD.ContractCurrency AS Currency,
FD.ContractAmount AS Amount,
FD.CoCuHoCuConversionRate AS ConversionRate,
FD.ContractAmountHoCu AS AmountHoCu,
FD.CoCuInterestRate AS InterestRate,
FD.CoAmountPresentValueHoCu AS PresentValueHoCu,
CASE WHEN FD.IsTradingBook = 0 THEN FireAccountBankingBookBuy
ELSE FireAccountTradingBookBuy END AS FireAccountNo,
CASE WHEN FD.DerivativeTypeNo = 20 THEN FD.CoAmountPresentValueHoCu
WHEN FD.ContractValueHoCu IS NOT NULL THEN FD.ContractValueHoCu
ELSE FD.ContractAmountHoCu END AS ContractVolume,
DT.FireUnderlyingTypeValue,
DT.ReceiveFix AS FixInterestRate,
UndFP.LargeExpGroupNo AS UnderlyingLargeExpGroupNo,
FP.C026_Deri
FROM AcFrozenDerivative AS FD
LEFT OUTER JOIN AcFrozenPartnerView AS FP ON FD.PartnerId = FP.PartnerId AND FD.ReportDate = FP.ReportDate
LEFT OUTER JOIN AcDerivativeType AS DT ON FD.DerivativeTypeNo = DT.DerivativeTypeNo
LEFT OUTER JOIN AcFrozenSecurityBalance AS FSB ON FD.SourceRecordId = FSB.Id AND FD.ReportDate = FSB.ReportDate
LEFT OUTER JOIN AcFrozenPartnerView AS UndFP ON FSB.NamingPartnerId = UndFP.PartnerId AND FSB.ReportDate = UndFP.ReportDate
WHERE PendingValuationFlag = 0
AND  FD.HdVersionNo BETWEEN 1 AND 999999998  

UNION ALL

SELECT 
FD.Id,
FD.ReportDate, 
FD.SourceRecordId, 
FD.SourceTableName, 
FD.DerivativeTypeNo, 
FD.ContractKey,
CAST(FP.PartnerNo AS VARCHAR(12)) + '-' + CAST(FD.DerivativeTypeNo AS VARCHAR(10)) + '-' + FD.ContractKey AS FireTransactionNo,
FD.DateTo, 
FD.DateFrom,
FD.IsTradingBook, 
FD.ReplacementValue, 
CAST(FD.WithCloseOutNetting AS tinyint) NettingContract,
FP.PartnerNo, 
FP.FiscalDomicileCountry, 
FP.NogaCode2008, 
IsNull(FP.C510_Override, FP.CodeC510) As CodeC510, 
FP.LargeExpGroupNo, 
FP.MainPartnerNo, 
FP.Nationality, 
ISNULL(FP.Employees,0) AS Employees,
'PAY' AS LegTag,
FD.OpponentCurrency,
FD.OpponentAmount,
FD.OpCuHoCuConversionRate,
FD.OpponentAmountHoCu,
FD.OpCuInterestRate,
FD.OpAmountPresentValueHoCu,
CASE WHEN FD.IsTradingBook = 0 THEN FireAccountBankingBookSell
ELSE FireAccountTradingBookSell END AS FireAccountNo,
CASE WHEN FD.DerivativeTypeNo = 20 THEN FD.OpAmountPresentValueHoCu
WHEN FD.ContractValueHoCu IS NOT NULL THEN FD.ContractValueHoCu
ELSE FD.OpponentAmountHoCu END AS ContractVolume,
DT.FireUnderlyingTypeValue,
DT.PayFix AS FixInterestRate,
UndFP.LargeExpGroupNo AS UnderlyingLargeExpGroupNo,
FP.C026_Deri
FROM AcFrozenDerivative AS FD
LEFT OUTER JOIN AcFrozenPartnerView AS FP ON FD.PartnerId = FP.PartnerId AND FD.ReportDate = FP.ReportDate
LEFT OUTER JOIN AcDerivativeType AS DT ON FD.DerivativeTypeNo = DT.DerivativeTypeNo
LEFT OUTER JOIN AcFrozenSecurityBalance AS FSB ON FD.SourceRecordId = FSB.Id AND FD.ReportDate = FSB.ReportDate
LEFT OUTER JOIN AcFrozenPartnerView AS UndFP ON FSB.NamingPartnerId = UndFP.PartnerId AND FSB.ReportDate = UndFP.ReportDate
WHERE PendingValuationFlag = 0  
AND  FD.HdVersionNo BETWEEN 1 AND 999999998

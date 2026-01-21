--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenDerivativeSummaryView context:any labels:c-any,o-view,ot-schema,on-AcFrozenDerivativeSummaryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenDerivativeSummaryView
CREATE OR ALTER VIEW dbo.AcFrozenDerivativeSummaryView AS
SELECT TOP 100 PERCENT
ReportDate,
DerivativeTypeNo,
IsTradingBook,
CASE WHEN DerivativeTypeNo IN (10, 11,99) THEN SUM(ContractAmountHoCu) -- Kontraktvolumen IRS
WHEN DerivativeTypeNo IN (50, 53) THEN SUM(UnderlyingMarketValueHoCu) -- Kontraktvolumen Kauf Call / Verkauf Put
WHEN DerivativeTypeNo IN (51, 52) THEN SUM(ContractValueHoCu) -- Kontraktvolumen Verkauf Call / Kauf Put
ELSE SUM(CoAmountPresentValueHoCu) 
END AS CoAmountPresentValueHoCu, 
SUM(CASE WHEN ReplacementValue >= 0 THEN ReplacementValue
ELSE NULL END) AS ReplacementValuePos,
SUM(CASE WHEN ReplacementValue < 0 THEN ReplacementValue
ELSE NULL END) AS ReplacementValueNeg,
Count(*) AS NoOfContracts,
SUM(CASE WHEN DateTo IS NULL OR ContractKey IS NULL OR ReplacementValue IS NULL THEN 1 ELSE 0 END) AS IncompleteCount
FROM AcFrozenDerivative AS FFC
WHERE FFC.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY ReportDate, DerivativeTypeNo, IsTradingBook

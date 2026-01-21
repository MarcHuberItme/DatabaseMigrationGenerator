--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenDerivativeRvFireView context:any labels:c-any,o-view,ot-schema,on-AcFrozenDerivativeRvFireView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenDerivativeRvFireView
CREATE OR ALTER VIEW dbo.AcFrozenDerivativeRvFireView AS

SELECT 
RV.ReportDate, 
RV.PartnerId, 
SUM(RV.PosReplacementValue) AS PosReplacementValue, 
SUM(-RV.NegReplacementValue) AS NegReplacementValue, 
SUM(RV.NetPosReplacementValue) AS NetPosReplacementValue, 
SUM(-RV.NetNegReplacementValue) AS NetNegReplacementValue, 
FP.PartnerNo, 
FP.FiscalDomicileCountry, 
FP.NogaCode2008, 
IsNull(FP.C510_Override, FP.CodeC510) As CodeC510, 
FP.LargeExpGroupNo, 
FP.MainPartnerNo, 
FP.Nationality, 
ISNULL(FP.Employees,0) AS Employees,
'RV pos. ' + CAST(FP.PartnerNo AS VARCHAR(12)) AS C014_Pos, 
'RV neg. ' + CAST(FP.PartnerNo AS VARCHAR(12)) AS C014_Neg,
RV.DateTo, RV.DateFrom
FROM AcFrozenDerivative_RvView AS RV
LEFT OUTER JOIN AcFrozenPartnerView AS FP ON RV.PartnerId = FP.PartnerId AND RV.ReportDate = FP.ReportDate
GROUP BY 
RV.ReportDate, 
RV.PartnerId, 
FP.PartnerNo, 
FP.FiscalDomicileCountry, 
FP.NogaCode2008, 
IsNull(FP.C510_Override, FP.CodeC510),
FP.LargeExpGroupNo, 
FP.MainPartnerNo, 
FP.Nationality, 
FP.Employees,
RV.DateTo, RV.DateFrom



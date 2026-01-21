--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenOwnBondView context:any labels:c-any,o-view,ot-schema,on-AcFrozenOwnBondView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenOwnBondView
CREATE OR ALTER VIEW dbo.AcFrozenOwnBondView AS
select top 100 percent
FSB.Id,
FSB.ReportDate, 
MaturityDate, 
InterestRate, 
InstrumentCountryCode, 
CAST(InterestRate AS VARCHAR(20)) + '% ' + ISNULL(CONVERT(VARCHAR(20),MaturityDate,112),'--------') + ' - ' + CAST(FPV.PartnerNo AS VARCHAR(10)) AS Description,  
FPV.CodeC510,
Quantity,
Issuer.FiscalDomicileCountry AS IssuerDomicileCountry,
FSB.InterestTypeNo,
FSB.SecurityType,
FSB.RedemptionCode,
FSB.TimeUnitNo,
Fpv.NogaCode2008,
Fpv.LargeExpGroupNo,
Fpv.PartnerNo,
Fpv.SexStatusNo
from AcFrozenSecurityBalance AS FSB
INNER JOIN PrLocGroup AS Loc ON FSB.ProdLocGroupId = Loc.Id
LEFT OUTER JOIN AcFrozenPartnerView AS Fpv ON FSB.ReportDate = FPV.ReportDate AND FSB.PartnerId = Fpv.PartnerId 
LEFT OUTER JOIN AcFrozenPartnerView AS Issuer ON FSB.ReportDate = Issuer.ReportDate AND FSB.IssuerPartnerId = Issuer.PartnerId 
WHERE loc.GroupNo IN (10,20) AND FSB.PortfolioLocGroupId IS NULL AND IsCollateral = 0

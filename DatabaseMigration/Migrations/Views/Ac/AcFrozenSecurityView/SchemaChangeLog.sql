--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenSecurityView context:any labels:c-any,o-view,ot-schema,on-AcFrozenSecurityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenSecurityView
CREATE OR ALTER VIEW dbo.AcFrozenSecurityView AS
-- View Wertschriften 
select 
SB.Id, 
SB.HdVersionNo,
SB.HdEditStamp,
SB.HdPendingChanges,
SB.HdPendingSubChanges,
SB.HdStatusFlag,
SB.HdProcessId,
SB.HdCreateDate,
SB.HdChangeDate,
SB.HdCreator,
SB.HdChangeUser,
SB.ReportDate, 
SB.PortfolioNo, 
SB.PortfolioTypeNo,
SB.PositionId, 
SB.ProdLocGroupId,
IsNull(SB.RemainingQuantity, SB.Quantity) As Quantity, 
SB.MaturityDate, SB.OutstandingInterestDueDate, SB.BeginDate,
SB.InterestRate, 
SB.IsinNo, 
SB.FundCatSchemeCode,
SB.RefTypeNo, 
SB.SecurityType,
SB.InstrumentFormNo, 
SB.InstrumentTypeNo, 
SB.FundTypeNo, 
SB.DepositTypeForFire, 
SB.InstrumentCountryCode, 
SB.PortfolioNoText, 
SB.RankingNo, 
SB.OwnSecurityValueHoCu, 
SB.PartnerId,
SB.PortfolioId,
SB.ProductId,
SB.NamingPartnerId,
SB.PosNostroTypeId,
SB.RedemptionCode,
Pt.PartnerNo AS PtPartnerNo,
Pt.ReportAdrLine AS PtReportAdrLine,
Pt.SwissTownNo AS PtSwissTownNo,
Pt.Canton AS PtCanton,
IsNull(Pt.C510_Override, Pt.CodeC510) AS PtCodeC510, 
NULL AS CustomerReference, 
Pt.NogaCode2008 AS PtNoga2008,
FPV.PartnerNo AS InstrPartnerNo, 
FPV.ReportAdrLine AS InstrPtAdrLine, 
FPV.SwissTownNo AS InstrSwissTownNo, 
FPV.Canton AS InstrCanton, 
IsNull(FPV.C510_Override,FPV.CodeC510) AS InstrCodeC510, 
FPV.LargeExpGroupNo AS InstrLargeExpGroupNo,
CASE WHEN SB.PortfolioTypeNo = 5000 THEN NULL
WHEN SB.IsCustomer = 1 THEN 50
ELSE FMDT.MappingTypeNo END AS MappingTypeNo,
FMDT.FireAccountNo AS MappingFireAccountNo,
FMDT.ValueInitModeNo,
SB.Currency, 
SB.PortfolioNoText + '-' + ISNULL(SB.IsinNo,'---') +  '-' + ISNULL(SB.Currency,'---') + '-' + ISNULL(CAST(LG.GroupNo AS VARCHAR(10)),'') AS SecurityPosDesc, 
CodeC520,
SB.FireStockExListingCode,
IsNull(Issuer.C510_Override,Issuer.CodeC510) AS IssuerCodeC510,
Issuer.PartnerNo AS IssuerPartnerNo,
SB.TimeUnitNo,
SB.InterestTypeNo,
SB.PortfolioLocGroupId,
IsNull(SB.RemainingMarketValueHoCu, SB.MarketValueHoCu) As MarketValueHoCu,
SB.AccruedInterestHoCu,
LG.FireTypeOfCredit As PrLocGroupC520,
SB.NominalCurrency,
DT.CustomerUnpledgedFireAccountNo,
DT.CustomerPledgedFireAccountNo,
IsCustomer, Pt.FiscalDomicileCountry AS CustomerCountry, SB.CodeC541, SB.CodeC533, Issuer.LargeExpGroupNo AS IssuerLargeExpGroupNo,
CASE WHEN IsCustomer = 1 AND SecurityType NOT IN ('Z','P','5','T','E', 'D', '4') THEN 1
ELSE 0 END AS ReportCustSecToFire,
CASE WHEN PledgeKey IS NULL THEN DT.CustomerUnpledgedFireAccountNo
ELSE DT.CustomerPledgedFireAccountNo END AS OutputFireAccountNo,
ISNULL(SB.PledgeKey, Pt.PartnerNo) AS PledgeKey,
Pt.LargeExpGroupNo AS CustomerLargeExpGroupNo,
ISNULL(ISNULL(RemainingMarketValueHoCu,SB.MarketValueHoCu),0) + ISNULL(SB.AccruedInterestHoCu,0) AS MarketValueWithAcrIntHoCu,
IsNull(SB.HQLA, SB.HQLAmanual) AS HQLA,
SB.Pawned,
OSR2.PriceChangePercent,
OSR2.ValuationDate,
OSR2.Caution,
SB.IsCollateral,
SB.CollateralValueHoCu,
SB.QuarterlyBuyCHF,
SB.QuarterlySellCHF,
SB.PledgedAmount
FROM AcFrozenSecurityBalance AS SB
LEFT OUTER JOIN AcFrozenPartnerView AS FPV ON SB.NamingPartnerId = FPV.PartnerId AND SB.ReportDate = FPV.ReportDate
LEFT OUTER JOIN AcFrozenPartnerView AS Issuer ON SB.IssuerPartnerId = Issuer.PartnerId AND SB.ReportDate = Issuer.ReportDate
LEFT OUTER JOIN AcFrozenPartnerView AS Pt ON SB.PartnerId = Pt.PartnerId AND SB.ReportDate = Pt.ReportDate
LEFT OUTER JOIN AcFireMappingPortfolio AS FMP ON SB.PortfolioId = FMP.PortfolioId
LEFT OUTER JOIN AcFireMappingDepositType AS FMDT ON SB.DepositTypeForFire = FMDT.DepositTypeNo AND FMP.FireMappingType = FMDT.MappingTypeNo AND FMDT.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AcFireDepositType AS DT ON SB.DepositTypeForFire = DT.DepositTypeNo AND DT.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrLocGroup AS LG ON SB.ProdLocGroupId = LG.Id
--LEFT OUTER JOIN AcOwnSecurityRates AS OSR ON SB.PositionId = OSR.PositionId AND SB.ReportDate = OSR.ValuationDate
LEFT OUTER JOIN (SELECT sr.PositionId, Min(sr.PriceChangePercent) As PriceChangePercent
		FROM   AcOwnSecurityRates sr
		WHERE  sr.HdVersionNo < 999999999
		GROUP BY sr.PositionId
		) OSR ON SB.PositionId = OSR.PositionId
LEFT OUTER JOIN (SELECT sr.PositionId,  sr.PriceChangePercent, sr.Caution, Max(sr.ValuationDate) AS ValuationDate
		FROM   AcOwnSecurityRates sr
		WHERE  sr.HdVersionNo < 999999999
		GROUP BY sr.PositionId, sr.PriceChangePercent, sr.Caution
		) OSR2 ON SB.PositionId = OSR2.PositionId AND OSR.PriceChangePercent = OSR2.PriceChangePercent



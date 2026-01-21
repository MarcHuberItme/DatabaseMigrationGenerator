--liquibase formatted sql

--changeset system:create-alter-view-PtPositionFireView context:any labels:c-any,o-view,ot-schema,on-PtPositionFireView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionFireView
CREATE OR ALTER VIEW dbo.PtPositionFireView AS
SELECT 
Pf.PartnerId, 
Pf.Id AS PortfolioId, 
Pf.PortfolioNo, 
Pf.PortfolioTypeNo, 
Pf.LocGroupId, 
Pf.NostroTypeId, 
Pos.Id AS PositionId, 
Pos.ProdLocGroupId, 
Pos.NostroTypeId AS PosNostroTypeId, 
Pos.Quantity, 
Pos.LatestTransDate,
ISNULL(Ref.MaturityDate,MAX(DueDate)) AS MaturityDate, 
ISNULL(PUB.ActualInterest,Ref.InterestRate) AS InterestRate, 
Ref.ProductId, 
PUB.IsinNo, 
PUB.FundCatSchemeCode, 
PUB.RefTypeNo, 
PUB.SecurityType, 
PUB.InstrumentFormNo, 
PUB.InstrumentTypeNo, 
PUB.NamingPartnerId, 
PUB.RedemptionCode, 
MIN(PUB.CountryCode) AS InstrumentCountryCode, 
PUB.FundTypeNo,
DepositTypeForFire =
CASE
WHEN MIN(SnbCl.SnbClassNo) IN (101,111) THEN             		1    	--Geldmarktpapiere
WHEN MIN(SnbCl.SnbClassNo) IN (102) THEN                 		2    	--Kassenobligationen
WHEN MIN(SnbCl.SnbClassNo) IN (103,104,105,112,113) THEN
	CASE WHEN MIN(PDT.DebtorType) = 4 THEN 		4	--Pfandbriefe
	ELSE				 		3    	--Obligationen
	END
WHEN MIN(SnbCl.SnbClassNo) IN (106,114) THEN             		7    	--Aktien
WHEN MIN(SnbCl.SnbClassNo) IN (135,140) THEN             		8    	--Kapitalschutzprod.
WHEN MIN(SnbCl.SnbClassNo) IN (132,137) THEN             		9    	--Hebel Produkte
WHEN MIN(SnbCl.SnbClassNo) IN (133,138) THEN             		10   	--Partizipationsprod.
WHEN MIN(SnbCl.SnbClassNo) IN (134,139) THEN             		11   	--Renditeoptimierungsprod.
WHEN MIN(SnbCl.SnbClassNo) IN (136,141) THEN             		12   	--übrige Strukturierte Prod.
WHEN MIN(SnbCl.SnbClassNo) IN (109,117) THEN             		19   	--andere Effekten
-- Kollektivanalgefonds (KA)
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode = 2 AND PUB.FundTypeNo = 3 AND PUB.FundCatSchemeCode = 'KAG' THEN 15    --KA Open-end / Geldmarkt / KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode = 2 AND PUB.FundTypeNo = 3 AND PUB.FundCatSchemeCode IS NULL THEN 16    --KA Open-end / Geldmarkt / nicht KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode <> 2 AND PUB.FundTypeNo = 3 AND PUB.FundCatSchemeCode = 'KAG' THEN 17   --KA Closed-end / Geldmarkt / KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode <> 2 AND PUB.FundTypeNo = 3 AND PUB.FundCatSchemeCode IS NULL THEN 18   --KA Closed-end / Geldmarkt / nicht KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode = 2 AND (PUB.FundTypeNo IS NULL OR PUB.FundTypeNo <> 3) AND PUB.FundCatSchemeCode = 'KAG' THEN 5    --KA Open-end / -- / KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode = 2 AND (PUB.FundTypeNo IS NULL OR PUB.FundTypeNo <> 3) AND PUB.FundCatSchemeCode IS NULL THEN 6    --KA Open-end / -- / nicht KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode <> 2 AND (PUB.FundTypeNo IS NULL OR PUB.FundTypeNo <> 3) AND PUB.FundCatSchemeCode = 'KAG' THEN 13  --KA Closed-end / -- / KAG
WHEN PUB.SecurityType IN ('7', 'C') AND PUB.RedemptionCode <> 2 AND (PUB.FundTypeNo IS NULL OR PUB.FundTypeNo <> 3) AND PUB.FundCatSchemeCode IS NULL THEN 14  --KA Closed-end / -- / nicht KAG
-- In case SNB ClassNo is not available for a position, use general rules
WHEN PUB.SecurityType = 'Q' 				THEN      1    --Geldmarktpapiere
WHEN PUB.SecurityType = '2' 				THEN      2    --Kassenobligationen
WHEN PUB.SecurityType IN ('0','L','V') 				THEN 	3    --Obligationen
WHEN PUB.SecurityType IN ('1', 'A', 'G')			THEN 	7    --Aktien
WHEN PUB.SecurityType = '6' 				THEN      12  --Hybride (übrige Strukturierte Produkte)
WHEN PUB.SecurityType IN ('4', 'P', 'S','D') 			THEN 	19  --andere Effekten
WHEN PUB.SecurityType = 'M'				THEN      9    --Hebel Produkte (M = Warrant)
WHEN PUB.SecurityType = 'U' 				THEN      20  --Edelmetalle
WHEN PUB.SecurityType = 'R' AND PubAdd.CommodityCatNo = 4	THEN	20  --Edelmetalle
ELSE NULL
END, 
Pf.PortfolioNoText, PUB.RankingNo, Ref.Currency, PUB2.IssuerId, PUB2.TimeUnitNo, PUB2.InterestTypeNo, PUB.NominalCurrency, PPT.IsCustomer
FROM PtPortfolio AS Pf
INNER JOIN PtPortfolioType AS PPT ON Pf.PortfolioTypeNo = PPT.PortfolioTypeNo
INNER JOIN PtPosition AS Pos ON Pf.Id = Pos.PortfolioId
INNER JOIN PrReference AS Ref ON Ref.Id = Pos.ProdReferenceId
INNER JOIN PrPublicInstrumentMainDataView AS PUB ON Ref.ProductId = PUB.ProductId
INNER JOIN PrPublic AS PUB2 ON Ref.ProductId = PUB2.ProductId
LEFT OUTER JOIN PrPublicCF AS CF ON PUB.Id = CF.PublicId AND PUB.RefTypeNo NOT IN (3,4) AND CF.CashFlowFuncNo = 1 AND CF.HdVersionNo BETWEEN 1 AND 999999998 
		AND CF.CashFlowStatusNo NOT IN (4,5,6) AND CF.DueDate IS NOT NULL
LEFT OUTER JOIN PrPublicInstrSnbClass AS SnbCl ON PUB.Id = SnbCl.PublicId AND SnbCl.HdVersionNo BETWEEN 1 AND 999999998 AND SnbCl.SnbClassNo NOT IN (110,118,121,122,123)
LEFT OUTER JOIN PrPublicStructure AS PS ON PUB.Id = PS.MasterId AND PS.StructureTypeNo = 2 AND PS.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicStructureAssign AS PSA ON PS.Id = PSA.StructureId AND PSA.Amount = 100 AND PSA.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicDebtorType AS PDT ON PSA.ForeignKeyId = PDT.Id AND PDT.DebtorType = 4 AND PDT.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicAddData AS PubAdd ON PUB.Id = PubAdd.PublicId
WHERE ppt.IsExcustody = 0
group by Pf.PartnerId, Pf.Id, Pf.PortfolioNo, Pf.PortfolioTypeNo, Pf.LocGroupId, Pf.NostroTypeId, Pos.Id, Pos.LatestTransDate, Pos.ProdLocGroupId, Pos.NostroTypeId, Pos.Quantity, Ref.MaturityDate, Ref.InterestRate, 
Ref.ProductId, PUB.NamingPartnerId, PUB.FundCatSchemeCode,PUB.ActualInterest, PUB.RefTypeNo, PUB.SecurityType, PUB.InstrumentFormNo, PUB.IsinNo, PUB.InstrumentTypeNo, 
PUB.RedemptionCode, PUB.FundTypeNo, PUB.Id, Pf.PortfolioNoText, PUB.RankingNo, Ref.Currency, PUB2.IssuerId,PUB2.TimeUnitNo, PUB2.InterestTypeNo, PUB.NominalCurrency, PPT.IsCustomer, PubAdd.CommodityCatNo



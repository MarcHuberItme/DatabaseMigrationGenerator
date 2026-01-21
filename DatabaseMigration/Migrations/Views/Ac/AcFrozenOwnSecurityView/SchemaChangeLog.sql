--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenOwnSecurityView context:any labels:c-any,o-view,ot-schema,on-AcFrozenOwnSecurityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenOwnSecurityView
CREATE OR ALTER VIEW dbo.AcFrozenOwnSecurityView AS
SELECT TOP 100 PERCENT
FF.ReportDate,
ISNULL(OwnSec.MappingTypeNo, Balance.MappingTypeNo) AS MappingTypeNo, 
ISNULL(OwnSec.OwnSecurityValueHoCu,0) AS OwnSecurityValueHoCu, 
ISNULL(Balance.BalanceValueHoCu,0) AS BalanceValueHoCu, 
ISNULL(OwnSec.OwnSecurityValueHoCu,0) - ISNULL(Balance.BalanceValueHoCu,0) AS DifferenceValueHoCu
FROM AcFireReport AS FF
FULL JOIN (
	SELECT  SB.ReportDate, FMP.FireMappingType As MappingTypeNo, SUM(OwnSecurityValueHoCu) AS OwnSecurityValueHoCu
	FROM AcFrozenSecurityBalance AS SB
	INNER JOIN AcFireMappingPortfolio AS FMP ON SB.PortfolioId = FMP.PortfolioId
	--INNER JOIN AcFireMappingDepositType AS FMDT ON SB.DepositTypeForFire = FMDT.DepositTypeNo AND FMP.FireMappingType = FMDT.MappingTypeNo
	WHERE EXISTS ( SELECT * FROM AcFireMappingDepositType FMDT where  FMDT.DepositTypeNo = SB.DepositTypeForFire and FMDT.MappingTypeNo = FMP.FireMappingType and FMDT.HdVersionNo < 999999999)
	GROUP BY SB.ReportDate, FMP.FireMappingType) AS OwnSec ON FF.ReportDate = OwnSec.ReportDate
FULL JOIN (
		SELECT FA.ReportDate, Mapping.MappingTypeNo, SUM(0 - FA.ValueHoCu) AS BalanceValueHoCu
		FROM AcFrozenAccount AS FA
		INNER JOIN (
			SELECT FMDT.MappingTypeNo, BS.BalanceAccountNo
			FROM AcBalanceStructure AS BS 
			INNER JOIN AcFireMappingDepositType AS FMDT ON BS.FireAccountNo = FMDT.FireAccountNo
                                                WHERE BS.BalanceSheetTypeNo = 20
			GROUP BY FMDT.MappingTypeNo, BS.BalanceAccountNo) AS Mapping ON FA.AccountNo = Mapping.BalanceAccountNo
		GROUP BY FA.ReportDate, MappingTypeNo
	) AS Balance ON FF.ReportDate = Balance.ReportDate AND Balance.MappingTypeNo = OwnSec.MappingTypeNo


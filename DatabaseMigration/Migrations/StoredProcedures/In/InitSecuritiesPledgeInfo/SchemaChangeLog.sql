--liquibase formatted sql

--changeset system:create-alter-procedure-InitSecuritiesPledgeInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-InitSecuritiesPledgeInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure InitSecuritiesPledgeInfo
CREATE OR ALTER PROCEDURE dbo.InitSecuritiesPledgeInfo
@ReportDate datetime

AS

UPDATE AcFrozenAccountComponent SET PledgePortfolioNo = PortfolioNo
FROM AcFrozenAccountComponent AS FAC
INNER JOIN 
(
	SELECT FAC.Id, FAC.ReportDate, FAC.AccountNo, FAC.ComponentId, FAC.UsedValueHomeCurrency, ISNULL(Pf.PortfolioNo, MIN(Pf2.PortfolioNo)) AS PortfolioNo
	FROM AcFrozenAccountComponent AS FAC
	LEFT OUTER JOIN PtPortfolio AS Pf ON FAC.MgVBNR = Pf.PortfolioNo
	LEFT OUTER JOIN PrPrivateCompType AS PC ON FAC.CompTypeNo = PC.CompTypeNo
	LEFT OUTER JOIN AsGroupMember AS GM ON PC.Id = GM.TargetRowId
	LEFT OUTER JOIN AsGroupMember AS GM2 ON Gm.GroupId = GM2.GroupId
	LEFT OUTER JOIN PrPrivateCompType AS PC2 ON GM2.TargetRowId = PC2.Id
	LEFT OUTER JOIN AcFrozenAccountComponent AS FAC2 ON FAC.ReportDate = FAC2.ReportDate AND FAC.AccountNo = FAC2.AccountNo AND FAC2.CompTypeNo = PC2.CompTypeNo
	LEFT OUTER JOIN PtPortfolio AS Pf2 ON FAC2.MgVBNR = Pf2.PortfolioNo
	WHERE FAC.ReportDate = @ReportDate
	AND FAC.Value > 0 AND FAC.UsedValueHomeCurrency > 0
	AND FAC.CompTypeNo IN (
		SELECT Pr.CompTypeNo
		from AsGroupMember AS GM
		INNER JOIN AsGroupLabel AS GL ON GL.GroupId = GM.GroupId
		INNER JOIN PrPrivateCompType AS Pr ON GM.TargetRowId = Pr.Id
		WHERE GL.Name = 'Fire_Basel_II_Pledge_Securities')
	GROUP BY FAC.Id, FAC.ReportDate, FAC.AccountNo, FAC.ComponentId, Pf.PortfolioNo, FAC.UsedValueHomeCurrency
) AS Result ON FAC.Id = Result.Id
WHERE FAC.ReportDate = @ReportDate

UPDATE AcFrozenSecurityBalance SET PledgeKey = NULL
WHERE ReportDate = @ReportDate and IsCollateral = 0

UPDATE AcFrozenSecurityBalance SET PledgeKey = PortfolioNo
WHERE ReportDate = @ReportDate
AND EXISTS (Select * FROM AcFrozenAccountComponent AS FAC WHERE FAC.ReportDate = @ReportDate AND FAC.PledgePortfolioNo = AcFrozenSecurityBalance.PortfolioNo)
and IsCollateral = 0



--UPDATE AcFrozenSecurityBalance  SET PledgeKey = 
--(SELECT top 1 PartnerNo From CoMevView cmv
-- join AcFrozenAccountView afc on afc.AccountId = cmv.accountid and afc.ReportDate = AcFrozenSecurityBalance.ReportDate
--	where cmv.mevyear = YEAR(AcFrozenSecurityBalance.ReportDate) and cmv.mevmonth = MONTH(AcFrozenSecurityBalance.ReportDate)
--	    and cmv.portfolioid = AcFrozenSecurityBalance.PortfolioId
--	order by cmv.Pledgevalueassign desc ) 
--   
-- where  AcFrozenSecurityBalance.ReportDate = @ReportDate 
--  AND AcFrozenSecurityBalance.PledgeKey IS NULL



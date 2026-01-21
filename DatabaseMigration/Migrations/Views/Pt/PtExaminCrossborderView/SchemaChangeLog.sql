--liquibase formatted sql

--changeset system:create-alter-view-PtExaminCrossborderView context:any labels:c-any,o-view,ot-schema,on-PtExaminCrossborderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtExaminCrossborderView
CREATE OR ALTER VIEW dbo.PtExaminCrossborderView AS
SELECT 
V.BranchNo, Tx.TextShort AS BranchText,
ConsultantTeam,
ConsultantTeamText, 
    CASE  WHEN Pendenz.StatusNo = 15 THEN 999
               WHEN IsUsPerson <> 0 AND WithW9 = 0 THEN 1
	WHEN IsCrossborderAllowed = 0 AND IsUsPerson = 0 AND (ISNULL(DebitAmountHoCu,0) + ISNULL(PortfolioValueHoCu,0)) > 50000 THEN 2
	WHEN HasCard = 1 OR WithEbankingAgr <> 0 THEN 3
	WHEN IsCrossborderAllowed = 0 AND IsUsPerson = 0 AND (DebitAmountHoCu + ISNULL(PortfolioValueHoCu,0)) <= 50000 THEN 4
	WHEN IsCrossborderAllowed = 1 AND WithEuInfoX = 0 AND FiscalDomicileCountry NOT IN ('US', 'CA') THEN 5
	WHEN IsCrossborderTeam = 0 THEN 6
	ELSE 99 END AS Prio,
V.PartnerNo, V.ReportAdrLine, FiscalDomicileCountry, Nationality, DebitAmountHoCu, CreditAmountHoCu, PortfolioValueHoCu,

CASE WHEN IsUsPerson <> 0 AND WithW9 = 0 THEN 1 ELSE 0 END AS US_Without_W9,
CASE WHEN ISNULL(IsCrossborderAllowed,0) = 1 AND WithEuInfoX = 0 AND FiscalDomicileCountry NOT IN ('US', 'CA') THEN 1 Else 0 END AS EuInfoX_Missing,
CASE WHEN FiscalDomicileCountry = 'CH' THEN 1 ELSE ISNULL(IsCrossborderAllowed,0) END AS IsCrossborderAllowed,
HasCard,
CASE WHEN FiscalDomicileCountry = 'CH' THEN 0 ELSE ISNULL(WithEbankingAgr,0) END AS WithEbankingAgr, IsUsPerson, ISNULL(O_St_Text.TextShort, 'Eintrag fehlt!') AS Pend_Status_Text, Pendenz.StatusNo, Pendenz.TargetDate, V.PartnerId, IsCrossborderTeam, ConsultantTeamId
FROM AcFrozenPtValueAndEarningView AS V
LEFT OUTER JOIN AsBranch AS B ON V.ConsultantTeamBranchNo = B.BranchNo
LEFT OUTER JOIN AsText AS Tx ON B.Id = Tx.MasterId AND Tx.LanguageNo = 2
LEFT OUTER JOIN (

	SELECT PartnerId, MIN(StatusNo) AS StatusNo, MIN(TargetDate) AS TargetDate 
	FROM PtOpenIssue AS OI
	WHERE HdVersionNo BETWEEN 1 AND 999999998
	AND TypeNo = 96
	AND NOT EXISTS (SELECT * FROM PtOpenIssue 
		                WHERE PartnerId = OI.PartnerId 
			AND Id <> OI.Id
			AND TypeNo = OI.TypeNo
			AND StatusNo < OI.StatusNo
                		AND HdVersionNo BETWEEN 1 AND 999999998) 
	GROUP BY PartnerId ) AS Pendenz ON V.PartnerId = Pendenz.PartnerId
LEFT OUTER JOIN PtOpenIssueStatus AS O_St ON Pendenz.StatusNo = O_St.StatusNo
LEFT OUTER JOIN AsText AS O_St_Text ON O_St.Id = O_St_Text.MasterId AND O_St_Text.LanguageNo = 2
LEFT OUTER JOIN PtCrossborder AS CB ON V.PartnerId = CB.PartnerId AND CB.HdVersionNo BETWEEN 1 AND 999999998
WHERE (FiscalDomicileCountry <> 'CH' OR IsUsPerson = 1) AND TerminationDate IS NULL
AND (
     (IsCrossborderAllowed = 0 AND FiscalDomicileCountry <> 'CH')-- Land nicht zugelassen
     OR HasCard = 1           -- Debit und Kreditkarten
     OR WithEbankingAgr <> 0  -- Ebanking Vertrag
     OR IsCrossborderTeam = 0 -- Beraterteam nicht Mitglied von Crossborder Team
     OR (WithEuInfoX = 0 AND IsCrossborderAllowed = 1 AND FiscalDomicileCountry NOT IN ('US', 'CA'))  -- EU-Meldeverfahren fehlt
     OR (IsUsPerson = 1 AND WithW9 = 0) -- US-Person ohne W9
     OR (Pendenz.StatusNo IN (5, 15, 300))    )

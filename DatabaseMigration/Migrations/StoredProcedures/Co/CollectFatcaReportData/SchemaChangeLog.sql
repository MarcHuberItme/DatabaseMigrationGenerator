--liquibase formatted sql

--changeset system:create-alter-procedure-CollectFatcaReportData context:any labels:c-any,o-stored-procedure,ot-schema,on-CollectFatcaReportData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CollectFatcaReportData
CREATE OR ALTER PROCEDURE dbo.CollectFatcaReportData
AS

DECLARE @reportDate DATETIME;
DECLARE @taxReportId UNIQUEIDENTIFIER;
DECLARE @taxProgramNo INT;
DECLARE @TextNoCreditInterest INT;
DECLARE @periodStartDate DATETIME;
DECLARE @VaRunId UNIQUEIDENTIFIER;

--------------------------------------------  für FATCA503 ------------------------------------------
--table PtTransType
DECLARE @TransTypeNo_inclTrans AS TABLE (TransTypeNo INT)
INSERT INTO @TransTypeNo_inclTrans 
	SELECT TransTypeNo FROM GetTransTypeNoListByGroupLbl('TaxReporting_TransType','TransTypeNo_inclTrans')

--table PtTransItemText
DECLARE @TextNoTab_ExclInAmount AS TABLE (TextNo INT)
INSERT INTO @TextNoTab_ExclInAmount 
	SELECT TextNo FROM GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_ExpCost')
	UNION SELECT TextNo FROM GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_WithholdingTax')
	UNION SELECT TextNo FROM GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_VAT')
	UNION SELECT TextNo FROM GetTextNoListByGroupLbl('TaxReporting_TextNo','TextNo_EuTax')
--------------------------------------------

SET @taxProgramNo = 840

SELECT @taxReportId = Id, @reportDate = ReportingPeriod, @periodStartDate = DATEADD(YEAR, -1, ReportingPeriod)
FROM AiTaxReport
WHERE TaxProgramNo = @taxProgramNo
AND ReportTypeNo = 1
AND ReportStatusNo = 1;

SELECT Top 1 @VaRunId =  Id 
FROM VaRun 
WHERE ValuationDate = @ReportDate
   AND RunTypeNo IN (0,1,2)  
   AND ValuationStatusNo=99
ORDER BY RunTypeNo DESC

SELECT @TextNoCreditInterest = p.Value
FROM AsParameter p JOIN AsParameterGroup pg ON p.ParamGroupId = pg.Id
WHERE pg.GroupName = 'AccountClosing'
AND p.Name =  'TextNoCreditInterest';


SELECT * 
INTO #FatcaPartnerData
FROM(
SELECT 
DISTINCT
NEWID() AS AiPartnerId,
pb.Id AS InhaberMitinhaberId,
pb.PartnerNoEdited AS InhaberMitinhaberNo,
fs.PartnerTypeNo AS PartnerTypeNo,
CASE WHEN pa.CountryCode = 'US'
	THEN 'US'
	ELSE 'US;' + pa.CountryCode
END AS FiscalCountries,	
pb.Title,
CASE WHEN pb.MaidenName IS NOT NULL
	THEN CASE WHEN pb.ChangeNameOrder = 1
		THEN pb.Name + ' ' + pb.MaidenName
		ELSE pb.Name + '-' + pb.MaidenName
	END
	ELSE pb.Name
END AS Name,
pb.FirstName,
pb.MiddleName,
pb.NameCont,
pb.MaidenName,
pb.DateOfBirth,
nat.Nationalities,
pa.Zip AS AddrZip,
pa.Town AS addrTown,
pa.Street AS AddrStreet, 
pa.HouseNo AS AddrHouseNo, 
CASE WHEN pa.POBox = 1
	THEN pa.AddrSupplement
	ELSE NULL
END AS AddrSupplement,
pa.CountryCode AS AddrCountryCode,
pa.State AS AddrState,
pa.FullAddress AS AddrFull,
pb.NogaCode2008,
atd.FatcaStatusNo,
atd.Tin
FROM AiTaxStatus at
INNER JOIN AiTaxDetailFatca atd ON atd.TaxStatusId = at.Id AND atd.HdVersionNo < 999999999
INNER JOIN AiTaxFatcaStatus fs ON fs.StatusNo = atd.FatcaStatusNo AND fs.PartnerTypeNo IN(1,2)
INNER JOIN PtBase pb ON pb.Id = at.PartnerId AND (pb.TerminationDate >= @periodStartDate OR pb.TerminationDate IS NULL)
INNER JOIN PtAddress pa ON pa.PartnerId = pb.Id AND pa.AddressTypeNo = 11 AND pa.HdVersionNo < 999999999
LEFT OUTER JOIN		
	(
		SELECT
		   DISTINCT  
			STUFF((
				SELECT ';' + nat.CountryCode
				FROM PtNationality nat
				WHERE nat.PartnerId = base.Id
				AND nat.HdVersionNo < 999999999
				FOR XML PATH('')
			), 1, 1, '') AS Nationalities,
			base.Id
		  FROM PtBase base
	) nat ON nat.Id = pb.Id
WHERE 
pb.HdVersionNo < 999999999
AND at.HdVersionNo < 999999999
AND at.TaxProgramNo = @taxProgramNo
AND at.ValidFrom < @reportDate
AND (at.ValidTo >= @ReportDate OR at.ValidTo IS NULL)
) data;


SELECT * 
INTO #FatcaAccountData
FROM(
SELECT 
DISTINCT
NEWID() AS AiAccountId,
'Konto' AS Typ,
0 AS Mitinhaber,
fbd.AiPartnerId,
ab.AccountNoIbanForm AS AccountNo,
ab.Id AS AccountId,
ab.TerminationDate AS AccountClosed,
ISNULL(vap.PriceCurrency,ref.Currency) AS Currency,
ISNULL(vap.MarketValuePrCu,0) AS Balance,
vap.ProdReferenceId as VAPID
FROM #FatcaPartnerData fbd
INNER JOIN PtPortfolio pr ON pr.PartnerId = fbd.InhaberMitinhaberId AND pr.HdVersionNo < 999999999
INNER JOIN PtAccountBase ab ON ab.PortfolioId = pr.Id AND (ab.TerminationDate > @periodStartDate OR ab.TerminationDate IS NULL) AND ab.OpeningDate <= @reportDate AND ab.HdVersionNo < 999999999
INNER JOIN PrReference ref ON ref.AccountId = ab.Id AND ref.HdVersionNo < 999999999
INNER JOIN PrPrivate pvt ON pvt.ProductId = ref.ProductId AND pvt.IsAiaRelevant = 1 AND pvt.HdVersionNo < 999999999
LEFT OUTER JOIN VaPrivateView vap on vap.ProdReferenceId = ref.Id and vap.VaRunId = @VaRunId

UNION
SELECT 
DISTINCT
NEWID() AS AiAccountId,
'Portfolio' AS Typ,
0 AS Mitinhaber,
fbd.AiPartnerId,
pr.PortfolioNoEdited AS AccountNo,
pr.Id AS PortfolioId,
pr.TerminationDate AS AccountClosed,
ISNULL(vpw.PortfolioCurrency, pr.Currency) AS Currency,
ISNULL(vpw.PortfolioValue, 0) AS Balance,
vpw.PortfolioId as VAPID
FROM #FatcaPartnerData fbd
INNER JOIN PtPortfolio pr ON pr.PartnerId = fbd.InhaberMitinhaberId AND pr.HdVersionNo < 999999999 --AND pr.PortfolioTypeNo <> 5000 -- removed (TSH 2025-07-15)
	AND (pr.TerminationDate > @periodStartDate OR pr.TerminationDate IS NULL)
	AND pr.OpeningDate <= @reportDate
INNER JOIN PtPortfolioType pt on pr.PortfolioTypeNo = pt.PortfolioTypeNo and pt.IsAiaRelevant = 1 -- Just IsAiaRelevant Portfolios (TSH 2025-07-15)
OUTER APPLY

        (SELECT PortfolioId, ValuationCurrency As PortfolioCurrency, SUM(MarketValueVaCu) As PortfolioValue
         FROM VaPublicView  
         WHERE PortfolioId = pr.Id
            AND VaRunId = @VaRunId
         GROUP BY PortfolioId, ValuationCurrency
         ) vpw

UNION
SELECT 
DISTINCT
NEWID() AS AiAccountId,
'Konto' AS Typ,
1 AS Mitinhaber,
fbd.AiPartnerId,
ab.AccountNoIbanForm AS AccountNo,
ab.Id AS AccountId,
ab.TerminationDate AS AccountClosed,
ISNULL(vap.PriceCurrency,ref.Currency) AS Currency,
ISNULL(vap.MarketValuePrCu,0) AS Balance,
vap.ProdReferenceId as VAPID
FROM #FatcaPartnerData fbd
INNER JOIN PtRelationSlave prs ON prs.PartnerId = fbd.InhaberMitinhaberId AND prs.RelationRoleNo IN (6,18, 63) AND (prs.ValidTo > @periodStartDate OR prs.ValidTo IS NULL) AND prs.HdVersionNo < 999999999 
INNER JOIN PtRelationMaster prm ON prm.Id = prs.MasterId AND prm.RelationTypeNo = 10 AND prm.HdVersionNo < 999999999
INNER JOIN PtPortfolio pr ON pr.PartnerId = prm.PartnerId AND pr.HdVersionNo < 999999999
INNER JOIN PtAccountBase ab ON ab.PortfolioId = pr.Id AND (ab.TerminationDate > @periodStartDate OR ab.TerminationDate IS NULL) AND ab.OpeningDate <= @reportDate AND ab.HdVersionNo < 999999999
INNER JOIN PrReference ref ON ref.AccountId = ab.Id AND ref.HdVersionNo < 999999999
INNER JOIN PrPrivate pvt ON pvt.ProductId = ref.ProductId AND pvt.IsAiaRelevant = 1 AND pvt.HdVersionNo < 999999999
LEFT OUTER JOIN VaPrivateView vap on vap.ProdReferenceId = ref.Id and vap.VaRunId = @VaRunId
WHERE fbd.NogaCode2008 = '970000'

UNION
SELECT 
DISTINCT
NEWID() AS AiAccountId,
'Portfolio' AS Typ,
1 AS Mitinhaber,
fbd.AiPartnerId,
pr.PortfolioNoEdited AS AccountNo,
pr.Id AS PortfolioId,
pr.TerminationDate AS AccountClosed,
ISNULL(vpw.PortfolioCurrency, pr.Currency) AS Currency,
ISNULL(vpw.PortfolioValue, 0) AS Balance,
vpw.PortfolioId as VAPID
FROM #FatcaPartnerData fbd
INNER JOIN PtRelationSlave prs ON prs.PartnerId = fbd.InhaberMitinhaberId AND prs.RelationRoleNo IN (6,18, 63) AND (prs.ValidTo > @periodStartDate OR prs.ValidTo IS NULL) AND prs.HdVersionNo < 999999999
INNER JOIN PtRelationMaster prm ON prm.Id = prs.MasterId AND prm.RelationTypeNo = 10 AND prm.HdVersionNo < 999999999
INNER JOIN PtPortfolio pr ON pr.PartnerId = prm.PartnerId AND pr.HdVersionNo < 999999999 --AND pr.PortfolioTypeNo <> 5000 -- removed (TSH 2025-07-15)
	AND (pr.TerminationDate > @periodStartDate OR pr.TerminationDate IS NULL)
	AND pr.OpeningDate <= @reportDate
INNER JOIN PtPortfolioType pt on pr.PortfolioTypeNo = pt.PortfolioTypeNo and pt.IsAiaRelevant = 1 -- Just IsAiaRelevant Portfolios (TSH 2025-07-15)
OUTER APPLY

        (SELECT PortfolioId, ValuationCurrency As PortfolioCurrency, SUM(MarketValueVaCu) As PortfolioValue
         FROM VaPublicView  
         WHERE PortfolioId = pr.Id
            AND VaRunId = @VaRunId
         GROUP BY PortfolioId, ValuationCurrency
         ) vpw
WHERE fbd.NogaCode2008 = '970000'
) accounts;


SELECT * 
INTO #FatcaSubOwnerData
FROM(
SELECT 
DISTINCT
'Konto' AS Typ,
1 AS Mitinhaber,
fbd.AiPartnerId AS EntityPartnerId,
fbd2.AiPartnerId,
tra.AiAccountId AS TaxReportAccountId
FROM #FatcaPartnerData fbd
INNER JOIN PtRelationMaster prm ON prm.PartnerId = fbd.InhaberMitinhaberId 
AND fbd.FatcaStatusNo IN (
SELECT StatusNo 
FROM AiTaxFatcaStatus fs
WHERE fs.PartnerTypeNo IN (2))
AND prm.RelationTypeNo = 60 AND prm.HdVersionNo < 999999999
INNER JOIN PtRelationSlave prs ON prs.MasterId = prm.Id AND (prs.ValidTo > @periodStartDate OR prs.ValidTo IS NULL) AND prs.HdVersionNo < 999999999 
INNER JOIN #FatcaPartnerData fbd2 ON fbd2.InhaberMitinhaberId = prs.PartnerId
INNER JOIN PtPortfolio pr ON pr.PartnerId = prm.PartnerId AND pr.HdVersionNo < 999999999
INNER JOIN PtAccountBase ab ON ab.PortfolioId = pr.Id AND (ab.TerminationDate > @periodStartDate OR ab.TerminationDate IS NULL) AND ab.OpeningDate <= @reportDate AND ab.HdVersionNo < 999999999
INNER JOIN PrReference ref ON ref.AccountId = ab.Id AND ref.HdVersionNo < 999999999 -- Added because then it's the same like the two other 'Konto' typ here in this code (TSH 2025-07-15)
INNER JOIN PrPrivate pvt ON pvt.ProductId = ref.ProductId AND pvt.IsAiaRelevant = 1 AND pvt.HdVersionNo < 999999999 -- Added because then it's the same like the two other 'Konto' types here in this code (TSH 2025-07-15)
LEFT OUTER JOIN #FatcaAccountData tra ON tra.AccountId = ab.Id AND tra.AiPartnerId = fbd.AiPartnerId
WHERE fbd.NogaCode2008 = '970000'

UNION
SELECT 
DISTINCT
'Portfolio' AS Typ,
1 AS Mitinhaber,
fbd.AiPartnerId AS EntityPartnerId,
fbd2.AiPartnerId,
tra.AiAccountId AS TaxReportAccountId
FROM #FatcaPartnerData fbd
INNER JOIN PtRelationMaster prm ON prm.PartnerId = fbd.InhaberMitinhaberId 
AND fbd.FatcaStatusNo IN (
SELECT StatusNo 
FROM AiTaxFatcaStatus fs
WHERE fs.PartnerTypeNo IN (2))
AND prm.RelationTypeNo = 60 AND prm.HdVersionNo < 999999999
INNER JOIN PtRelationSlave prs ON prs.MasterId = prm.Id AND (prs.ValidTo > @periodStartDate OR prs.ValidTo IS NULL) AND prs.HdVersionNo < 999999999 
INNER JOIN #FatcaPartnerData fbd2 ON fbd2.InhaberMitinhaberId = prs.PartnerId
INNER JOIN PtPortfolio pr ON pr.PartnerId = prm.PartnerId AND pr.HdVersionNo < 999999999 --AND pr.PortfolioTypeNo <> 5000 -- removed (TSH 2025-07-15)
	AND (pr.TerminationDate > @periodStartDate OR pr.TerminationDate IS NULL)
	AND pr.OpeningDate <= @reportDate
INNER JOIN PtPortfolioType pt on pr.PortfolioTypeNo = pt.PortfolioTypeNo and pt.IsAiaRelevant = 1 -- Just IsAiaRelevant Portfolios (TSH 2025-07-15)
LEFT OUTER JOIN #FatcaAccountData tra ON tra.AccountId = pr.Id AND tra.AiPartnerId = fbd.AiPartnerId
WHERE fbd.NogaCode2008 = '970000'
) data;


SELECT * 
INTO #FatcaPaymentData
FROM(
SELECT 
fad.AiAccountId,
fad.AccountNo,
1 AS PaymentTypeNo,
ref.Currency,
SUM(trItem.CreditAmount) AS SumAmount
FROM #FatcaAccountData fad
JOIN PrReference ref ON ref.AccountId = fad.AccountId
JOIN PtPosition pos ON pos.ProdReferenceId = ref.Id
JOIN PtTransItem trItem ON pos.Id = trItem.PositionId AND trItem.HdVersionNo BETWEEN 1 AND 999999998
WHERE fad.Typ = 'Konto'
AND trItem.TextNo = @TextNoCreditInterest  -- Interest Payment
AND YEAR(trItem.TransDate) = YEAR(@reportDate)
AND trItem.CreditAmount > 0 -- Credit interest (Haben-Zins)
GROUP BY fad.AiAccountId, fad.AccountNo, ref.AccountId, ref.Currency

UNION
SELECT 
fad.AiAccountId,
fad.AccountNo,
CASE isv.IncomeTypeNo 
	WHEN 1 THEN 1
	WHEN 2 THEN 2
	WHEN 3 THEN 2
	WHEN 8 THEN 2
	WHEN 9 THEN 4
END AS PaymentTypeNo,
isv.PaymentCurrency AS Currency,
SUM(isv.TaxableAmountPyCu) AS SumAmount
FROM #FatcaAccountData fad
JOIN PtPositionIncomeView isv ON fad.AccountId = isv.PortfolioID
WHERE fad.Typ = 'Portfolio'
AND isv.IncomeTypeNo IN (1, 2, 3, 8, 9) -- Zinsen, Dividenden, NwRe, KapRück, Retro
AND isv.CancelDate IS NULL
AND YEAR(isv.PaymentValueDate) = YEAR(@reportDate)
AND isv.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY fad.AiAccountId, fad.AccountNo, isv.PortfolioID, (CASE isv.IncomeTypeNo 
	WHEN 1 THEN 1
	WHEN 2 THEN 2
	WHEN 3 THEN 2
	WHEN 8 THEN 2
	WHEN 9 THEN 4
END), isv.PaymentCurrency

UNION
SELECT 	 AiAccountId, AccountNo
	,PaymentTypeNo = 3
	,Currency, FATCA503=SUM(FATCA503)
FROM
(
	SELECT	
		fad.AiAccountId, fad.AccountNo
		,ptm.CreditAccountCurrency
		,Currency = ptm.PaymentCurrency
		,FATCA503=ptm.PaymentAmount
		,ptm.CreditPortfolioNo --, PP.PortfolioNo
		,ptm.DebitPortfolioNo
		,PTa.TransTypeNo
	FROM	#FatcaAccountData fad
		JOIN PtTransMessage ptm ON fad.AccountId = ptm.DebitPortfolioId 
			AND fad.Typ = 'Portfolio' 
		LEFT JOIN PtTransaction PTa ON ptm.TransactionId = PTa.Id	
					and YEAR(PTa.transdate) = YEAR(@reportDate)
		LEFT JOIN PtTransType ptt ON ptt.TransTypeNo = PTa.TransTypeNo
		LEFT JOIN PtPositionIncome ppi ON ppi.TransMessageId = ptm.Id
	WHERE  PTa.TransTypeNo IN (SELECT TransTypeNo FROM @TransTypeNo_inclTrans)
		AND (PPI.IncomeTypeNo NOT IN (1, 2, 3, 8, 9) OR PPI.IncomeTypeNo IS NULL)
		and isnull(ptm.TransMsgStatusNo, 3) = 3 -- removing stornos and cancellations and leaving either the original or rectificate
) fin
GROUP BY AiAccountId, AccountNo, Currency
) payments;


INSERT INTO AiTaxReportPartner (Id, HdCreator, HdChangeUser, HdVersionNo, TaxReportId, PartnerTypeNo, PartnerId, PartnerNoEdited, FiscalCountries, Tin, Title, Name, FirstName, MiddleName, NameCont, AddrZip, AddrTown, AddrStreet, AddrHouseNo, AddrPOBox, AddrCountryCode, AddrState, AddrFull, Nationalities, DateOfBirth, StatusNo, AcctHolderTypeNo, RefTaxReportPartnerId)
SELECT AiPartnerId, SUSER_NAME(), SUSER_NAME(), 1, @taxReportId, PartnerTypeNo, InhaberMitinhaberId, InhaberMitinhaberNo, FiscalCountries, Tin, Title, Name, FirstName, MiddleName, NameCont, AddrZip, AddrTown, AddrStreet, AddrHouseNo, AddrSupplement, AddrCountryCode, AddrState, AddrFull, Nationalities, DateOfBirth, 1, null, null
FROM #FatcaPartnerData fbd
WHERE -- this complete WHERE condition is new (TSH 2025-07-23)
EXISTS (SELECT * FROM #FatcaAccountData acc WHERE acc.AiPartnerId = fbd.AiPartnerId )  
OR
EXISTS (SELECT * FROM PtRelationSlave rs INNER JOIN PtRelationMaster rm ON rs.MasterId = rm.Id WHERE rs.PartnerId = fbd.InhaberMitinhaberId AND rm.PartnerId IN(select InhaberMitinhaberId from #FatcaPartnerData) AND rm.RelationTypeNo IN(20,70) AND rm.HdVersionNo < 999999999 AND rs.HdVersionNo < 999999999) 

INSERT INTO AiTaxReportAccount (Id, HdCreator, HdChangeUser, HdVersionNo, TaxReportId, AccountNo, AccountHolder, Currency, Balance, AccountClosed, StatusNo)
SELECT AiAccountId, SUSER_NAME(), SUSER_NAME(), 1, @taxReportId, AccountNo, AiPartnerId, Currency, Balance, AccountClosed, 1
FROM #FatcaAccountData;

INSERT INTO AiTaxReportSubstantialOwner(HdVersionNo, HdCreator, HdChangeUser, TaxReportAccountId, TaxReportPartnerId, StatusNo) 
SELECT 1, SUSER_NAME(), SUSER_NAME(), TaxReportAccountId, AiPartnerId, 1
FROM #FatcaSubOwnerData;

INSERT INTO AiTaxReportPayment (HdCreator, HdChangeUser, HdVersionNo, TaxReportAccountId, PaymentTypeNo, Currency, Amount, StatusNo)
SELECT SUSER_NAME(), SUSER_NAME(), 1, AiAccountId, PaymentTypeNo, Currency, SumAmount, 1
FROM #FatcaPaymentData;

UPDATE AiTaxReport SET ReportStatusNo = 2 WHERE Id = @taxReportId;

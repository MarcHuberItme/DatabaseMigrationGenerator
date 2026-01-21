--liquibase formatted sql

--changeset system:create-alter-procedure-RptETPBelehnungKapBu context:any labels:c-any,o-stored-procedure,ot-schema,on-RptETPBelehnungKapBu,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RptETPBelehnungKapBu
CREATE OR ALTER PROCEDURE dbo.RptETPBelehnungKapBu
@AcctPeriod int

AS

--DECLARE @AcctPeriod int
DECLARE @PrevAcctPeriod int
DECLARE @DateFrom DATETIME
DECLARE @DateTo DATETIME

DECLARE @NEU_ETP_PH decimal(15,4)			
DECLARE @NEU_ETP_UK decimal(15,4)
DECLARE @NEU_ETP_Tot decimal(15,4)
DECLARE @NEU_Ueb_PH decimal(15,4)
DECLARE @NEU_Ueb_UK decimal(15,4)
DECLARE @NEU_Ueb_Tot decimal(15,4)
DECLARE @NEU_PH_Tot decimal(15,4)
DECLARE @NEU_UK_Tot decimal(15,4)
DECLARE @NEU_Tot decimal(15,4)

DECLARE @NEU_ETP_PH_P decimal(10,4)
DECLARE @NEU_ETP_UK_P decimal(10,4)
DECLARE @NEU_Ueb_PH_P decimal(10,4)
DECLARE @NEU_Ueb_UK_P decimal(10,4)
DECLARE @NEU_ETP_Tot_P decimal(10,4)
DECLARE @NEU_Ueb_Tot_P decimal(10,4)
DECLARE @NEU_PH_Tot_P decimal(10,4)
DECLARE @NEU_UK_Tot_P decimal(10,4)
DECLARE @NEU_Tot_P decimal(10,4)

DECLARE @RZ_ETP_PH decimal(15,4)
DECLARE @RZ_ETP_UK decimal(15,4)
DECLARE @RZ_ETP_Tot decimal(15,4)
DECLARE @RZ_Ueb_PH decimal(15,4)
DECLARE @RZ_Ueb_UK decimal(15,4)
DECLARE @RZ_Ueb_Tot decimal(15,4)
DECLARE @RZ_PH_Tot decimal(15,4)
DECLARE @RZ_UK_Tot decimal(15,4)
DECLARE @RZ_Tot decimal(15,4)

DECLARE @RZ_ETP_PH_P decimal(10,4)
DECLARE @RZ_ETP_UK_P decimal(10,4)
DECLARE @RZ_Ueb_PH_P decimal(10,4)
DECLARE @RZ_Ueb_UK_P decimal(10,4)
DECLARE @RZ_ETP_Tot_P decimal(10,4)
DECLARE @RZ_Ueb_Tot_P decimal(10,4)
DECLARE @RZ_PH_Tot_P decimal(10,4)
DECLARE @RZ_UK_Tot_P decimal(10,4)
DECLARE @RZ_Tot_P decimal(10,4)

DECLARE @Pt_ETP_PH int
DECLARE @Pt_ETP_UK int
DECLARE @Pt_ETP_Tot int
DECLARE @Pt_Ueb_PH int
DECLARE @Pt_Ueb_UK int
DECLARE @Pt_Ueb_Tot int
DECLARE @Pt_PH_Tot int
DECLARE @Pt_UK_Tot int
DECLARE @Pt_Tot int

DECLARE @Pt_ETP_PH_P decimal(10,4)
DECLARE @Pt_ETP_UK_P decimal(10,4)
DECLARE @Pt_Ueb_PH_P decimal(10,4)
DECLARE @Pt_Ueb_UK_P decimal(10,4)
DECLARE @Pt_ETP_Tot_P decimal(10,4)
DECLARE @Pt_Ueb_Tot_P decimal(10,4)
DECLARE @Pt_PH_Tot_P decimal(10,4)
DECLARE @Pt_UK_Tot_P decimal(10,4)
DECLARE @Pt_Tot_P decimal(10,4)

DECLARE @Pt2_ETP_PH int
DECLARE @Pt2_ETP_UK int
DECLARE @Pt2_ETP_Tot int
DECLARE @Pt2_Ueb_PH int
DECLARE @Pt2_Ueb_UK int
DECLARE @Pt2_Ueb_Tot int
DECLARE @Pt2_PH_Tot int
DECLARE @Pt2_UK_Tot int
DECLARE @Pt2_Tot int

DECLARE @Pt2_ETP_PH_P decimal(10,4)
DECLARE @Pt2_ETP_UK_P decimal(10,4)
DECLARE @Pt2_Ueb_PH_P decimal(10,4)
DECLARE @Pt2_Ueb_UK_P decimal(10,4)
DECLARE @Pt2_ETP_Tot_P decimal(10,4)
DECLARE @Pt2_Ueb_Tot_P decimal(10,4)
DECLARE @Pt2_PH_Tot_P decimal(10,4)
DECLARE @Pt2_UK_Tot_P decimal(10,4)
DECLARE @Pt2_Tot_P decimal(10,4)



/* ersetzt Jan.2013/dbe
--SET @AcctPeriod = 201212
SET @PrevAcctPeriod = (CAST(LEFT(LTRIM(STR(@AcctPeriod)),4) AS int) - 1) * 100 + CAST(RIGHT(RTRIM(STR(@AcctPeriod)),2) AS int) 
SET @DateFrom = DATEADD(month,1,(Str(@PrevAcctPeriod) + '01'))	
SET @DateTo = DATEADD(year,1,@DateFrom)	- 0.000001
--SELECT @AcctPeriod As AcctPeriod, @PrevAcctPeriod As PrevAcctPeriod, @DateFrom As DateFrom, @DateTo As DateTo
*/

/*ersetzt Sept. 2014
--neu: DateFrom fix 1.Januar / in StoredProcedure geändert am 8.1.13 dbe
SET @AcctPeriod = 201309
--SET @AcctPeriod = {?AcctPeriod}
SET @PrevAcctPeriod = ((@AcctPeriod / 100) -1) * 100 + 12					-- Immer Dezember des Vorjahres
SET @DateFrom = DATEADD(day,1,(Str(@PrevAcctPeriod) + '31'))					-- Buchungen Ende Jahr bis aktueller Monat
SET @DateTo = DATEADD(month,1,Str(@AcctPeriod) + '01') - 0.000001				-- year-mm-dd 23:59:59.917 (Datum Stichtag)
 --SELECT @AcctPeriod AS AcctPeriod, @PrevAcctPeriod AS PrevAcctPeriod, @DateFrom As DateFrom, @DateTo As DateTo
*/


--neu 15.09.2014: DateFrom fix 1.Tag des Quartals, DateTo fix letzter Tag des Quartals / in StoredProcedure geändert am 15.09.2014 / dbe
--     wenn Report erst im neuen Monat ausgeführt wird z.B. am Jahresende, dann erster und letzter Tag des letzten Quartals
--SET @AcctPeriod = 201409
--SET @AcctPeriod = {?AcctPeriod}
SET @PrevAcctPeriod = @AcctPeriod -2    -- Beispiel: Akt.Periode = März, dann 201401 bis 201403
SET @DateFrom = CASE WHEN Month(GETDATE()) in (3,6,9,12)THEN DATEADD(qq,DATEDIFF(qq,0,GETDATE()),0)     --FirstDayOfQuarter
                     else DATEADD(qq,DATEDIFF(qq,0,GETDATE())-1,0) END                                  --FirstDayOfLastQuarter

SET @DateTo =	CASE WHEN Month(GETDATE()) in (3,6,9,12)THEN DATEADD(qq,DATEDIFF(qq,0,GETDATE())+1,-1)  --LastDayOfQuarter	
                     else DATEADD(qq,DATEDIFF(qq,0,GETDATE()),-1) END 		                            --LastDayOfLastQuarter


-- Get all bookings in period, sum per AccountNo, ValueDate 
SELECT pab.AccountNo, pab.AccountNoEdited, ISNULL(pab.CustomerReference,'') As CustRef
		, prr.Currency As Whg
		, prp.ProductNo, ast2.TextShort As Product, pti.ValueDate
		, SUM(pti.DebitAmount) As DebitAmount, SUM(pti.CreditAmount) As CreditAmount
		, pos.Id As PositionId, pab.Id As AccountId, pb.Id As PartnerId
		, @AcctPeriod As AcctPeriod, @PrevAcctPeriod As PrevAcctPeriod
		, @DateFrom As DateFrom, @DateTo As DateTo

INTO #Bookings
--DROP TABLE #Bookings

FROM PtTransItem pti 
INNER JOIN PtPosition pos 			ON pti.PositionId = pos.Id
INNER JOIN PrReference prr 			ON pos.ProdReferenceId = prr.Id
INNER JOIN PtAccountBase pab		ON prr.AccountId = pab.Id
INNER JOIN PrPrivate prp			ON prr.ProductId = prp.ProductId
INNER JOIN AsText ast2				ON prp.Id = ast2.Masterid AND ast2.LanguageNo = 2

INNER JOIN PtPortfolio pf			ON pab.PortfolioId = pf.Id
INNER JOIN PtBase pb				ON pf.PartnerId = pb.Id

WHERE prp.ProductNo in(3001, 3002, 3003, 3004, 3005, 3006, 3007, 3008, 3009, 3010, 3040, 3044)
AND pti.TransDate >= @DateFrom AND pti.TransDate <= @DateTo
--AND pti.ValueDate >= @DateFrom AND pti.ValueDate <= @DateTo
AND pti.IsDueRelevant = 0
AND pti.IsClosingItem = 0
AND Pti.TextNo <> 73  
AND Pti.TextNo <> 93 
AND Pti.HdVersionNo between 1 and 999999998
GROUP BY pab.AccountNo, pab.AccountNoEdited, pab.CustomerReference, prr.Currency,prp.ProductNo
		, ast2.TextShort, pti.ValueDate, pos.Id, pab.Id, pb.Id
HAVING (SUM(pti.DebitAmount) - SUM(pti.CreditAmount) <> 0)
AND (SUM(pti.DebitAmount) + SUM(pti.CreditAmount) <> 0)
ORDER BY pab.AccountNo, pti.ValueDate


-- Betroffene Hypos ermitteln
SELECT DISTINCT PositionId, AccountId, PartnerId, 'ETP' = 0, 'Noga' = '' 
INTO #Positions 
FROM #Bookings 
ORDER BY PositionId


-- ETP-Positionen (mit ComptType 3007, 3057, 8965 oder 123567) markieren
UPDATE #Positions
SET ETP = 1
FROM #Positions AS pos
INNER JOIN AcCompression2 ac2 ON ac2.PositionId = pos.PositionId 
WHERE SubString(ac2.KeyString, 149, 7) <> '???????'
AND CAST(SubString(ac2.KeyString, 149, 7) AS int) IN (3007,3057,8965,123567)
AND ac2.AccountancyPeriod BETWEEN @PrevAcctPeriod AND @AcctPeriod



-- Noga (Private Haushalte oder Übrige Kunden) updaten
UPDATE #Positions
SET Noga = a.Noga
FROM #Positions AS pos
LEFT JOIN (	
	SELECT pos.PositionId, 'Noga' = CASE WHEN pb.NogaCode2008 = '970000' THEN 'P' ELSE 'U' END
	FROM #Positions pos
	INNER JOIN PtPosition pp ON pos.PositionId = pp.Id
	INNER JOIN PtPortfolio pf ON pp.PortfolioId = pf.Id
	INNER JOIN PtBase pb ON pf.PartnerId = pb.Id
		) a ON pos.PositionId = a.PositionId

-- Korrektur/DMO
Update #Positions 
Set  Noga = Case When (isnull(pb.NogaCode2008, '900000')) = 970000 Then 'P' Else 'U' END
From #Positions AS pos
join PtBase PB on POS.PartnerID = PB.Id

SELECT p.PositionId, p.PartnerId, 'Art' = 'Neugeschäfte'
		, p.ETP, p.Noga
		, 'ETP_Text' = CASE WHEN p.ETP = 0 THEN 'Übrige Kunden' ELSE 'ETP-Kunden' END
		, 'Private_Haushalte' = CASE WHEN p.Noga = 'P' THEN b.DebitAmount ELSE 0 END
		, 'Übrige_Kunden'     = CASE WHEN p.Noga = 'U' THEN b.DebitAmount ELSE 0 END
INTO #Book2
FROM #Bookings b
INNER JOIN #Positions p ON b.PositionId = p.PositionId
WHERE b.DebitAmount <> 0


SELECT p.PositionId, p.PartnerId, 'Art' = 'Rückzahlungen und Amortisationen'
		, p.ETP, p.Noga
		, 'ETP_Text' = CASE WHEN p.ETP = 0 THEN 'Übrige Kunden' ELSE 'ETP-Kunden' END
		, 'Private_Haushalte' = CASE WHEN p.Noga = 'P' THEN b.CreditAmount ELSE 0 END
		, 'Übrige_Kunden'     = CASE WHEN p.Noga = 'U' THEN b.CreditAmount ELSE 0 END
INTO #Book3
FROM #Bookings b
INNER JOIN #Positions p ON b.PositionId = p.PositionId
WHERE b.CreditAmount <> 0


SELECT @NEU_ETP_PH = SUM(Private_Haushalte) FROM #Book2 WHERE ETP = 1
SELECT @NEU_ETP_UK = SUM(Übrige_Kunden) FROM #Book2 WHERE ETP = 1
SET @NEU_ETP_Tot = @NEU_ETP_PH + @NEU_ETP_UK

SELECT @NEU_Ueb_PH = SUM(Private_Haushalte) FROM #Book2 WHERE ETP = 0
SELECT @NEU_Ueb_UK = SUM(Übrige_Kunden) FROM #Book2 WHERE ETP = 0
SET @NEU_Ueb_Tot = @NEU_Ueb_PH + @NEU_Ueb_UK

SET @NEU_PH_Tot = @NEU_ETP_PH + @NEU_Ueb_PH
SET @NEU_UK_Tot = @NEU_ETP_UK + @NEU_Ueb_UK
SET @NEU_Tot = @NEU_PH_Tot + @NEU_UK_Tot

SET @NEU_ETP_PH_P = @NEU_ETP_PH / @NEU_PH_Tot * 100
SET @NEU_Ueb_PH_P = @NEU_Ueb_PH / @NEU_PH_Tot * 100
SET @NEU_ETP_UK_P = @NEU_ETP_UK / @NEU_UK_Tot * 100
SET @NEU_Ueb_UK_P = @NEU_Ueb_UK / @NEU_UK_Tot * 100
SET @NEU_PH_Tot_P = @NEU_ETP_PH_P + @NEU_Ueb_PH_P
SET @NEU_UK_Tot_P = @NEU_ETP_UK_P + @NEU_Ueb_UK_P
SET @NEU_ETP_Tot_P = @NEU_ETP_Tot / @Neu_Tot * 100 
SET @NEU_Ueb_Tot_P = @NEU_Ueb_Tot / @Neu_Tot * 100 
SET @Neu_Tot_P = @NEU_ETP_Tot_P + @NEU_Ueb_Tot_P


SELECT @RZ_ETP_PH = SUM(Private_Haushalte) FROM #Book3 WHERE ETP = 1
SELECT @RZ_ETP_UK = SUM(Übrige_Kunden) FROM #Book3 WHERE ETP = 1
SET @RZ_ETP_Tot = @RZ_ETP_PH + @RZ_ETP_UK

SELECT @RZ_Ueb_PH = SUM(Private_Haushalte) FROM #Book3 WHERE ETP = 0
SELECT @RZ_Ueb_UK = SUM(Übrige_Kunden) FROM #Book3 WHERE ETP = 0
SET @RZ_Ueb_Tot = @RZ_Ueb_PH + @RZ_Ueb_UK

SET @RZ_PH_Tot = @RZ_ETP_PH + @RZ_Ueb_PH
SET @RZ_UK_Tot = @RZ_ETP_UK + @RZ_Ueb_UK
SET @RZ_Tot = @RZ_PH_Tot + @RZ_UK_Tot

SET @RZ_ETP_PH_P = @RZ_ETP_PH / @RZ_PH_Tot * 100
SET @RZ_Ueb_PH_P = @RZ_Ueb_PH / @RZ_PH_Tot * 100
SET @RZ_ETP_UK_P = @RZ_ETP_UK / @RZ_UK_Tot * 100
SET @RZ_Ueb_UK_P = @RZ_Ueb_UK / @RZ_UK_Tot * 100
SET @RZ_PH_Tot_P = @RZ_ETP_PH_P + @RZ_Ueb_PH_P
SET @RZ_UK_Tot_P = @RZ_ETP_UK_P + @RZ_Ueb_UK_P
SET @RZ_ETP_Tot_P = @RZ_ETP_Tot / @RZ_Tot * 100 
SET @RZ_Ueb_Tot_P = @RZ_Ueb_Tot / @RZ_Tot * 100 
SET @RZ_Tot_P = @RZ_ETP_Tot_P + @RZ_Ueb_Tot_P



SELECT @Pt_ETP_PH = COUNT(DISTINCT PartnerId) FROM #Book2 WHERE (ETP = 1 AND Noga = 'P')
SELECT @Pt_ETP_UK = COUNT(DISTINCT PartnerId) FROM #Book2 WHERE (ETP = 1 AND Noga = 'U')
SET @Pt_ETP_Tot = @Pt_ETP_PH + @Pt_ETP_UK

SELECT @Pt_Ueb_PH = COUNT(DISTINCT PartnerId) FROM #Book2 WHERE (ETP = 0 AND Noga = 'P')
SELECT @Pt_Ueb_UK = COUNT(DISTINCT PartnerId) FROM #Book2 WHERE (ETP = 0 AND Noga = 'U')
SET @Pt_Ueb_Tot = @Pt_Ueb_PH + @Pt_Ueb_UK


SET @Pt_PH_Tot = @Pt_ETP_PH + @Pt_Ueb_PH
SET @Pt_UK_Tot = @Pt_ETP_UK + @Pt_Ueb_UK
SET @Pt_Tot = @Pt_PH_Tot + @Pt_UK_Tot

SET @Pt_ETP_PH_P = CAST(@Pt_ETP_PH as decimal(10,4)) / CAST(@Pt_PH_Tot as decimal(10,4)) * 100
SET @Pt_Ueb_PH_P = CAST(@Pt_Ueb_PH as decimal(10,4)) / CAST(@Pt_PH_Tot as decimal(10,4)) * 100
SET @Pt_ETP_UK_P = CAST(@Pt_ETP_UK as decimal(10,4)) / CAST(@Pt_UK_Tot as decimal(10,4)) * 100
SET @Pt_Ueb_UK_P = CAST(@Pt_Ueb_UK as decimal(10,4)) / CAST(@Pt_UK_Tot as decimal(10,4)) * 100
SET @Pt_PH_Tot_P = @Pt_ETP_PH_P + @Pt_Ueb_PH_P
SET @Pt_UK_Tot_P = @Pt_ETP_UK_P + @Pt_Ueb_UK_P
SET @Pt_ETP_Tot_P = CAST(@Pt_ETP_Tot as decimal(10,4)) / CAST(@Pt_Tot as decimal(10,4)) * 100 
SET @Pt_Ueb_Tot_P = CAST(@Pt_Ueb_Tot as decimal(10,4)) / CAST(@Pt_Tot as decimal(10,4)) * 100 
SET @Pt_Tot_P = @Pt_ETP_Tot_P + @Pt_Ueb_Tot_P



SELECT @Pt2_ETP_PH = COUNT(DISTINCT PartnerId) FROM #Book3 WHERE (ETP = 1 AND Noga = 'P')
SELECT @Pt2_ETP_UK = COUNT(DISTINCT PartnerId) FROM #Book3 WHERE (ETP = 1 AND Noga = 'U')
SET @Pt2_ETP_Tot = @Pt2_ETP_PH + @Pt2_ETP_UK

SELECT @Pt2_Ueb_PH = COUNT(DISTINCT PartnerId) FROM #Book3 WHERE (ETP = 0 AND Noga = 'P')
SELECT @Pt2_Ueb_UK = COUNT(DISTINCT PartnerId) FROM #Book3 WHERE (ETP = 0 AND Noga = 'U')
SET @Pt2_Ueb_Tot = @Pt2_Ueb_PH + @Pt2_Ueb_UK

SET @Pt2_PH_Tot = @Pt2_ETP_PH + @Pt2_Ueb_PH
SET @Pt2_UK_Tot = @Pt2_ETP_UK + @Pt2_Ueb_UK
SET @Pt2_Tot = @Pt2_PH_Tot + @Pt2_UK_Tot

SET @Pt2_ETP_PH_P = CAST(@Pt2_ETP_PH as decimal(10,4)) / CAST(@Pt2_PH_Tot as decimal(10,4)) * 100
SET @Pt2_Ueb_PH_P = CAST(@Pt2_Ueb_PH as decimal(10,4)) / CAST(@Pt2_PH_Tot as decimal(10,4)) * 100
SET @Pt2_ETP_UK_P = CAST(@Pt2_ETP_UK as decimal(10,4)) / CAST(@Pt2_UK_Tot as decimal(10,4)) * 100
SET @Pt2_Ueb_UK_P = CAST(@Pt2_Ueb_UK as decimal(10,4)) / CAST(@Pt2_UK_Tot as decimal(10,4)) * 100
SET @Pt2_PH_Tot_P = @Pt2_ETP_PH_P + @Pt2_Ueb_PH_P
SET @Pt2_UK_Tot_P = @Pt2_ETP_UK_P + @Pt2_Ueb_UK_P
SET @Pt2_ETP_Tot_P = CAST(@Pt2_ETP_Tot as decimal(10,4)) / CAST(@Pt2_Tot as decimal(10,4)) * 100 
SET @Pt2_Ueb_Tot_P = CAST(@Pt2_Ueb_Tot as decimal(10,4)) / CAST(@Pt2_Tot as decimal(10,4)) * 100 
SET @Pt2_Tot_P = @Pt2_ETP_Tot_P + @Pt2_Ueb_Tot_P


SELECT @NEU_ETP_PH As NEU_ETP_PH, @NEU_ETP_PH_P AS NEU_ETP_PH_P
	, @NEU_ETP_UK AS NEU_ETP_UK, @NEU_ETP_UK_P AS NEU_ETP_UK_P
	, @NEU_ETP_Tot AS NEU_ETP_Tot, @NEU_ETP_Tot_P AS NEU_ETP_Tot_P

	, @NEU_Ueb_PH As NEU_Ueb_PH, @NEU_Ueb_PH_P As NEU_Ueb_PH_P
	, @NEU_Ueb_UK AS NEU_Ueb_UK, @NEU_Ueb_UK_P As NEU_Ueb_UK_P
	, @NEU_Ueb_Tot AS NEU_Ueb_Tot, @NEU_Ueb_Tot_P AS NEU_Ueb_Tot_P

	, @NEU_PH_Tot As NEU_PH_Tot, @NEU_PH_Tot_P As NEU_PH_Tot_P
	, @NEU_UK_Tot As NEU_UK_Tot, @NEU_UK_Tot_P As NEU_UK_Tot_P 
	, @NEU_Tot As NEU_Tot, @NEU_Tot_P As NEU_Tot_P


	, @RZ_ETP_PH As RZ_ETP_PH, @RZ_ETP_PH_P AS RZ_ETP_PH_P
	, @RZ_ETP_UK AS RZ_ETP_UK, @RZ_ETP_UK_P AS RZ_ETP_UK_P
	, @RZ_ETP_Tot AS RZ_ETP_Tot, @RZ_ETP_Tot_P AS RZ_ETP_Tot_P

	, @RZ_Ueb_PH As RZ_Ueb_PH, @RZ_Ueb_PH_P As RZ_Ueb_PH_P
	, @RZ_Ueb_UK AS RZ_Ueb_UK, @RZ_Ueb_UK_P As RZ_Ueb_UK_P
	, @RZ_Ueb_Tot AS RZ_Ueb_Tot, @RZ_Ueb_Tot_P AS RZ_Ueb_Tot_P

	, @RZ_PH_Tot As RZ_PH_Tot, @RZ_PH_Tot_P As RZ_PH_Tot_P
	, @RZ_UK_Tot As RZ_UK_Tot, @RZ_UK_Tot_P As RZ_UK_Tot_P 
	, @RZ_Tot As RZ_Tot, @RZ_Tot_P As RZ_Tot_P


	, @Pt_ETP_PH As Pt_ETP_PH, @Pt_ETP_PH_P AS Pt_ETP_PH_P
	, @Pt_ETP_UK AS Pt_ETP_UK, @Pt_ETP_UK_P AS Pt_ETP_UK_P
	, @Pt_ETP_Tot AS Pt_ETP_Tot, @Pt_ETP_Tot_P AS Pt_ETP_Tot_P

	, @Pt_Ueb_PH As Pt_Ueb_PH, @Pt_Ueb_PH_P As Pt_Ueb_PH_P
	, @Pt_Ueb_UK AS Pt_Ueb_UK, @Pt_Ueb_UK_P As Pt_Ueb_UK_P
	, @Pt_Ueb_Tot AS Pt_Ueb_Tot, @Pt_Ueb_Tot_P AS Pt_Ueb_Tot_P

	, @Pt_PH_Tot As Pt_PH_Tot, @Pt_PH_Tot_P As Pt_PH_Tot_P
	, @Pt_UK_Tot As Pt_UK_Tot, @Pt_UK_Tot_P As Pt_UK_Tot_P 
	, @Pt_Tot As Pt_Tot, @Pt_Tot_P As Pt_Tot_P


	, @Pt2_ETP_PH As Pt2_ETP_PH, @Pt2_ETP_PH_P AS Pt2_ETP_PH_P
	, @Pt2_ETP_UK AS Pt2_ETP_UK, @Pt2_ETP_UK_P AS Pt2_ETP_UK_P
	, @Pt2_ETP_Tot AS Pt2_ETP_Tot, @Pt2_ETP_Tot_P AS Pt2_ETP_Tot_P

	, @Pt2_Ueb_PH As Pt2_Ueb_PH, @Pt2_Ueb_PH_P As Pt2_Ueb_PH_P
	, @Pt2_Ueb_UK AS Pt2_Ueb_UK, @Pt2_Ueb_UK_P As Pt2_Ueb_UK_P
	, @Pt2_Ueb_Tot AS Pt2_Ueb_Tot, @Pt2_Ueb_Tot_P AS Pt2_Ueb_Tot_P

	, @Pt2_PH_Tot As Pt2_PH_Tot, @Pt2_PH_Tot_P As Pt2_PH_Tot_P
	, @Pt2_UK_Tot As Pt2_UK_Tot, @Pt2_UK_Tot_P As Pt2_UK_Tot_P 
	, @Pt2_Tot As Pt2_Tot, @Pt2_Tot_P As Pt2_Tot_P

	, @AcctPeriod As AcctPeriod, @DateFrom As DateFrom, @DateTo As DateTo
	


DROP TABLE #Book3
DROP TABLE #Book2
DROP TABLE #Positions
DROP TABLE #Bookings


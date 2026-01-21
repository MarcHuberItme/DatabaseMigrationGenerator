--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeMortgageCapitalBookings context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeMortgageCapitalBookings,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeMortgageCapitalBookings
CREATE OR ALTER PROCEDURE dbo.FreezeMortgageCapitalBookings

AS

DECLARE @DatumSaldo DATETIME
DECLARE @AcctPeriod INT
DECLARE @PeriodMonth INT
DECLARE @PrevAcctPeriod INT
DECLARE @DateFrom DATETIME
DECLARE @PrevDateFrom DATETIME
DECLARE @DateTo DATETIME
DECLARE @PrevDateTo DATETIME

Select  @AcctPeriod = year(EndDate)* 100 + month(EndDate), @PeriodMonth = month(EndDate) From AsProcTimeControl Where TypeNo = 1

--SET @AcctPeriod = 201101
--SET @PeriodMonth = 1
SET @PrevAcctPeriod = @AcctPeriod - 1
IF  @PeriodMonth = 1	-- für Januar
    BEGIN
		SET @PrevAcctPeriod = @AcctPeriod - 89
    END


SET @DateFrom = Str(@AcctPeriod) + '01'
SET @DateTo = DATEADD(month,1,@DateFrom) - 0.000001
SET @PrevDateFrom = Str(@PrevAcctPeriod) + '01'
SET @PrevDateTo = DATEADD(month,1,@PrevDateFrom) - 0.000001
SET @DatumSaldo = @PrevDateTo


-- Step 1: Create tmp-table with bookings
CREATE TABLE TmpHYStat (AccountancyPeriod int
	, SitzNo int, SitzName nvarchar(50), BookType nvarchar(50), AccountNo decimal(11,0)
	, AccountNoEdited nvarchar(20), CustomerReference nvarchar(100), ProductNo int
	, DebitAmount money, CreditAmount money, BalancePeriodStart money
	, BDatum datetime, Valuta datetime, SollHaben nvarchar(50)
	, ProductGroup nvarchar(50), Kunde nvarchar(50))

--DROP TABLE TmpHYStat
DELETE StatistikHypo WHERE AccountancyPeriod = @AcctPeriod

-- Step 2: Insert booking records 
INSERT INTO TmpHYStat (AccountancyPeriod
	, SitzNo, SitzName, BookType, AccountNo, AccountNoEdited, CustomerReference
	, ProductNo, DebitAmount, CreditAmount, BalancePeriodStart
	, BDatum, Valuta, SollHaben, ProductGroup, Kunde)

SELECT 	@AcctPeriod
	, 0 As Sitz, '' As SitzName, 'BookType' = 'Booking'
	, PtAccountBase.AccountNo, PtAccountBase.AccountNoEdited
	, PtAccountBase.CustomerReference, PrPrivate.ProductNo
	, PtTransItem.DebitAmount, PtTransItem.CreditAmount
	, 0 as Saldo, PtTransItem.TransDate, PtTransItem.ValueDate
	, '' As SollHaben, '' As ProductGroup, '' As Kunde
FROM PtTransItem
INNER JOIN PtPosition 	ON PtTransItem.PositionId = PtPosition.Id
INNER JOIN PrReference  	ON PtPosition.ProdReferenceId = PrReference.Id
INNER JOIN PtAccountBase 	ON PrReference.AccountId = PtAccountBase.Id
INNER JOIN PrPrivate	ON PrReference.ProductId = PrPrivate.ProductId
WHERE PrPrivate.ProductNo BETWEEN 3000 AND 3999
AND PtTransItem.TransDate >= @DateFrom AND PtTransItem.TransDate <= @DateTo
AND PtTransItem.IsDueRelevant = 0
AND PtTransItem.HdVersionNo between 1 and 999999998
ORDER BY SollHaben, ProductGroup, PtAccountBase.AccountNo


-- Step 3: UPDATE SollHaben
UPDATE TmpHYStat
SET SollHaben = CASE WHEN DebitAmount = 0 THEN '02 Haben' ELSE '01 Soll' END
WHERE AccountancyPeriod = @AcctPeriod


-- Step 4: Insert balance records for debit side
INSERT INTO TmpHYStat (AccountancyPeriod
	, SitzNo, SitzName, BookType, AccountNo, AccountNoEdited
	, CustomerReference, ProductNo, DebitAmount, CreditAmount 
	, BalancePeriodStart, BDatum, Valuta, SollHaben
	, ProductGroup, Kunde)

SELECT @AcctPeriod
	, 0 As Sitz, '' As SitzName, 'Balance' As BookType
	, PtAccountBase.AccountNo, PtAccountBase.AccountNoEdited
	, PtAccountBase.CustomerReference, PrPrivate.ProductNo
	, 0 As DebitAmount, 0 AS CreditAmount
	, SUM(ValueProductCurrency) AS BalanceStartPeriod
	, @DatumSaldo As BDatum, @DateFrom As Valuta
	, '01 Soll' As SollHaben, '' As ProductGroup, '' As Kunde
FROM AcCompression2
INNER JOIN PrReference	ON AcCompression2.PrReferenceId = PrReference.Id
INNER JOIN PrPrivate	ON PrReference.ProductId = PrPrivate.ProductId
INNER JOIN PtAccountBase 	ON PrReference.AccountId = PtAccountBase.Id
WHERE AcCompression2.AccountancyPeriod = @PrevAcctPeriod
AND AcCompression2.AmountType = 1
AND PtAccountBase.AccountNo IN (SELECT DISTINCT AccountNo FROM TmpHYStat WHERE SollHaben = '01 Soll')
GROUP BY PtAccountBase.AccountNo, PtAccountBase.AccountNoEdited, PtAccountBase.CustomerReference
	, PrPrivate.ProductNo


-- Step 5: Insert balance records for credit side
INSERT INTO TmpHYStat (AccountancyPeriod
	, SitzNo, SitzName, BookType, AccountNo, AccountNoEdited 
	, CustomerReference, ProductNo, DebitAmount, CreditAmount 
	, BalancePeriodStart, BDatum, Valuta, SollHaben
	, ProductGroup, Kunde)
SELECT @AcctPeriod
	, 0 As Sitz, '' As SitzName, 'Balance' As BookType
	, PtAccountBase.AccountNo, PtAccountBase.AccountNoEdited
	, PtAccountBase.CustomerReference, PrPrivate.ProductNo
	, 0 As DebitAmount, 0 AS CreditAmount
	, SUM(ValueProductCurrency) AS BalanceStartPeriod
	, @DatumSaldo As BDatum, @DateFrom As Valuta
	, '02 Haben' As SollHaben, '' As ProductGroup, '' As Kunde
FROM AcCompression2
INNER JOIN PrReference	ON AcCompression2.PrReferenceId = PrReference.Id
INNER JOIN PrPrivate  	ON PrReference.ProductId = PrPrivate.ProductId
INNER JOIN PtAccountBase 	ON PrReference.AccountId = PtAccountBase.Id
WHERE AcCompression2.AccountancyPeriod = @PrevAcctPeriod
AND AcCompression2.AmountType = 1
AND PtAccountBase.AccountNo IN (SELECT DISTINCT AccountNo FROM TmpHYStat WHERE SollHaben = '02 Haben')
GROUP BY PtAccountBase.AccountNo, PtAccountBase.AccountNoEdited, PtAccountBase.CustomerReference
	, PrPrivate.ProductNo


-- Step 6: UPDATE Kunde
UPDATE TmpHYStat 
SET Kunde = ReportAdrLine
FROM TmpHYStat
INNER JOIN PtAccountBase 	ON TmpHYStat.AccountNo = PtAccountBase.AccountNo
INNER JOIN PtPortfolio 	ON PtAccountBase.PortfolioId = PtPortfolio.Id
INNER JOIN PtAddress 	ON PtPortfolio.PartnerId = PtAddress.PartnerId
WHERE AccountancyPeriod = @AcctPeriod


-- Step 7: UPDATE Sitz
UPDATE TmpHYStat 
SET SitzNo = PtBase.BranchNo, SitzName = TextShort
FROM TmpHYStat
INNER JOIN PtAccountBase 	ON TmpHYStat.AccountNo = PtAccountBase.AccountNo
INNER JOIN PtPortfolio 	ON PtAccountBase.PortfolioId = PtPortfolio.Id
INNER JOIN PtBase 	ON PtPortfolio.PartnerId = PtBase.Id
INNER JOIN AsBranch	ON PtBase.BranchNo = AsBranch.BranchNo
INNER JOIN AsText	ON AsBranch.Id = AsText.MasterId
WHERE AsText.LanguageNo = 2
AND AccountancyPeriod = @AcctPeriod


-- Step 8: UPDATE ProductGroup
UPDATE TmpHYStat
SET ProductGroup = CASE
	WHEN ProductNo BETWEEN 3001 AND 3009 	THEN '01 Hypotheken (KAT 01-08)'
	WHEN ProductNo IN (3040,3044) 		THEN '02 Vorsch.Hyp (KAT 40,44)'
	WHEN ProductNo IN (3045,3046) 		THEN '03 Vorschüsse (KAT 45,46)'
	ELSE '04 Darlehen (KAT 20,24)' END
WHERE AccountancyPeriod = @AcctPeriod


-- Step 10: Copy records 
INSERT INTO StatistikHypo (RecNo
	, AccountancyPeriod, SitzNo, SitzName, BookType, AccountNo
	, AccountNoEdited, CustomerReference, ProductNo
	, DebitAmount, CreditAmount, BalancePeriodStart
	, BDatum, Valuta, SollHaben, ProductGroup, Kunde)


SELECT Row_Number() OVER (ORDER BY AccountancyPeriod, SollHaben, ProductGroup
, AccountNo, BookType, BDatum, Valuta) As RecNo
	, AccountancyPeriod, SitzNo As BranchNo, SitzName As BranchName
	, BookType, AccountNo, AccountNoEdited, CustomerReference
	, ProductNo, DebitAmount, CreditAmount, BalancePeriodStart
	, BDatum, Valuta, SollHaben, ProductGroup, Kunde
FROM TmpHYStat
ORDER BY AccountancyPeriod, SollHaben, ProductGroup, AccountNo, BookType, BDatum, Valuta

DROP TABLE TmpHYStat

--liquibase formatted sql

--changeset system:create-alter-procedure-GetTrialBalanceForAuditors context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTrialBalanceForAuditors,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTrialBalanceForAuditors
CREATE OR ALTER PROCEDURE dbo.GetTrialBalanceForAuditors
 @RealDateFrom datetime,
 @RealDateTo datetime,
 @TimestampBalance datetime

	 /* 17.01.2023 MCT
	    retrieve the balance information of all main ledger accounts for the closing
		include also the balance at the beginning of the year
		this information is provided to the auditors 
		MJET
	*/

AS 

DECLARE @AccountancyPeriodAfter as char(6)
DECLARE @AccountancyPeriodBefore as char(6)
DECLARE @TerminationFrom as datetime
DECLARE @LatestTransDate datetime

SET @AccountancyPeriodAfter = CONVERT(nvarchar(6), @RealDateTo, 112)
SET @AccountancyPeriodBefore = CONVERT(nvarchar(6), @RealDateFrom -1, 112)
SET @TerminationFrom = @RealDateFrom
SET @LatestTransDate = dateadd(d, -30, @RealDateFrom)


	Select PAB.AccountNo, 
	PAB.CustomerReference, 
	ACVOR.Currency, 
	IsNull(ACVOR.ValueProductCurrency, 0) SaldoVor, 
	ISNULL(ACNACH.ValueProductCurrency,0) + ISNULL(DebitAmountSum,0) - ISNULL(CreditAmountSum,0) AS SaldoNach, 
	P.ProductNo, 
	AT.TextShort ProduktBezeichnung
	From PtAccountBase PAB with (nolock)
	Join PrReference PR with (nolock) on PAB.Id = PR.AccountId
	join PrPrivate P with (nolock) on PR.ProductId = P.ProductId AND P.ProductNo Between 8999 AND 9999
	join AsText AT with (nolock) on P.Id = AT.MasterId AND AT.LanguageNo = 2
	left outer join AcCompression2 ACVOR on PR.Id = ACVOR.PrReferenceID AND ACVOR.AccountancyPeriod = @AccountancyPeriodBefore
	left outer join AcCompression2 ACNACH on PR.Id = ACNACH.PrReferenceId AND ACNACH.AccountancyPeriod = @AccountancyPeriodAfter
	left outer join AcBalanceStructure BS on PAB.AccountNo = BS.BalanceAccountNo AND BS.AL3 in (111005,111007,111010,111015,111040,111070,112005,112010,112030,112050,112055,150505,150510,150515,151005,152005,153005,153010,153015,153020,154005,155010,155405)
	left outer join (
						SELECT AccountNo, Currency, SUM(DebitAmount) as DebitAmountSum, SUM(CreditAmount) as CreditAmountSum
						FROM PtTransItemMainledgerLastYearView with (nolock)
						WHERE LatestTransDate >= @LatestTransDate
						AND RealDate >=  @RealDateFrom
						AND RealDate <= @RealDateTo 
						AND TransDateTime > @TimestampBalance
						AND @TimestampBalance IS NOT NULL
						GROUP BY AccountNo, Currency) AS BookingsAfterTimeStamp ON PAB.AccountNo = BookingsAfterTimeStamp.AccountNo AND PR.Currency = BookingsAfterTimeStamp.Currency

	WHERE (PAB.TerminationDate is null or PAB.TerminationDate >= @TerminationFrom) 

	OPTION(MAXDOP 2)

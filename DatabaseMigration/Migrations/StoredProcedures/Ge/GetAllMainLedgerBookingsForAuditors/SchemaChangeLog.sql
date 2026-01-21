--liquibase formatted sql

--changeset system:create-alter-procedure-GetAllMainLedgerBookingsForAuditors context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAllMainLedgerBookingsForAuditors,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAllMainLedgerBookingsForAuditors
CREATE OR ALTER PROCEDURE dbo.GetAllMainLedgerBookingsForAuditors
 @RealDateFrom datetime,
 @RealDateTo datetime,
 @TimestampBalance datetime
 

 AS

DECLARE @LatestTransDate datetime
DECLARE @TimestampFlag bit

SET @LatestTransDate = dateadd(d, -30, @RealDateFrom)

SELECT @TimestampFlag = CASE WHEN @TimestampBalance IS NULL THEN 0
ELSE 1 END  

SET @TimestampBalance = isnull(@TimestampBalance,GETDATE())

SELECT 
PTIF.Id, 
PTIF.AccountNo, 
PTIF.Currency,
Replace(PTIF.CustomerReference,Char(13) + Char(10),',') AS CustomerReference,
PTIF.DebitAmount, 
PTIF.CreditAmount, 
Convert(char(11), Isnull(PTOIMV.OrderCreateDate, PTIF.HdCreateDate), 103) + Convert(char(8), Isnull(PTOIMV.OrderCreateDate, PTIF.HdCreateDate), 108) as Erfassungsdatum,
Convert(char(11), PTIF.TransDateTime, 103) + Convert(char(8), PTIF.TransDateTime, 108) Buchungsdatum, 
Convert(char(11), PTIF.ValueDate, 103) + Convert(char(8), PTIF.ValueDate, 108) Valuta,
Convert(char(11), PTOIMV.OrderDate, 103) + Convert(char(8), PTOIMV.OrderDate, 108) Auftragsdatum,
IsNull(PTOIMV.OrderCreator, PTIF.HdCreator) as Erfasser, 
PTOIMV.TextShort as Auftragsart,
AsT.TextShort AS Buchungstyp,
Replace(PTIF.TransText, Char(13) + Char(10), ',')

FROM (
	select Id, AccountNo, Currency, CustomerReference, DebitAmount, CreditAmount, MessageId, HdCreateDate, TransDateTime, ValueDate, HdCreator, PTIM.TextNo, PTIM.TransText
	FROM PtTransItemMainledgerLastYearView as PTIM with (nolock)
	WHERE PTIM.DetailCounter <= 1
	AND LatestTransDate >= @LatestTransDate
	AND RealDate >=  @RealDateFrom
	AND RealDate <= @RealDateTo 

	UNION ALL

	select PTID.Id, PTIM.AccountNo, PTIM.Currency, PTIM.CustomerReference, PTID.DebitAmount, PTID.CreditAmount, PTID.MessageId, PTID.HdCreateDate, 
	PTIM.TransDateTime, PTIM.ValueDate, PTIM.HdCreator, PTID.TextNo, PTID.TransText
	FROM PtTransItemMainledgerLastYearView as PTIM with (nolock)
	INNER JOIN PtTransItemDetail as PTID with (nolock) ON PTIM.Id = PTID.TransItemId 
	WHERE PTIM.DetailCounter > 1
	AND PTIM.LatestTransDate >= @LatestTransDate 
	AND PTIM.RealDate >= @RealDateFrom
	AND PTIM.RealDate <= @RealDateTo 

	) As PTIF
	left outer join PtTransItemText PTIT with (nolock) on PTIF.TextNo = PTIT.TextNo
	left outer join AsText AsT with (nolock) on PTIT.Id = AsT.MasterId AND AsT.LanguageNo = 2 AND AsT.MasterTableName = 'PtTransItemText'
	LEFT OUTER JOIN PtTransOrderInfoMainledgerView  AS PTOIMV with (nolock) ON PTIF.MessageId = PTOIMV.MessageId 
	WHERE (TransDateTime < @TimestampBalance OR @TimestampFlag=0)

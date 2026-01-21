--liquibase formatted sql

--changeset system:create-alter-procedure-CyImportCurrencyBankNotes context:any labels:c-any,o-stored-procedure,ot-schema,on-CyImportCurrencyBankNotes,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyImportCurrencyBankNotes
CREATE OR ALTER PROCEDURE dbo.CyImportCurrencyBankNotes
AS


Select NULL as CyRateImportId
, NULL as HdEditStamp
, B.Symbol as CySymbolOriginate
, TXT.TextShort as CyOriginate
, 'CHF' as CySymbolTarget
, Isnull(((Select Top 1 RR.Rate
From cyRateRecent RR 
Where RR.Validto > getdate() 
	AND RR.ValidFrom <= getdate() 
	AND RR.RateType = 103
	AND RR.CySymbolOriginate = B.Symbol
	AND RR.CySymbolTarget = 'CHF'
	AND RR.HdVersionNo Between 1 AND 99999998
Order by RR.ValidFrom DESC) 
-
(select Top 1 C.SpreadTrader + C.SpreadManager from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo And C.HdVersionNo between 1 and 999999998 Order by Amount ASC))
*
	isNull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
	Where RP.CySymbolOriginate = B.Symbol
			AND RP.CySymbolTarget = 'CHF' 
			AND RP.HdVersionNo Between 1 AND 99999998),1)
,0)as Bid
,isnull( ((Select Top 1 RR.Rate
	From cyRateRecent RR 
	Where RR.Validto > getdate() 
		AND RR.ValidFrom <= getdate() 
		AND RR.RateType = 103
		AND RR.CySymbolOriginate = B.Symbol
		AND RR.CySymbolTarget = 'CHF'
		AND RR.HdVersionNo Between 1 AND 99999998
	Order by RR.ValidFrom DESC) 
+
	(select Top 1 C.SpreadTrader + C.SpreadManager from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo And C.HdVersionNo between 1 and 999999998 Order by Amount ASC)) 
*
	isnull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
	Where RP.CySymbolOriginate = B.Symbol
			AND RP.CySymbolTarget = 'CHF' 
			AND RP.HdVersionNo Between 1 AND 99999998),1)
, 0)as Ask
, (Select Top 1 RR.Rate
From cyRateRecent RR 
Where RR.Validto > getdate() 
	AND RR.ValidFrom <= getdate() 
	AND RR.RateType = 103
	AND RR.CySymbolOriginate = B.Symbol
	AND RR.CySymbolTarget = 'CHF'
	AND RR.HdVersionNo Between 1 AND 99999998
Order by RR.ValidFrom DESC
)as RateNew
, isnull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
Where RP.CySymbolOriginate = B.Symbol
		AND RP.CySymbolTarget = 'CHF' 
		AND RP.HdVersionNo Between 1 AND 99999998),1 )
as Factor
,(Select Top 1 RR.Rate
From cyRateRecent RR 
Where RR.Validto > getdate() 
	AND RR.ValidFrom <= getdate() 
	AND RR.RateType = 103
	AND RR.CySymbolOriginate = B.Symbol
	AND RR.CySymbolTarget = 'CHF'
	AND RR.HdVersionNo Between 1 AND 99999998
Order by RR.ValidFrom DESC) 
as RateOld 
, 
(Select Top 1 RR.Id
From cyRateRecent RR 
Where RR.Validto > getdate() 
	AND RR.ValidFrom <= getdate() 
	AND RR.RateType = 103
	AND RR.CySymbolOriginate = B.Symbol
	AND RR.CySymbolTarget = 'CHF'
	AND RR.HdVersionNo Between 1 AND 99999998
Order by RR.ValidFrom DESC)
 As RateRecentId
, '103' as RateType
--, cast(day(getdate()) as varchar) + '.' + cast(month(getdate()) as varchar) + '.' + cast(year(getdate()) as Varchar) as ValidFrom
, Convert(varchar,getdate() , 104) as ValidFrom
, '31.12.2199' as ValidTo   
, '' as Description
, 'ZKB ' + Convert(varchar,getdate() ,112) as PublisherName
, '' as SourceName
, RR.DifferenceMax
, Convert(varchar,getdate() , 104)  as RateDate
,  B.Sequence as Sequence
From CyBase B
Left Outer Join asText TXT on TXT.MasterId = B.Id And TXT.LanguageNo = 2
Inner Join CyRateRule RR on  RR.CySymbolOriginate = B.Symbol
	AND RR.CySymbolTarget = 'CHF'
	AND RR.PaymentInstrumentNo = 10
	AND RR.HdVersionNo Between 1 AND 99999998
Where B.HdVersionNo Between 1 AND 99999998
AND BillCoinImport = 1

Order by B.Sequence

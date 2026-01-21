--liquibase formatted sql

--changeset system:create-alter-procedure-CyImportCurrencyRates context:any labels:c-any,o-stored-procedure,ot-schema,on-CyImportCurrencyRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyImportCurrencyRates
CREATE OR ALTER PROCEDURE dbo.CyImportCurrencyRates
AS


if (Select count(ID) From cyRateImport Where HdVersionNo Between 1 AND 99999998) > 0 

	Select Ri.Id as CyRateImportId
	, RI.HdEditStamp as HdEditStamp
	, 
	case  RRule.SaveInverseRate
	When 0 Then
		RI.CySymbolOriginate
	else
		RI.CySymbolTarget
	end as CySymbolOriginate
	,
	case  RRule.SaveInverseRate
	When 0 Then
		RI.CySymbolTarget
	else
		RI.CySymbolOriginate
	end as  CySymbolTarget
	, 
	case  RRule.SaveInverseRate
	When 0 Then
		cast(RI.rate / isnull(RRule.DataScopeFactor,1) as float)
	else
		cast(1 / (RI.rate / isnull(RRule.DataScopeFactor,1)) as decimal(10,8))
	end as RateNew
	, 
	case  RRule.SaveInverseRate
	When 0 Then
		(Select Top 1 RR.Rate
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RI.CySymbolOriginate
			AND RR.CySymbolTarget = RI.CySymbolTarget
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC) 
	else
		(Select Top 1 RR.Rate
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate =  RI.CySymbolTarget
			AND RR.CySymbolTarget = RI.CySymbolOriginate
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC) 
	end as RateOld 
	, 
	case  RRule.SaveInverseRate
	When 0 Then
		(Select Top 1 RR.Id
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RI.CySymbolOriginate
			AND RR.CySymbolTarget = RI.CySymbolTarget
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC)
	Else
		(Select Top 1 RR.Id
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RI.CySymbolTarget
			AND RR.CySymbolTarget = RI.CySymbolOriginate
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC)
	End	 As RateRecentId


	, cast(RI.PaymentInstrumentNo as varchar) + '3' as RateType
	--, cast(day(getdate()) as varchar) + '.' + cast(month(getdate()) as varchar) + '.' + cast(year(getdate()) as Varchar) as ValidFrom
	, Convert(varchar,getdate() , 104) as ValidFrom
	, '31.12.2199' as ValidTo   
	, RI.Description as Description
	, 'DataScope ' + Convert(varchar,RI.RateDate ,112) as PublisherName
	, '' as SourceName
	, RRule.DifferenceMax
	, RI.RateDate
	, 'NONE' as Style
	, RRule.SaveInverseRate
	From cyRateImport RI
	Inner Join CyRateRule RRule on  RRule.CySymbolOriginate = RI.CySymbolOriginate 
		AND RRule.CySymbolTarget = RI.CySymbolTarget 
		AND RRule.PaymentInstrumentNo = RI.PaymentInstrumentNo
		AND RRule.HdVersionNo Between 1 AND 99999998
	Inner Join cyRateImport RI2 on RI2.CySymbolOriginate = RI.CySymbolOriginate 
		AND RI.RateDate = RI2.RateDate
		AND RI2.CySymbolTarget = RI.CySymbolTarget
                                AND RI2.HdVersionNo between 1 and 999999998
		AND RI2.RateDate = (Select max(RI3.RateDate) 
							From cyRateImport RI3 
							Where RI3.HdVersionNo Between 1 AND 99999998 
							AND RI3.CySymbolOriginate = RI.CySymbolOriginate
							AND RI3.CySymbolTarget = RI.CySymbolTarget
							Group by RI3.CySymbolOriginate, RI3.CySymbolTarget)
	Where RI.HdVersionNo Between 1 AND 99999998

Else




	Select  NULL as CyRateImportId
	, NULL as HdEditStamp
	,
	case  RRule.SaveInverseRate
	When 0 Then
		RRule.CySymbolOriginate
	else
		RRule.CySymbolTarget
	end as CySymbolOriginate
	,
	case  RRule.SaveInverseRate
	When 0 Then
		RRule.CySymbolTarget
	else
		RRule.CySymbolOriginate
	end as  CySymbolTarget	
	,
	case  RRule.SaveInverseRate
	When 0 Then
		(Select Top 1 RR.Rate
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RRule.CySymbolOriginate
			AND RR.CySymbolTarget = RRule.CySymbolTarget
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC) 
	else
		(Select Top 1 RR.Rate
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate =  RRule.CySymbolTarget
			AND RR.CySymbolTarget = RRule.CySymbolOriginate
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC) 
	end as RateNew
	,
	case  RRule.SaveInverseRate
	When 0 Then
		(Select Top 1 RR.Rate
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RRule.CySymbolOriginate
			AND RR.CySymbolTarget = RRule.CySymbolTarget
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC) 
	else
		(Select Top 1 RR.Rate
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate =  RRule.CySymbolTarget
			AND RR.CySymbolTarget = RRule.CySymbolOriginate
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC) 
	end as RateOld

	, 
	case  RRule.SaveInverseRate
	When 0 Then
		(Select Top 1 RR.Id
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RRule.CySymbolOriginate
			AND RR.CySymbolTarget = RRule.CySymbolTarget
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC)
	Else
		(Select Top 1 RR.Id
		From cyRateRecent RR 
		Where RR.Validto > getdate() 
			AND RR.ValidFrom <= getdate() 
			AND RR.RateType = 203
			AND RR.CySymbolOriginate = RRule.CySymbolTarget
			AND RR.CySymbolTarget = RRule.CySymbolOriginate
			AND RR.HdVersionNo Between 1 AND 99999998
		Order by RR.ValidFrom DESC, RR.HdChangeDate DESC)
	End	 As RateRecentId

	, '203' as RateType
	, Convert(varchar,getdate() , 104) as ValidFrom
	, '31.12.2199' as ValidTo   
	, case  RRule.SaveInverseRate
	When 0 Then
		RRule.CySymbolOriginate + '/' + RRule.CySymbolTarget
	else
		RRule.CySymbolTarget + '/' + RRule.CySymbolOriginate
	end as Description
	, (Select Top 1 Value From asParameter Where Name = 'BankShortName') + ' ' + Convert(varchar,getdate() ,112) as PublisherName
	, '' as SourceName
	, RRule.DifferenceMax
	, Convert(varchar,getdate() , 104)  as RateDate
	, 'NONE' as Style
	, RRule.SaveInverseRate
	From CyBase B
	Left Outer Join asText TXT on TXT.MasterId = B.Id And TXT.LanguageNo = 2
	Inner Join CyRateRule RRule on  (RRule.CySymbolOriginate = B.Symbol /*OR RRule.CySymbolTarget = B.Symbol*/ )
		--AND RR.CySymbolTarget = 'CHF'
		AND RRule.PaymentInstrumentNo = 20
		AND RRule.HdVersionNo Between 1 AND 99999998
	Where B.HdVersionNo Between 1 AND 99999998
	AND B.CategoryNo = 1
	AND RRule.SaveInverseRate = 0
	AND
		case  RRule.SaveInverseRate
		When 0 Then
			(Select Top 1 RR.Id
			From cyRateRecent RR 
			Where RR.Validto > getdate() 
				AND RR.ValidFrom <= getdate() 
				AND RR.RateType = 203
				AND RR.CySymbolOriginate = RRule.CySymbolOriginate
				AND RR.CySymbolTarget = RRule.CySymbolTarget
				AND RR.HdVersionNo Between 1 AND 99999998
			Order by RR.ValidFrom DESC, RR.HdChangeDate DESC)
		Else
			(Select Top 1 RR.Id
			From cyRateRecent RR 
			Where RR.Validto > getdate() 
				AND RR.ValidFrom <= getdate() 
				AND RR.RateType = 203
				AND RR.CySymbolOriginate = RRule.CySymbolTarget
				AND RR.CySymbolTarget = RRule.CySymbolOriginate
				AND RR.HdVersionNo Between 1 AND 99999998
			Order by RR.ValidFrom DESC, RR.HdChangeDate DESC)
		End is not null

	Order by B.Sequence



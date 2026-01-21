--liquibase formatted sql

--changeset system:create-alter-view-PtTaxReportView_Origin context:any labels:c-any,o-view,ot-schema,on-PtTaxReportView_Origin,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTaxReportView_Origin
CREATE OR ALTER VIEW dbo.PtTaxReportView_Origin AS
Select J.TaxReportJobNo, R.ValidPeriodBeginDate, R.ValidPeriodEndDate, J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	Null As ChargeAmount, Null As ChargeText,
	Pos.PositionID, Pos.TaxReportClass, 
	Pos.ReportPosCurrency As PositionCurrency, Pos.ReportPosAmount As PositionBalance, 
	Pos.InstrTextInterest As InterestRate, Pos.PositionText As PositionDescription,
	Pos.AccountNo, Pos.PosSequence, Pos.InstrumentTypeNo, 
	Cast(Case When AccountNo Is Null Then VDFInstrumentSymbol Else CAST(Pos.AccountNo As varchar(12)) End As BigInt) As ValorNo,
	Pos.PriceCurrency As TVCurrency, Pos.Price As TVPrice, Pos.TaxPriceSourceNo,
	Pos.PriceQuoteType As PercentPrice, Pos.TaxValueHoCu As TaxableValueHoCu,
	Case When Pos.TaxValueHoCu<0 Then 0 Else Pos.TaxValueHoCu End As CrTaxableValueHoCu,
	Case When Pos.TaxValueHoCu<0 Then Pos.TaxValueHoCu Else 0 End As DeTaxableValueHoCu,
	Pos.ConversionCurrency, Pos.ExtrateCvCuHoCu, Pos.HasUnknownIncome, 
	Pos.AccountOpeningDate, Pos.AccountTerminationDate, Pos.TaxCountry,
	DT.TransDate, DT.TransText, DT.Quantity As TransQuantity, DT.TradePriceCurrency As TransCurrency, 
	DT.TradePrice, Case When I.IncomeTypeNo=9 Then Null Else DT.BaseQuantity End As CAQuantity, DT.TaxableAmountHoCu, 
	Case When DT.TaxableAmountHoCu<0 Then 0 Else DT.TaxableAmountHoCu End As CrTaxableAmountHoCu,
	Case When DT.TaxableAmountHoCu<0 Then DT.TaxableAmountHoCu Else 0 End As DeTaxableAmountHoCu,
	DT.TaxAmountDaHoCu, 0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'lautend auf: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999
	Inner Join PtPortfolio O On Pos.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Left Outer Join PtTaxPosDetail DT On DT.TaxPosID=Pos.ID And DT.HdVersionNo<999999999
	Left Outer Join PtPositionIncome I On DT.PositionIncomeId=I.Id
	Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
--Where R.PartnerNoEdited='19.092' And J.TaxReportJobNo=5534

Union All

Select Distinct J.TaxReportJobNo, R.ValidPeriodBeginDate, R.ValidPeriodEndDate, J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	Null As ChargeAmount, Null As ChargeText,
	Pos.PositionID, 'P' As TaxReportClass, 
	Pos.ReportPosCurrency As PositionCurrency, Pos.ReportPosAmount As PositionBalance, 
	Pos.InstrTextInterest As InterestRate, Pos.PositionText As PositionDescription,
	Pos.AccountNo, Pos.PosSequence, Pos.InstrumentTypeNo, 
	Cast(Case When AccountNo Is Null Then VDFInstrumentSymbol Else CAST(Pos.AccountNo As varchar(12)) End As BigInt) As ValorNo,
	Pos.PriceCurrency As TVCurrency, Pos.Price As TVPrice,  Pos.TaxPriceSourceNo,
	Pos.PriceQuoteType As PercentPrice, 0 As TaxableValueHoCu, 0 As CrTaxableValueHoCu, 0 As DeTaxableValueHoCu,
	Pos.ConversionCurrency, Pos.ExtrateCvCuHoCu, Pos.HasUnknownIncome, 
	Pos.AccountOpeningDate, Pos.AccountTerminationDate, Pos.TaxCountry,
	DT.TransDate, DT.TransText, DT.Quantity As TransQuantity, DT.TradePriceCurrency As TransCurrency, 
	DT.TradePrice, DT.BaseQuantity As CAQuantity, 0 As TaxableAmountHoCu, 0 As CrTaxableAmountHoCu, 0 As DeTaxableAmountHoCu, 0 As TaxAmountDaHoCu, 
	Pos.TaxValueHoCu As PUTaxableValueHoCu, DT.TaxableAmountHoCu As PUTaxableAmountHoCu, DT.TaxAmountDaHoCu As PUTaxAmountDaHoCu, Cast(1 As bit) As OnlyForPUSA,
	A.FullAddress, 'lautend auf: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	Inner Join (Select Distinct UP.TaxReportDataID, UP.ID As UPosID
		From PtTaxPosDetail UD Right Outer Join PtTaxPos UP On UD.TaxPosID=UP.ID 
			And UD.HdVersionNo<999999999 And UP.HdVersionNo<999999999
		Where --UD.TaxableAmountHoCu<>0 And 
			UP.TaxReportClass='U') UPos On R.ID=UPos.TaxReportDataID 
	Inner Join PtTaxPos Pos On UPos.UPosID=Pos.ID And Pos.HdVersionNo<999999999
	Inner Join PtPortfolio O On Pos.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Left Outer Join PtTaxPosDetail DT On DT.TaxPosID=Pos.ID And DT.HdVersionNo<999999999
	Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
--Where J.TaxReportJobNo=5534

Union All

Select Distinct J.TaxReportJobNo, R.ValidPeriodBeginDate, R.ValidPeriodEndDate, J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	AC.AccountCharge As ChargeAmount, 'Kontospesen' As ChargeText,
	Null As PositionID, AC.TaxReportClass As TaxReportClass, 
	Null As PositionCurrency, Null As PositionBalance, Null As InterestRate, 
	Null As PositionDescription,
	Null As AccountNo, Null As PosSequence, Null As InstrumentTypeNo, Null As ValorNo, Null As TVCurrency, Null As TVPrice,  Null As TaxPriceSourceNo,
	Null As PercentPrice, Null As TaxableValueHoCu, Null As CrTaxableValueHoCu, Null As DeTaxableValueHoCu,
	Null As ConversionCurrency, Null As ExtrateCvCuHoCu, 0 As HasUnknownIncome,
	Null As AccountOpeningDate, Null As AccountTerminationDate, Null As TaxCountry,
	Null As TransDate, Null As TransText, Null As TransQuantity, Null As TransCurrency, 
	Null As TradePrice, Null As CAQuantity, Null As TaxableAmountHoCu, Null As CrTaxableAmountHoCu, Null As DeTaxableAmountHoCu, Null As TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'lautend auf: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	Inner Join (Select TaxReportDataID, PortfolioID, Sum(AccountChargeHoCu) As AccountCharge, MIN(TaxReportClass) As TaxReportClass
		From PtTaxPos
		Where HdVersionNo<999999999
		Group By TaxReportDataID, PortfolioID
        Having Sum(AccountChargeHoCu) <>0) AC On R.ID=AC.TaxReportDataID
	Inner Join PtPortfolio O On AC.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
--Where R.PartnerNoEdited='19.092'

Union All

--For Charge
Select Distinct J.TaxReportJobNo, R.ValidPeriodBeginDate, R.ValidPeriodEndDate, J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	CC.ChargeAmount, 
	Cast(Case When CC.TaxReportRelChargeTypeNo=4 Then 'Kontospesen' When CC.TaxReportRelChargeTypeNo=2 Then CTx.TextShort + ' (Anteil Depotgebühren & Verwaltungskosten)' Else CTx.TextShort End As varchar(60)) As ChargeText,
	Null As PositionID, Pos.TaxReportClass, 
	Null As PositionCurrency, Null As PositionBalance, Null As InterestRate, 
	Null As PositionDescription,
	Null As AccountNo, Null As PosSequence, Null As InstrumentTypeNo, Null As ValorNo, Null As TVCurrency, Null As TVPrice,  Null As TaxPriceSourceNo,
	Null As PercentPrice, Null As TaxableValueHoCu, Null As CrTaxableValueHoCu, Null As DeTaxableValueHoCu,
	Null As ConversionCurrency, Null As ExtrateCvCuHoCu, 0 As HasUnknownIncome,
	Null As AccountOpeningDate, Null As AccountTerminationDate, Null As TaxCountry,
	Null As TransDate, Null As TransText, Null As TransQuantity, Null As TransCurrency, 
	Null As TradePrice, Null As CAQuantity, Null As TaxableAmountHoCu, Null As CrTaxableAmountHoCu, Null As DeTaxableAmountHoCu, Null As TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'lautend auf: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
Join (Select D.Id, DPP.PortfolioId, TaxReportRelChargeTypeNo, Sum(TaxChargeAmountHoCu) As ChargeAmount
  From PtTaxReportData D Join (Select Distinct DR.ID As TaxReportDataID, DP.PortfolioID From PtTaxReportData DR Inner Join PtTaxPos DP On DR.ID=DP.TaxReportDataID And DP.HdVersionNo<999999999 And DR.HdVersionNo<999999999) DPP On D.Id=DPP.TaxReportDataID
  Join (Select T.*,
    Case When TaxReportRelChargeTypeNo<>3 And IsManuallyInput=0 Then A.BookingDate
         When TaxReportRelChargeTypeNo<>3 And IsManuallyInput=1 And Year(T.HdCreateDate)=TaxYear Then T.HdCreateDate
         When TaxReportRelChargeTypeNo<>3 And IsManuallyInput=1 And Year(T.HdCreateDate)>TaxYear Then Cast(STR(T.TaxYear)+'12'+'31' As Date) End As BookingDate
    From PtPortfolioTaxChargeDetail T Left Outer Join PtAdmChargePortfolio A On T.AdmChargePortfolioId=A.Id
    Where T.HdVersionNo<999999999 And TaxReportRelChargeTypeNo<>3 ) C On DPP.PortfolioId=C.PortfolioId And C.BookingDate>=D.ValidPeriodBeginDate And C.BookingDate<=D.ValidPeriodEndDate
  Group By D.Id, DPP.PortfolioId, TaxReportRelChargeTypeNo 
  UNION 
  Select D.Id, PC.PortfolioId, PC.TaxReportRelChargeTypeNo, PC.TaxChargeAmountHoCu As ChargeAmount
  From PtPortfolioTaxChargeDetail PC Join PtPortfolio O On PC.PortfolioId=O.Id 
    And PC.TaxReportRelChargeTypeNo = 3 And PC.TaxChargeAmountHoCu<>0 And PC.HdVersionNo < 999999999
  Join PtTaxReportData D On O.PartnerId=D.PartnerId And PC.TaxYear=Year(D.ValidPeriodBeginDate)
    And ((PC.TaxReportDataId Is Null And IsManuallyInput = 1 
            And ((Year(PC.HdCreateDate)>TaxYear) Or (Year(PC.HdCreateDate)=TaxYear And PC.HdCreateDate>=D.ValidPeriodBeginDate))) 
         Or (PC.TaxReportDataId=D.Id))) CC On R.Id=CC.Id
  Inner Join PtTaxReportRelChargeType CT On CC.TaxReportRelChargeTypeNo=CT.TaxReportRelChargeTypeNo And CT.HdVersionNo<999999999
  Inner Join AsText CTx On CTx.MasterID=CT.ID And CTx.LanguageNo=2
  Inner Join PtPortfolio O On CC.PortfolioID=O.ID --And O.HdVersionNo<999999999
  Left Outer Join (Select TaxReportDataID, PortfolioId, MIN(TaxReportClass) As TaxReportClass From PtTaxPos Where HdVersionNo<999999999 Group By TaxReportDataID, PortfolioId) Pos On R.ID=Pos.TaxReportDataID And Pos.PortfolioId=CC.PortfolioId
  Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999

Union All

--for no pos summary
Select Distinct J.TaxReportJobNo, R.ValidPeriodBeginDate, R.ValidPeriodEndDate, J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, 
	R.HasPartnerSummary, R.FiscalDomicileCanton,  
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	Null As ChargeAmount, Null As ChargeText,
	Null As PositionID, EV.TaxReportClass, 
	Null As PositionCurrency, Null As PositionBalance, 
	Null As InterestRate, Null As PositionDescription,
	Null As AccountNo, Null As PosSequence, Null As InstrumentTypeNo, 
	Null As ValorNo,
	Null As TVCurrency, Null As TVPrice, Null As TaxPriceSourceNo,
	Null As PercentPrice, 0 As TaxableValueHoCu, 0 As CrTaxableValueHoCu, 0 As DeTaxableValueHoCu,
	Null As ConversionCurrency, Null As ExtrateCvCuHoCu, Null As HasUnknownIncome, 
	Null As AccountOpeningDate, Null As AccountTerminationDate, Null As TaxCountry,
	Null As TransDate, Null As TransText, Null TransQuantity, 
	Null As TransCurrency, 
	Null As TradePrice, Null As CAQuantity, 0 As TaxableAmountHoCu, 0 As CrTaxableAmountHoCu, 0 As DeTaxableAmountHoCu, 0 As TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'lautend auf: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	-- Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999
	Left Outer Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999
	Right Outer Join EvTaxReportClass Ev On 1=1
	--Join PtPortfolio O On Pos.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Join PtPortfolio O On ((R.HasPartnerSummary=1 And Pos.PortfolioID=O.ID) 
		Or (R.HasPartnerSummary=0 And R.PortfolioID=O.ID))
		And (O.TerminationDate Is Null Or (O.TerminationDate Is Not Null And O.TerminationDate>R.ValidPeriodBeginDate))
                Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
Where Pos.PositionId Is Null

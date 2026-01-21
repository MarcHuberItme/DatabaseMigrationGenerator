--liquibase formatted sql

--changeset system:create-alter-view-PtTaxReportView_1 context:any labels:c-any,o-view,ot-schema,on-PtTaxReportView_1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTaxReportView_1
CREATE OR ALTER VIEW dbo.PtTaxReportView_1 AS
Select J.TaxReportJobNo, J.PeriodBeginDate, J.PeriodEndDate, J.IsForInternalUse,
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
	Pos.ConversionCurrency, Pos.ExtrateCvCuHoCu, Pos.HasUnknownIncome, 
	Pos.AccountOpeningDate, Pos.AccountTerminationDate, Pos.TaxCountry,
	DT.TransDate, DT.TransText, DT.Quantity As TransQuantity, DT.TradePriceCurrency As TransCurrency, 
	DT.TradePrice, DT.BaseQuantity As CAQuantity, DT.TaxableAmountHoCu, DT.TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'the name of: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999
	Inner Join PtPortfolio O On Pos.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Left Outer Join PtTaxPosDetail DT On DT.TaxPosID=Pos.ID And DT.HdVersionNo<999999999
	Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
--Where R.PartnerNoEdited='19.092' And J.TaxReportJobNo=5534

Union All

Select J.TaxReportJobNo, J.PeriodBeginDate, J.PeriodEndDate, J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	Null As ChargeAmount, Null As ChargeText,
	Pos.PositionID, 'P' As TaxReportClass, 
	Pos.ReportPosCurrency As PositionCurrency, Pos.ReportPosAmount As PositionBalance, 
	Pos.InstrTextInterest As InterestRate, Pos.PositionText As PositionDescription,
	Pos.AccountNo, Pos.PosSequence, Pos.InstrumentTypeNo, 
	Cast(Case When AccountNo Is Null Then VDFInstrumentSymbol Else CAST(Pos.AccountNo As varchar(12)) End As BigInt) As ValorNo,
	Pos.PriceCurrency As TVCurrency, Pos.Price As TVPrice,  Pos.TaxPriceSourceNo,
	Pos.PriceQuoteType As PercentPrice, 0 As TaxableValueHoCu, 
	Pos.ConversionCurrency, Pos.ExtrateCvCuHoCu, Pos.HasUnknownIncome, 
	Pos.AccountOpeningDate, Pos.AccountTerminationDate, Pos.TaxCountry,
	DT.TransDate, DT.TransText, DT.Quantity As TransQuantity, DT.TradePriceCurrency As TransCurrency, 
	DT.TradePrice, DT.BaseQuantity As CAQuantity, 0 As TaxableAmountHoCu, 0 As TaxAmountDaHoCu, 
	Pos.TaxValueHoCu As PUTaxableValueHoCu, DT.TaxableAmountHoCu As PUTaxableAmountHoCu, DT.TaxAmountDaHoCu As PUTaxAmountDaHoCu, Cast(1 As bit) As OnlyForPUSA,
	A.FullAddress, 'the name of: ' + A.AdviceAdrLine As PartnerText,
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

Select Distinct J.TaxReportJobNo, J.PeriodBeginDate, J.PeriodEndDate,  J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	AC.AccountCharge As ChargeAmount, 'Kontospesen' As ChargeText,
	Null As PositionID, AC.TaxReportClass As TaxReportClass, 
	Null As PositionCurrency, Null As PositionBalance, Null As InterestRate, 
	Null As PositionDescription,
	Null As AccountNo, Null As PosSequence, Null As InstrumentTypeNo, Null As ValorNo, Null As TVCurrency, Null As TVPrice,  Null As TaxPriceSourceNo,
	Null As PercentPrice, Null As TaxableValueHoCu,
	Null As ConversionCurrency, Null As ExtrateCvCuHoCu, 0 As HasUnknownIncome,
	Null As AccountOpeningDate, Null As AccountTerminationDate, Null As TaxCountry,
	Null As TransDate, Null As TransText, Null As TransQuantity, Null As TransCurrency, 
	Null As TradePrice, Null As CAQuantity, Null As TaxableAmountHoCu, Null As TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'the name of: ' + A.AdviceAdrLine As PartnerText,
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
Select J.TaxReportJobNo, J.PeriodBeginDate, J.PeriodEndDate,  J.IsForInternalUse,
	R.ID As TaxReportDataID, R.PartnerID, R.PartnerNoEdited, R.PortfolioNoEdited, R.HasPartnerSummary, R.FiscalDomicileCanton, 
	O.PortfolioNo, O.PortfolioTypeNo, O.PortfolioNoEdited As PortfolioNoText, O.TerminationDate,
	G.TaxChargeAmountHoCu As ChargeAmount, G.ChargeText,
	Null As PositionID, Pos.TaxReportClass, 
	Null As PositionCurrency, Null As PositionBalance, Null As InterestRate, 
	Null As PositionDescription,
	Null As AccountNo, Null As PosSequence, Null As InstrumentTypeNo, Null As ValorNo, Null As TVCurrency, Null As TVPrice,  Null As TaxPriceSourceNo,
	Null As PercentPrice, Null As TaxableValueHoCu,
	Null As ConversionCurrency, Null As ExtrateCvCuHoCu, 0 As HasUnknownIncome,
	Null As AccountOpeningDate, Null As AccountTerminationDate, Null As TaxCountry,
	Null As TransDate, Null As TransText, Null As TransQuantity, Null As TransCurrency, 
	Null As TradePrice, Null As CAQuantity, Null As TaxableAmountHoCu, Null As TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'the name of: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	Inner Join (
		Select CC.TaxReportDataID, CC.IsManuallyInput, CC.PortfolioID, CC.TaxChargeAmountHoCu, CC.TaxYear, 
			Case When CC.TaxReportRelChargeTypeNo=4 Then 'Account fee' Else CTx.TextShort End As ChargeText,
			CC.TaxReportRelChargeTypeNo, CO.PortfolioNoEdited, CO.PartnerID
		From PtPortfolioTaxRelevantCharge CC Inner Join PtPortfolio CO 
			On CC.PortfolioID=CO.ID And CC.HdVersionNo<999999999 
		Inner Join PtTaxReportRelChargeType CT On CC.TaxReportRelChargeTypeNo=CT.TaxReportRelChargeTypeNo
			And CT.HdVersionNo<999999999
		Inner Join AsText CTx On CTx.MasterID=CT.ID And CTx.LanguageNo=1
		Where CC.TaxChargeAmountHoCu<>0 And CC.ID Not In (Select C.ID 
			From PtPortfolioTaxRelevantCharge C Inner Join (
				Select PortfolioID, TaxYear, TaxReportRelChargeTypeNo
				From PtPortfolioTaxRelevantCharge
				Where IsManuallyInput=1) M On C.PortfolioID=M.PortfolioID
					And C.TaxYear=M.TaxYear And C.TaxReportRelChargeTypeNo=M.TaxReportRelChargeTypeNo And C.IsManuallyInput=0)
	) G On Year(J.PeriodBeginDate)=G.TaxYear And R.PartnerID=G.PartnerID
		And ((G.TaxReportRelChargeTypeNo=3 And G.IsManuallyInput=0 And G.TaxReportDataID=R.ID) 
			Or (G.TaxReportRelChargeTypeNo=3 And G.IsManuallyInput=1 And G.PartnerID=R.PartnerID)
			Or (G.TaxReportRelChargeTypeNo<>3 And G.PartnerID=R.PartnerID))
	Inner Join (Select Distinct DR.ID As TaxReportDataID, DP.PortfolioID
			From PtTaxReportData DR Inner Join PtTaxPos DP On DR.ID=DP.TaxReportDataID 
				And DP.HdVersionNo<999999999 And DR.HdVersionNo<999999999) DPP On DPP.TaxReportDataID=R.ID And G.PortfolioID=DPP.PortfolioID
	Inner Join PtPortfolio O On G.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Left Outer Join (Select TaxReportDataID, PortfolioNoEdited, MIN(TaxReportClass) As TaxReportClass
		 From PtTaxPos
		 Where HdVersionNo<999999999
		 Group By TaxReportDataID, PortfolioNoEdited) Pos On R.ID=Pos.TaxReportDataID And Pos.PortfolioNoEdited=G.PortfolioNoEdited
	Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
--Where R.ID='3B1D8B07-1F9D-4820-9978-6B23B147E3AD'

Union All

--for no pos summary
Select Distinct J.TaxReportJobNo, J.PeriodBeginDate, J.PeriodEndDate, J.IsForInternalUse,
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
	Null As PercentPrice, 0 As TaxableValueHoCu,
	Null As ConversionCurrency, Null As ExtrateCvCuHoCu, Null As HasUnknownIncome, 
	Null As AccountOpeningDate, Null As AccountTerminationDate, Null As TaxCountry,
	Null As TransDate, Null As TransText, Null TransQuantity, 
	Null As TransCurrency, 
	Null As TradePrice, Null As CAQuantity, 0 As TaxableAmountHoCu, 0 As TaxAmountDaHoCu,
	0 As PUTaxableValueHoCu, 0 As PUTaxableAmountHoCu, 0 As PUTaxAmountDaHoCu, Cast(0 As bit) As OnlyForPUSA,
	A.FullAddress, 'the name of: ' + A.AdviceAdrLine As PartnerText,
	O.CustomerReference As PortfolioText
From PtTaxReportJob J Inner Join PtTaxReportData R On J.ID=R.TaxReportJobID
		And J.HdVersionNo<999999999 And R.HdVersionNo<999999999
	-- Inner Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999
	Left Outer Join PtTaxPos Pos On R.ID=TaxReportDataID And Pos.HdVersionNo<999999999
	Right Outer Join EvTaxReportClass Ev On 1=1
	--Join PtPortfolio O On Pos.PortfolioID=O.ID --And O.HdVersionNo<999999999
	Left Outer Join PtPortfolio O On ((R.HasPartnerSummary=1 And Pos.PortfolioID=O.ID) 
		Or (R.HasPartnerSummary=0 And R.PortfolioID=O.ID))
		And (O.TerminationDate Is Null Or Year(O.TerminationDate)>=Year(J.PeriodEndDate))
                Left Outer Join PtAddress A On A.PartnerID=R.PartnerID And A.AddressTypeNo=11 And A.HdVersionNo<999999999
--Where J.TaxReportJobNo=131
Where Pos.PositionId Is Null

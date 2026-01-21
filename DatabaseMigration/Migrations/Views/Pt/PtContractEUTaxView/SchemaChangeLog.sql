--liquibase formatted sql

--changeset system:create-alter-view-PtContractEUTaxView context:any labels:c-any,o-view,ot-schema,on-PtContractEUTaxView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtContractEUTaxView
CREATE OR ALTER VIEW dbo.PtContractEUTaxView AS
Select PBA.PartnerNo,PBA.Name, PBA.FirstName, MTX.CountryForEuTax, 94 as DebitTextNo,PTX.TransDate, 
	CP.ValueDateEnd as CreditValueDate , TMC.AmountValue AS ChargeAmountChf , MTX.BaseAmountHoCu AS BaseAmountChf , ' ' AS Comment,
    	EUT.InterestTaxation , AX1.TextShort, ' ' as PublicDescription , PAD.Town , PTX.TransNo as Sequ_Trans_No
FROM	PtTransMessageTax MTX
JOIN	PtTransMessageCharge TMC ON TMC.Id = MTX.TransMessageChargeId
inner join PtTransChargeType on  TMC.TransChargeTypeId = PtTransChargeType.Id
LEFT OUTER JOIN	PtEuTaxation EUT ON EUT.TransChargeTypeId = TMC.TransChargeTypeId
LEFT OUTER JOIN AsText AX1 ON EUT.Id = AX1.MasterId AND AX1.languageNo = 2 
join PtAccountClosingPeriod CP on CP.EuTaxTransChargeId = TMC.Id 
JOIN	PtTransaction PTX ON (CP.TransactionId = PTX.Id)
	and ptx.processstatus = 1
JOIN	PtPosition POS ON POS.Id = CP.PositionId
JOIN	PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN	PtBase PBA ON PTF.PartnerId = PBA.Id 
JOIN 	PtAddress PAD ON PBA.Id = PAD.PartnerId AND PAD.AddressTypeNo = 11
JOIN	PrReference REF ON REF.Id = POS.ProdReferenceId
WHERE	MTX.HdVersionNo < 999999999 
AND	TMC.HdVersionNo < 999999999
and	eut.interesttaxation is not null

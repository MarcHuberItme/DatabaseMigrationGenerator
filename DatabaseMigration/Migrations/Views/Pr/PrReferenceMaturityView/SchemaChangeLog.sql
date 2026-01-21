--liquibase formatted sql

--changeset system:create-alter-view-PrReferenceMaturityView context:any labels:c-any,o-view,ot-schema,on-PrReferenceMaturityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrReferenceMaturityView
CREATE OR ALTER VIEW dbo.PrReferenceMaturityView AS
SELECT		TOP 100 PERCENT
		REF.Id, 
		REF.Currency, 
		REF.InterestRate, 
		REF.MaturityDate, 
		REF.IsShortToff,
		REF.SpecialKey,
		REF.ObjectId,
		REF.ObligationId,
		REF.InsurancePoliceId,  
		PDV.Id AS PublicId,
		PDV.IssuerId,
		PDV.InstrumentTypeNo,
		PDV.IsinNo,
		PDV.InstrumentStatusNo,
		PDV.NominalCurrency,
		PDV.VdfInstrumentSymbol,
		PDV.SecurityType,
		PDV.LanguageNo,
		PDV.ShortName,
		PDV.LongName, 
		PDV.PublicDescription,
		PDV.PublicDescriptionWithValNr,
		PDV.RefTypeNo,
		PDV.ProductId,
		PDV.SmallDenom,	
		CASE PDV.InstrumentTypeNo
			WHEN 5 THEN CF.PlannedEndDate
			ELSE CF.DueDate
		END AS DueDate	
FROM		PrReference REF 
JOIN		PrPublicDescriptionView PDV ON PDV.ProductId = REF.ProductId
LEFT OUTER JOIN	(SELECT	PublicId, ProdReferenceId, Max(DueDate) AS DueDate, Max(PlannedEndDate) AS PlannedEndDate
		FROM	PrPublicCf 
		WHERE	HdVersionNo < 999999999
		AND	PaymentFuncNo IN (1, 18)
		AND	CashFlowStatusNo IN (1, 13)
		GROUP BY PublicId, ProdReferenceId) AS CF ON CF.PublicId = PDV.Id
		AND (CF.ProdReferenceId IS NULL OR CF.ProdReferenceId = REF.Id)


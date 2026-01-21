--liquibase formatted sql

--changeset system:create-alter-view-PrPublicMaturityView context:any labels:c-any,o-view,ot-schema,on-PrPublicMaturityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicMaturityView
CREATE OR ALTER VIEW dbo.PrPublicMaturityView AS
SELECT		TOP 100 PERCENT
		PDV.Id ,
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
		END AS DueDate,
	                PDV.ShortNameManual,
                                PDV.LongNameManual,
                                PDV.HdPendingChanges, 
                                PDV.HdPendingSubChanges, 
                                PDV.HdVersionNo
FROM		PrPublicDescriptionView PDV 
LEFT OUTER JOIN	(SELECT	PublicId, ProdReferenceId, Max(DueDate) AS DueDate, Max(PlannedEndDate) AS PlannedEndDate
		FROM	PrPublicCf 
		WHERE	HdVersionNo < 999999999
		AND	PaymentFuncNo IN (1, 18)
		AND	CashFlowStatusNo IN (1, 13)
		GROUP BY PublicId, ProdReferenceId) AS CF ON CF.PublicId = PDV.Id
		AND CF.ProdReferenceId IS NULL 

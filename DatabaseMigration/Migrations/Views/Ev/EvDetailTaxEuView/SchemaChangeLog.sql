--liquibase formatted sql

--changeset system:create-alter-view-EvDetailTaxEuView context:any labels:c-any,o-view,ot-schema,on-EvDetailTaxEuView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvDetailTaxEuView
CREATE OR ALTER VIEW dbo.EvDetailTaxEuView AS
SELECT 	EDL.Id, EDL.HdVersionNo, EDL.HdPendingChanges, EDL.HdPendingSubChanges, 
	EDL.EventVariantId, EDL.DetailNo, EDL.DebitCurrency, EDL.CreditCurrency,
	EDX.ManEuInterestTaxCode, EDX.ManTaxEuCalcMethNo, EDX.DiscountTaxEuCalcMethNo 
FROM 	EvDetail EDL
JOIN	EvDetailTax EDX ON EDX.EventDetailId = EDL.Id AND EDX.HdVersionNo < 999999999
JOIN	EvTaxRegulation TRG ON EDX.ManEuInterestTaxCode = TRG.TaxRegulationCode
WHERE	EDL.HdVersionNo < 999999999
AND	EDX.ManEuInterestTaxCode IS NOT NULL
AND	TRG.IsNoTax = 0

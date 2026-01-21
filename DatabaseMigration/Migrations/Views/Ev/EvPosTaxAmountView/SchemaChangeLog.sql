--liquibase formatted sql

--changeset system:create-alter-view-EvPosTaxAmountView context:any labels:c-any,o-view,ot-schema,on-EvPosTaxAmountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvPosTaxAmountView
CREATE OR ALTER VIEW dbo.EvPosTaxAmountView AS
SELECT TOP 100 PERCENT
	Id, 
	HdPendingChanges,
	HdPendingSubChanges, 
	HdVersionNo,
	PosDetailId, 
	TaxOverrideTypeNo, 
	SpecialTaxText, 
	TaxRateDebit AS TaxRateAmountDebit, 
	TaxRateDa AS TaxRateAmountDa, 
	TaxRateReclaim AS TaxRateAmountReclaim, 
	TaxCurrency
FROM 	EvPosTaxAmount
WHERE	TaxOverrideTypeNo = 1
UNION
SELECT TOP 100 PERCENT
	Id, 
	HdPendingChanges,
	HdPendingSubChanges, 
	HdVersionNo,
	PosDetailId, 
	TaxOverrideTypeNo, 
	SpecialTaxText, 
	TaxAmountDebit AS TaxRateAmountDebit, 
	TaxAmountDa AS TaxRateAmountDa, 
	TaxAmountReclaim AS TaxRateAmountReclaim, 
	TaxCurrency
FROM 	EvPosTaxAmount
WHERE	TaxOverrideTypeNo = 2

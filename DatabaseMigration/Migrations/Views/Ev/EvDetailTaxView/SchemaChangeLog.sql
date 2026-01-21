--liquibase formatted sql

--changeset system:create-alter-view-EvDetailTaxView context:any labels:c-any,o-view,ot-schema,on-EvDetailTaxView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvDetailTaxView
CREATE OR ALTER VIEW dbo.EvDetailTaxView AS
SELECT TOP 100 PERCENT
    		EDT.Id, 
    		EDT.HdPendingChanges,
    		EDT.HdPendingSubChanges, 
    		EDT.HdVersionNo,
    		EDT.EventDetailId, 
    		EDT.ManTaxRegulationCode, 
    		EDT.NodeSecondTree, 
    		EDT.SlpEuInterestTaxCode, 
    		EDT.ManEuInterestTaxCode,
		TRE.Id AS TaxRegulationId, 
    		TRE.TaxCountry,
                                TRE.TaxReportClass,
                                TRE.ManuallyInput, 
    		TPE.ValidFrom, 
                                TRT.Id AS TaxRateId, 
                                0 AS TaxRatePendChanges,
		TRT.TaxTypeNo,
    		TRT.TaxRateDebit,  
    		TRT.TaxRateDa, 
    		TRT.TaxRateReclaim
FROM  		EvDetailTax EDT 
JOIN		EvTaxRegulation TRE ON EDT.ManTaxRegulationCode = TRE.TaxRegulationCode
LEFT OUTER JOIN	EvTaxPeriod TPE ON TRE.Id = TPE.TaxRegulationId AND TPE.HdVersionNo < 999999999
LEFT OUTER JOIN	EvTaxRate TRT ON TPE.Id = TRT.TaxPeriodId AND TRT.HdVersionNo < 999999999
WHERE		TRE.ManuallyInput = 0	
UNION
SELECT TOP 100 PERCENT
    		EDT.Id, 
    		EDT.HdPendingChanges,
    		EDT.HdPendingSubChanges, 
    		EDT.HdVersionNo,
    		EDT.EventDetailId, 
    		EDT.ManTaxRegulationCode, 
    		EDT.NodeSecondTree, 
    		EDT.SlpEuInterestTaxCode, 
   	 	EDT.ManEuInterestTaxCode,
		TRE.Id AS TaxRegulationId, 
    		DRT.TaxCountry,
                                TRE.TaxReportClass,
                                TRE.ManuallyInput, 
   		NULL,
                                DRT.Id AS TaxRateId, 
                                DRT.HdPendingChanges AS TaxRatePendChanges,
    		DRT.TaxTypeNo,
    		DRT.TaxRateDebit,  
    		DRT.TaxRateDa, 
    		DRT.TaxRateReclaim
FROM  		EvDetailTax EDT 
JOIN		EvTaxRegulation TRE ON EDT.ManTaxRegulationCode = TRE.TaxRegulationCode
LEFT OUTER JOIN	EvDetailTaxRate DRT ON EDT.Id = DRT.EventDetailTaxId AND DRT.HdVersionNo < 999999999
WHERE		TRE.ManuallyInput = 1
UNION
SELECT TOP 100 PERCENT
    		EDT.Id, 
    		EDT.HdPendingChanges,
    		EDT.HdPendingSubChanges, 
    		EDT.HdVersionNo,
    		EDT.EventDetailId, 
    		EDT.ManTaxRegulationCode, 
    		EDT.NodeSecondTree, 
    		EDT.SlpEuInterestTaxCode, 
   	 	EDT.ManEuInterestTaxCode,
		NULL, 
		NULL, 
		NULL, 
		NULL, 
   		NULL,
		NULL, 
		NULL, 
		NULL, 
		NULL, 
		NULL, 
		NULL
FROM  		EvDetailTax EDT 
WHERE		EDT.ManTaxRegulationCode IS NULL

--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioTaxRelevantCharge context:any labels:c-any,o-view,ot-schema,on-PtPortfolioTaxRelevantCharge,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioTaxRelevantCharge
CREATE OR ALTER VIEW dbo.PtPortfolioTaxRelevantCharge AS
Select Id, HdCreateDate, HdCreator, HdChangeDate, HdEditStamp, HdVersionNo, 
	HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, 
	PortfolioId, TaxReportRelChargeTypeNo, TaxYear, 
	TaxChargeAmountHoCu, 
	TaxChargeAmountWithoutVatHoCu, 
	TaxReportDataId, IsManuallyInput, 1 As SubCharges
From PtPortfolioTaxChargeDetail
Where HdVersionNo<999999999 And TaxReportRelChargeTypeNo=3

UNION

SELECT PortfolioId As Id, Null As HdCreateDate, Null As HdCreator, Null As HdChangeDate, 
Null As HdEditStamp, 1 As HdVersionNo, Null As HdProcessId, Null As HdStatusFlag, 
Null As HdNoUpdateFlag, Null As HdPendingChanges, Null As HdPendingSubChanges, Null As HdTriggerControl, 
	PortfolioId, TaxReportRelChargeTypeNo, TaxYear, 
	Sum(TaxChargeAmountHoCu) As TaxChargeAmountHoCu, 
	Sum(TaxChargeAmountWithoutVatHoCu) As TaxChargeAmountWithoutVatHoCu, 
	Null As TaxReportDataId, 0 As IsManuallyInput, Count(TaxChargeAmountHoCu) As SubCharges
From PtPortfolioTaxChargeDetail
Where HdVersionNo<999999999 And TaxReportRelChargeTypeNo<>3
Group By PortfolioId, TaxReportRelChargeTypeNo, TaxYear


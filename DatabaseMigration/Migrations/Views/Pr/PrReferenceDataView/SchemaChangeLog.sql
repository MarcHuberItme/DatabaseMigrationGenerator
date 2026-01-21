--liquibase formatted sql

--changeset system:create-alter-view-PrReferenceDataView context:any labels:c-any,o-view,ot-schema,on-PrReferenceDataView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrReferenceDataView
CREATE OR ALTER VIEW dbo.PrReferenceDataView AS
SELECT TOP 100 PERCENT
    REF.Id, 
    REF.HdPendingChanges,
    REF.HdPendingSubChanges, 
    REF.HdVersionNo,
    REF.ProductId, 
    REF.Currency,
    REF.MaturityDate, 
    REF.InterestRate, 
    REF.IsShortToff,  
    REF.SpecialKey, 
    IsNull(CONVERT(VARCHAR, REF.InterestRate) + ' % ', '')
	+ IsNull(CONVERT(VARCHAR, REF.MaturityDate, 104), '') 
	+ IsNull(REF.SpecialKey, '')
	+ IsNull(CONVERT(VARCHAR, OBT.ObjectSeqNo), '') 
	+ IsNull(CONVERT(VARCHAR, POL.ObjectSeqNo), '') 
	+ IsNull(CONVERT(VARCHAR, OBL.ObjectSeqNo), '') 
	AS ReferenceData
FROM PrReference REF
LEFT OUTER JOIN PrObject OBT ON OBT.Id  = REF.ObjectId
LEFT OUTER JOIN PrInsurancePolice POL ON POL.Id  = REF.InsurancePoliceId
LEFT OUTER JOIN ReObligation OBL ON OBL.Id  = REF.ObligationId

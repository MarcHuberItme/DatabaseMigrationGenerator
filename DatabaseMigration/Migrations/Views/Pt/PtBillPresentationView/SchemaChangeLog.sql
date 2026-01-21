--liquibase formatted sql

--changeset system:create-alter-view-PtBillPresentationView context:any labels:c-any,o-view,ot-schema,on-PtBillPresentationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtBillPresentationView
CREATE OR ALTER VIEW dbo.PtBillPresentationView AS
SELECT pv.Id AS PartnerId, pv.PartnerNo,
pbp.Id, pbp.ConsolidatorNo, pbp.BillerName, pbp.BillAmount, pbp.PresentmentState, pbp.BillDueDate,
pbp.HdVersionNo, pbp.HdChangeDate, pbp.HdCreator, pbp.HdChangeuser, pbp.HdPendingChanges, pbp.HdPendingSubChanges
FROM PtDescriptionView AS pv
LEFT OUTER JOIN PtAgrEbanking AS eb on pv.Id = eb.PartnerId
LEFT OUTER JOIN PtBillPresentation AS pbp ON eb.id = pbp.EbankingId
WHERE pbp.ConsolidatorNo = 1 OR pbp.ConsolidatorNo = 2

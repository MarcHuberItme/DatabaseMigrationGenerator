--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentRejectReasonView context:any labels:c-any,o-view,ot-schema,on-PtPaymentRejectReasonView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentRejectReasonView
CREATE OR ALTER VIEW dbo.PtPaymentRejectReasonView AS
SELECT PtPaymentRejectReason.Id, HdVersionNo, IsRelevantToCustomer, RejectCode, TextLong AS Description, LanguageNo FROM PtPaymentRejectReason
LEFT JOIN AsText ON MasterId = PtPaymentRejectReason.Id

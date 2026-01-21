--liquibase formatted sql

--changeset system:create-alter-view-ExportContactReportsView context:any labels:c-any,o-view,ot-schema,on-ExportContactReportsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportContactReportsView
CREATE OR ALTER VIEW dbo.ExportContactReportsView AS
SELECT      CR.Id as contactReport_id
            , CR.Text
            , CR.ReportText
            , ADI.DocumentId as contactReport_document_id
            , SXCR.TradingOrderMessageId as contactReport_sx_tradingOrderMessage_id
            , CR.OpenIssueId as contactREport_openIssue_id
            , PTOM.TradingOrderId as contactReport_sx_tradingOrder_Id
FROM        PtBase PB
JOIN        PtContactReport CR ON CR.PartnerId = PB.Id
LEFT JOIN   AsDocumentIndex ADI ON ADI.SourceRecordId = CR.Id
LEFT JOIN   PtTransSxContactReport SXCR ON SXCR.ContactReportId = CR.Id
LEFT JOIN   PtTradingOrderMessage PTOM ON PTOM.Id = SXCR.TradingOrderMessageId
LEFT JOIN   PtTradingOrder PTO ON PTO.Id = PTOM.TradingOrderId
WHERE       CR.HdVersionNo BETWEEN 1 AND 999999998

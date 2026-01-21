--liquibase formatted sql

--changeset system:create-alter-view-PtExportTransItemView context:any labels:c-any,o-view,ot-schema,on-PtExportTransItemView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtExportTransItemView
CREATE OR ALTER VIEW dbo.PtExportTransItemView AS
SELECT top 100 Percent eti.Id, eti.HdVersionNo, eti.HdPendingChanges, eti.HdPendingSubChanges, eti.HdStatusFlag, eti.HdCreator, eti.HdChangeUser, eti.HdCreateDate, eti.HdChangeDate, eti.HdProcessId, eti.HdEditStamp, er.ExportNo, er.FileTypeNo, er.ExportTypeNo, bas.PartnerNo,
       bas.PtDescription, acc.AccountNo, acc.AccountNoEdited, eti.ExternalId, eti.IsSecuritiesBooking, ti.TransDate, ti.RealDate, ti.ValueDate, ti.DebitAmount, 
       ti.CreditAmount, ti.TextNo, ti.TransText, msg.CreditPaymentInformation, eti.QualiCode, er.ProcessId, acc.Id As AccountId,
       ti.MessageId
FROM PtExportTransItem eti
    JOIN PtExportRun er on er.ExportNo = eti.ExportNo
    JOIN PtTransItem ti ON ti.id = eti.TransItemId and ti.HdVersionNo between 1 and 999999998
    JOIN PtPosition pos ON pos.Id = ti.PositionId
    JOIN PrReference ref on ref.Id = pos.ProdReferenceId
    JOIN PtAccountBase acc on acc.Id = ref.AccountId
    JOIN PtPortfolio por on por.Id = acc.PortfolioId
    JOIN PtDescriptionView bas ON bas.Id = por.PartnerId
    LEFT OUTER JOIN PtTransMessage msg on msg.ID = ti.MessageId

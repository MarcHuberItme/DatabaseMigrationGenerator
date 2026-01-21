--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSInitPartnetList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSInitPartnetList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSInitPartnetList
CREATE OR ALTER PROCEDURE dbo.GetPMSInitPartnetList
@TransDate DateTime
As
Declare @TransferProcessId as UniqueIdentifier
Select @TransferProcessId=ID from PtPMSTransferProcess Where TransDate = @TransDate and TransferTypeCode = 1

Select TransDate,PtPMSPartnerTransfer.PartnerId,LastTransferProcessId, StartRefDate from PtPMSPartnerTransfer
inner join PtPMSTransferProcess on  PtPMSPartnerTransfer.LastTransferProcessId = PtPMSTransferProcess.Id
left outer join PtInsaPartner on PtPMSPartnerTransfer.PartnerId = PtInsaPartner.PartnerId
Where LastTransferProcessId = @TransferProcessId
and LastNetFReturnCode=0
and PtPMSPartnerTransfer.HdCreateDate = PtPMSPartnerTransfer.HdChangeDate
and PtPMSTransferProcess.TransDate =
(
Select min(TransDate) from PtPMSPartnerTransfer pt
inner join PtPMSTransferProcess p on  pt.LastTransferProcessId = p.Id
Where pt.PartnerId = PtPMSPartnerTransfer.PartnerId
)

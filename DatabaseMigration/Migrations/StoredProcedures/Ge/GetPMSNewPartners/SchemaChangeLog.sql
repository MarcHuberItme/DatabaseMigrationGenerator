--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSNewPartners context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSNewPartners,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSNewPartners
CREATE OR ALTER PROCEDURE dbo.GetPMSNewPartners
@TransferProcessId as UniqueIdentifier
As

Select TransDate,PtPMSPartnerTransfer.PartnerId,LastTransferProcessId, StartRefDate from PtPMSPartnerTransfer
inner join PtPMSTransferProcess on  PtPMSPartnerTransfer.LastTransferProcessId = PtPMSTransferProcess.Id
left outer join PtInsaPartner on PtPMSPartnerTransfer.PartnerId = PtInsaPartner.PartnerId
Where LastTransferProcessId = @TransferProcessId
and PtPMSTransferProcess.TransDate =
(
Select min(TransDate) from PtPMSPartnerTransfer pt
inner join PtPMSTransferProcess p on  pt.LastTransferProcessId = p.Id
Where pt.PartnerId = PtPMSPartnerTransfer.PartnerId
) 

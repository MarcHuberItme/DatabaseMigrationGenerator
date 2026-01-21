--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPartnerListSelective context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPartnerListSelective,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPartnerListSelective
CREATE OR ALTER PROCEDURE dbo.GetPMSPartnerListSelective
@LastRunDate DateTime, @LastRunId UniqueIdentifier, @RC int, @PartnerNoOwn decimal (11,0)
AS

Select top (@RC) PtPMSPartnerTransfer.Id,PtPMSPartnerTransfer.HdVersionNo,PtPMSPartnerTransfer.HdCreator,PtPMSPartnerTransfer.HdChangeUser, LastTransferProcessId, 
PtPMSPartnerTransfer.LastNetFReturnCode,PtPMSPartnerTransfer.LastNetFErrorText, PtPMSPartnerTransfer.InternalRejectCode,PtBase.Id as PartnerId , PartnerRefCurrency
from PtInsaPartner
left outer join PtPMSPartnerTransfer on PtInsaPartner.PartnerId = PtPMSPartnerTransfer.PartnerId
inner join PtBase on PtInsaPartner.PartnerId = PtBase.Id  
left outer join PtAddress on PtBase.Id = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
Where (PtPMSPartnerTransfer.LastTransferProcessId is null)  or ((PtBase.HdChangeDate > @LastRunDate or PtAddress.HdChangeDate >= @LastRunDate) And PtPMSPartnerTransfer.LastTransferProcessId <> @LastRunId) 
And (PtBase.PartnerNo <> @PartnerNoOwn)
And (PtBase.TerminationDate is null or PtBase.TerminationDate > @LastRunDate)


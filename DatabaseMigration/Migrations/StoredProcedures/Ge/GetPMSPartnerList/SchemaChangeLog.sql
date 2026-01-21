--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPartnerList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPartnerList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPartnerList
CREATE OR ALTER PROCEDURE dbo.GetPMSPartnerList
@LastRunDate DateTime, @LastRunId UniqueIdentifier, @RC int, @PartnerNoOwn decimal (11,0)
AS
Select top (@RC) PtPMSPartnerTransfer.Id,PtPMSPartnerTransfer.HdVersionNo,PtPMSPartnerTransfer.HdCreator,PtPMSPartnerTransfer.HdChangeUser, LastTransferProcessId, 
PtPMSPartnerTransfer.LastNetFReturnCode,PtPMSPartnerTransfer.LastNetFErrorText,PtBase.Id as PartnerId,InternalRejectCode, PartnerRefCurrency from PtPMSPartnerTransfer 
Right outer join PtBase on PtPMSPartnerTransfer.PartnerId = PtBase.Id  
inner join PtServiceLevel on PtServiceLevel.ServiceLevelNo = PtBase.ServiceLevelNo and IsForPMS=1
left outer join PtAddress on PtBase.Id = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
Where (PtPMSPartnerTransfer.Id is null)  or ((PtBase.HdChangeDate > @LastRunDate or PtAddress.HdChangeDate >= @LastRunDate) And PtPMSPartnerTransfer.LastTransferProcessId <> @LastRunId) 
And (PtBase.PartnerNo <> @PartnerNoOwn)
And (PtBase.TerminationDate is null or PtBase.TerminationDate > @LastRunDate)


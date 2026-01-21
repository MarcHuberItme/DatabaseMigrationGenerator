--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSProposalSecurityList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSProposalSecurityList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSProposalSecurityList
CREATE OR ALTER PROCEDURE dbo.GetPMSProposalSecurityList
@LastRunDate DateTime, @CurrentRunId UniqueIdentifier,  @RC int
As
Select  
top (@RC) PrPublic.Id as PublicId, PtPMSPropInstrTransfer.Id,PtPMSPropInstrTransfer.HdVersionNo,PtPMSPropInstrTransfer.HdCreator,PtPMSPropInstrTransfer.HdChangeUser, PtPMSPropInstrTransfer.LastTransferProcessId, 
PtPMSPropInstrTransfer.LastNetFReturnCode,PtPMSPropInstrTransfer.LastNetFErrorText, InternalRejectCode 
from  PtPMSProposalInstrument

inner join PrPublic on PtPMSProposalInstrument.PublicId = PrPublic.Id
left outer join PtPMSPropInstrTransfer on PrPublic.Id = PtPMSPropInstrTransfer.PublicId
Where   (PtPMSProposalInstrument.HdVersionNo between 1 and 999999998)
And   ((PtPMSPropInstrTransfer.LastTransferProcessId is null)  or (PrPublic.HdChangeDate > @LastRunDate And PtPMSPropInstrTransfer.LastTransferProcessId <> @CurrentRunId))
AND PtPMSProposalInstrument.PublicId not in (Select PublicProdId from PtPMSSecurityTransfer)

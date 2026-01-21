--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecurityList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecurityList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecurityList
CREATE OR ALTER PROCEDURE dbo.GetPMSSecurityList
@LastRunDate DateTime, @CurrentRunId UniqueIdentifier,  @RC int,@publicId UniqueIdentifier
AS
Select  top (@RC) PrPublic.Id as PublicProdId, PtPMSSecurityTransfer.Id,PtPMSSecurityTransfer.HdVersionNo,PtPMSSecurityTransfer.HdCreator,PtPMSSecurityTransfer.HdChangeUser, PtPMSSecurityTransfer.LastTransferProcessId, 
PtPMSSecurityTransfer.LastNetFReturnCode,PtPMSSecurityTransfer.LastNetFErrorText, InternalRejectCode from  PrPublic
Inner join PrPublicRefType on  PrPublicRefType.RefTypeNo = PrPublic.RefTypeNo

inner join 

(Select distinct PrPublic.ProductId  from PrPublic
inner join PrReference on PrReference.ProductId = PrPublic.ProductId
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId  /*and PtPosition.Quantity <> 0*/ ) a on a.ProductId = PrPublic.ProductId
left outer join PtPMSSecurityTransfer on PtPMSSecurityTransfer.PublicProdId = PrPublic.Id
Where PrPublicRefType.IsForPMS = 1
and  PrPublicRefType.HdVersionNo between 1 and 999999998
/*and  PrPublic.HdVersionNo between 1 and 999999998*/
And 
(

	(
		@publicId is null and 
		(
			(PtPMSSecurityTransfer.LastTransferProcessId is null)  or (PrPublic.HdChangeDate > @LastRunDate And PtPMSSecurityTransfer.LastTransferProcessId <> @CurrentRunId) 
		)
	)

or
	(
		Prpublic.Id = @publicId
	)

)

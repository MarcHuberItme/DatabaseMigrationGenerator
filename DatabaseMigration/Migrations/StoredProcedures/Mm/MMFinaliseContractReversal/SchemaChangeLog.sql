--liquibase formatted sql

--changeset system:create-alter-procedure-MMFinaliseContractReversal context:any labels:c-any,o-stored-procedure,ot-schema,on-MMFinaliseContractReversal,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MMFinaliseContractReversal
CREATE OR ALTER PROCEDURE dbo.MMFinaliseContractReversal
@ContractId uniqueidentifier,
@StatusCode int,
@IsToMarkReset bit
As

/*update PtPaymentOrder Set Status = 13 from PtContractPartner
inner join PtPaymentOrder on PtContractPartner.OrderIdCapitalPayment = PtPaymentOrder.Id
where PtContractPartner.ContractId = @ContractId*/

Select * from PtContractPartner
inner join PtContractPartnerPayment on PtContractPartnerPayment.ContractPartnerId = PtContractPartner.Id
inner join PtPaymentOrder on PtContractPartnerPayment.OrderIdCapitalPayment = PtPaymentOrder.Id
where PtContractPartner.ContractId =  @ContractId

If @StatusCode  = 99
Begin
       update PtAccountBase Set TerminationDate = getdate() from PtContractPartner
       inner join PtAccountBase on PtContractPartner.MMAccountNo = PtAccountBase.AccountNo
       where PtContractPartner.ContractId = @ContractId
End

update PtContract Set Status = @StatusCode, IsContractReset =  @IsToMarkReset where Id = @ContractId

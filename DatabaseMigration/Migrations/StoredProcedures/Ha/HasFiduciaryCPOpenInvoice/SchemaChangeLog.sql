--liquibase formatted sql

--changeset system:create-alter-procedure-HasFiduciaryCPOpenInvoice context:any labels:c-any,o-stored-procedure,ot-schema,on-HasFiduciaryCPOpenInvoice,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure HasFiduciaryCPOpenInvoice
CREATE OR ALTER PROCEDURE dbo.HasFiduciaryCPOpenInvoice
@accountNo decimal (11,0),
@valueDate datetime
As
declare @debitControlId UniqueIdentifier 
declare @CounterPartyhasPendingAdvice bit

Set @CounterPartyhasPendingAdvice = 0

select @debitControlId  = PtAccountDebitControl.Id from PtCOntractPartner 
inner join PtContract on PtCOntractPartner.ContractId = PtContract.Id
inner join PtContractPartner CP on PtCOntractPartner.COntractID = CP.ContractId and CP.Id <> PtCOntractPartner.Id
inner join PtAccountBase  on CP.MMAccountNo = PtAccountBase.AccountNo
inner join PrReference on PtAccountBase.Id = PrReference.AccountId
inner join PtPosition on PrReference.Id = PtPosition.ProdReferenceId
inner join PtAccountDebitControl on PtAccountBase.Id = PtAccountDebitControl.AccountId and PtAccountDebitControl.CompletionDate is null
 and PtAccountDebitControl.InvoiceValueDate = @ValueDate and RelatedTableName = 'PtAccountClosingPeriod'
Where PtCOntractPartner.MMAccountNo=@accountNo

if @debitControlId is not null
	Set @CounterPartyhasPendingAdvice = 1

select @CounterPartyhasPendingAdvice as CounterPartyhasPendingAdvice


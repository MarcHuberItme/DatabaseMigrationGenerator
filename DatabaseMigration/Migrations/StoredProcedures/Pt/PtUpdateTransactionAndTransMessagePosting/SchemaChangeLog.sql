--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateTransactionAndTransMessagePosting context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateTransactionAndTransMessagePosting,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateTransactionAndTransMessagePosting
CREATE OR ALTER PROCEDURE dbo.PtUpdateTransactionAndTransMessagePosting
@TransMessageId uniqueidentifier
As
DECLARE @TransactionId uniqueidentifier
DECLARE @TotalPosted int
DECLARE @TotalExternal int

update PtTransMessage set CommStatus = 1 where Id = @TransMessageId

Select @TransactionId = TransactionId from PtTransMessage where Id = @TransMessageId

select @TotalPosted = count(*)  from PtTransMessage where CommStatus = 1 and TransactionId = @TransactionId
and (upper(CreditMessageStandard) <> 'INTERNAL') and (CreditMessageStandard is not null)

select @TotalExternal = count(*)  from PtTransMessage where (upper(CreditMessageStandard) <> 'INTERNAL') and (CreditMessageStandard is not null)  and (CommStatus <> 3)
and (TransactionId = @TransactionId)

if (@TotalPosted = @TotalExternal )
Begin
	update PtTransaction set ScannedForPosting = 1 where Id = @TransactionId
end 

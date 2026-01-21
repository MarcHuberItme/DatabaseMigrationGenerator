--liquibase formatted sql

--changeset system:create-alter-procedure-IsRefProductWithdrawCommRelevant context:any labels:c-any,o-stored-procedure,ot-schema,on-IsRefProductWithdrawCommRelevant,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsRefProductWithdrawCommRelevant
CREATE OR ALTER PROCEDURE dbo.IsRefProductWithdrawCommRelevant
@PrReferenceId UniqueIdentifier
As
select WithdrawCommRelevant from PrReference
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
Where PrReference.Id = @PrReferenceId

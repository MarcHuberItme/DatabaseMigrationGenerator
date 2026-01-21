--liquibase formatted sql

--changeset system:create-alter-procedure-GetWithdrawRuleException context:any labels:c-any,o-stored-procedure,ot-schema,on-GetWithdrawRuleException,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetWithdrawRuleException
CREATE OR ALTER PROCEDURE dbo.GetWithdrawRuleException
@DebitPrRefId UniqueIdentifier, @CreditPrRefId UniqueIdentifier, @ReferenceDate as datetime
As

declare @DebitProductNo int
declare @CreditProductNo int
declare @DebitPartnerId UniqueIdentifier
declare @CreditPartnerId UniqueIdentifier
declare @RelationTypeNo int

Select @DebitProductNo = PrPrivate.ProductNo, @DebitPartnerId = PtPortfolio.PartnerId  from PrReference
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
inner join PtAccountBase on PrReference.AccountId = PtAccountBase.Id
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
Where PrReference.Id = @DebitPrRefId

Select @CreditProductNo = PrPrivate.ProductNo, @CreditPartnerId = PtPortfolio.PartnerId from PrReference
inner join PrPrivate on PrReference.ProductId = PrPrivate.ProductId
inner join PtAccountBase on PrReference.AccountId = PtAccountBase.Id
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
Where PrReference.Id = @CreditPrRefId

if @DebitPartnerId <> @CreditPartnerId
Begin
	select @RelationTypeNo =RelationTypeNo from PtRelationMaster
	inner  join PtRelationSlave on (PtRelationMaster.Id = PtRelationSlave.MasterId) and (ValidTo is null or ValidTo >= @ReferenceDate)
	Where PtRelationMaster.PartnerId = @DebitPartnerId
	and PtRelationMaster.HdVersionNo between 1 and 999999998
	and PtRelationSlave.HdVersionNo between 1 and 999999998
	and PtRelationSlave.PartnerId = @CreditPartnerId
End 

select PrNonTerminationException.Id, ProductNo, CreditProducTNo, CreditRelationTypeNo,@DebitPartnerId as DebitPartnerId,@CreditPartnerId as CreditPartnerId,@RelationTypeNo as PartnerRelationTypeNo,OwnPartnerRelevant
from PrNonTerminationException
Where ProductNo = @DebitProductNo and CreditProductNo = @CreditProductNo

--liquibase formatted sql

--changeset system:create-alter-procedure-MatchAndGetAcctPaymentInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-MatchAndGetAcctPaymentInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MatchAndGetAcctPaymentInfo
CREATE OR ALTER PROCEDURE dbo.MatchAndGetAcctPaymentInfo
@isDebit bit, @AccountNo varchar(16), @AccountNoIbanElect nvarchar (21)
As

declare @AccountId UniqueIdentifier

if  (len(@AccountNo) > 0) and (isnumeric(@AccountNo)=1) and (@AccountNo <> '0')
	select  @AccountId = Id from PtAccountBase Where AccountNo = @AccountNo


if @AccountId is null and len(@AccountNo) > 0 and (@AccountNo <> '0')
	select  @AccountId = Id from PtAccountBase Where FormerAccountNo = @AccountNo

if @AccountId is null and len(@AccountNoIbanElect) > 0
	select  @AccountId = Id from PtAccountBase Where AccountNoIbanElect = @AccountNoIbanElect

if @AccountId is null and len(@AccountNoIbanElect) > 0
	select  @AccountId = Id from PtAccountBase Where FormerAccountNoIbanElect = @AccountNoIbanElect


Select PtAccountBase.Id, AccountNo, PrReference.Currency ,
ISNULL(PrPrivatePayRule.AllowsPayments, 0) AS AllowsPayments,  
ISNULL(PrPrivate.IsDueRelevant, 0) as IsDueRelevant,
PtAddress.FullAddress, PtAddress.AdviceAdrLine ,PtAccountBase.TerminationDate 
from PtAccountBase 
 
inner join PrReference on PtAccountBase.Id = PrReference.AccountId  
inner join PrPrivate on PrPrivate.ProductId = PrReference.ProductId  
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
left outer join PtAddress on PtPortfolio.PartnerId = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
Left outer join PrPrivatePayRule on (@IsDebit = 0 and PrPrivate.PayInRuleNo = PrPrivatePayRule.PayRuleNo)  
				 or (@IsDebit = 1 and PrPrivate.PayOutRuleNo = PrPrivatePayRule.PayRuleNo)  
Where (PtAccountBase.Id = @AccountId)  
	And (PtAccountBase.HdVersionNo between 1 and 99999998)   
	And (PrReference.HdVersionNo between 1 and 99999998)   
	and (PrPrivate.HdVersionNo between 1 and 99999998)   



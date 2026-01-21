--liquibase formatted sql

--changeset system:create-alter-procedure-GetMMCommissionInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMMCommissionInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMMCommissionInfo
CREATE OR ALTER PROCEDURE dbo.GetMMCommissionInfo
@AccountId UniqueIdentifier, @AccountCurrency char(3),  @ValueDateClosing dateTime
As
Select PtContractPartner.Commission as FixCommission, PtMMCommissionRule.CommissionTypeNo,
PtMMCommissionRule.Currency,
PtMMCommissionRule.MinCommission,
PtMMCommissionRule.MaxCommission,
PtMMCommissionRule.ValidFrom,
PtMMCommissionRule.MaxInterestPercentage,
PtMMCommissionPrice.CommissionRuleId,
PtMMCommissionPrice.StartAmount,
PtMMCommissionPrice.Price, PtContractPartner.Id As ContractPartnerInvestorId, ISNULL(abs(PtAccountClosingPeriod.BalanceValueEnd),PtContractPartner.ContributionAmount) as ContributionAmount, PtFiscalCountry.CountryCode,PtContract.DateFrom, PtContractPartner.IsInvestor, 
PtContractType.IsCallContract, PtContractType.FiduciaryCommOnLender, PtBase.LegalStatusNo, PtRelationSlave.RelationRoleNo,Ben.CountryCode as FinBenCountryCode, PtProfile.OffshoreStatusNo
from PtAccountBase
Inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id 
Inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
Inner join PtContractPartner on PtContractPartner.MMAccountNO = PtAccountBase.AccountNo 
Inner join PtContract on PtContractPartner.ContractID = PtContract.Id 
Inner join PtContractType on PtContract.ContractType = PtContractType.ContractType
Inner Join PrReference ON PrReference.AccountId = PtAccountBase.Id and PrReference.Currency = @AccountCurrency
Inner Join PtPosition ON PtPosition.PortfolioId = PtPortfolio.Id and PtPosition.ProdReferenceId = PrReference.Id

Left Outer Join PtAccountClosingPeriod On PtAccountClosingPeriod.PositionId = PtPosition.Id and PtAccountClosingPeriod.PeriodType = 1 and PtAccountClosingPeriod.ValueDateEnd = @ValueDateClosing and 
PtAccountClosingPeriod.ClosingRepeatCounter = 1

left outer join PtCommissionType on PtContract.CommissionType= PtCommissionType.CommissionTypeNo 
left outer join PtMMCommissionRule on PtCommissionType.CommissionTypeNo = PtMMCommissionRule.CommissionTypeNo and PtMMCommissionRule.HdVersionNo between 1 and 999999998

left outer join PtFiscalCountry on PtFiscalCountry.PartnerId = PtPortfolio.PartnerId And PtFiscalCountry.IsPrimaryCountry = 1 
left outer join PtMMCommissionPrice on PtMMCommissionRule.Id = PtMMCommissionPrice.CommissionRuleId and PtMMCommissionPrice.HdVersionNo between 1 and 999999998
left outer join PtRelationMaster on PtBase.Id = PtRelationMaster.PartnerId and PtRelationMaster.RelationTypeNo = 20 and PtRelationMaster.HdVersionNo between 1 and 999999998
left outer join PtRelationSlave  on PtRelationMaster.Id = PtRelationSlave.MasterId and PtRelationSlave.HdVersionNo between 1 and 999999998
left outer join PtFiscalCountry Ben on Ben.PartnerId = PtRelationSlave.PartnerId And Ben.IsPrimaryCountry = 1 
left outer join PtProfile on PtBase.Id = PtProfile.PartnerId
Where PtAccountbase.Id = @AccountId
And 
(
(
(PtMMCommissionRule.Currency = @AccountCurrency or PtMMCommissionRule.Currency is null) 
And isnull(PtMMCommissionPrice.StartAmount,0) <= PtContract.Amount And PtMMCommissionRule.ValidFrom <= @ValueDateClosing
)
or
(
PtContractPartner.Commission > 0
)
)
And ((PtContractPartner.IsInvestor = 1 and PtContractType.FiduciaryCommOnLender = 1) Or (PtContractPartner.IsInvestor = 0 and PtContractType.FiduciaryCommOnLender = 0))
And PtContract.DateFrom < @ValueDateClosing
Order by PtContract.DateFrom desc, PtMMCommissionRule.Currency desc, PtMMCommissionRule.ValidFrom desc, PtMMCommissionPrice.StartAmount 

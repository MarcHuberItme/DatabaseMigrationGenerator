--liquibase formatted sql

--changeset system:create-alter-procedure-GetClosingInfoForAPosition context:any labels:c-any,o-stored-procedure,ot-schema,on-GetClosingInfoForAPosition,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetClosingInfoForAPosition
CREATE OR ALTER PROCEDURE dbo.GetClosingInfoForAPosition
@PositionId uniqueidentifier
As 

DECLARE @IsDueRelevant as bit
DECLARE @strAccCurrency as char(3)
DECLARE @RndType as int
DECLARE @PrPrivateId as uniqueidentifier

DECLARE @DebitInterestAccNo as decimal(11,0)
DECLARE @CreditInterestNoTaxAccNo as decimal(11,0)
DECLARE @CreditInterestWithTaxAccNo as decimal(11,0)
DECLARE @CommissionAccNo as decimal(11,0)
DECLARE @ProvisionAccNo as decimal(11,0)
DECLARE @SpecialCommissionAccNo as decimal(11,0)
DECLARE @GeneralExpensesAccNo as decimal(11,0)
DECLARE @WithholdingTaxAccNo as decimal(11,0)
DECLARE @BonusAccNo as decimal(11,0)

DECLARE @DebitInterestProdRefId as uniqueidentifier
DECLARE @CreditInterestNoTaxProdRefId as uniqueidentifier
DECLARE @CreditInterestWithTaxProdRefId as uniqueidentifier
DECLARE @CommissionProdRefId as uniqueidentifier
DECLARE @ProvisionProdRefId as uniqueidentifier
DECLARE @SpecialCommissionProdRefId as uniqueidentifier
DECLARE @GeneralExpensesProdRefId as uniqueidentifier
DECLARE @WithholdingTaxProdRefId as uniqueidentifier
DECLARE @BonusProdRefId as uniqueidentifier


--Obtain Account Currency, Customer Account Currency RndType
select @strAccCurrency=PrReference.Currency,
	@RndType=CyBase.RndTypeAmount,
	@IsDueRelevant=PrPrivate.IsDueRelevant,
	@PrPrivateId=PrPrivate.Id,
	@DebitInterestAccNo=PrPrivate.DebitInterestAccNo,
	@CreditInterestNoTaxAccNo=PrPrivate.CreditInterestNoTaxAccNo,
	@CreditInterestWithTaxAccNo=PrPrivate.CreditInterestWithTaxAccNo,
	@CommissionAccNo=PrPrivate.CommissionAccNo,
	@ProvisionAccNo=PrPrivate.ProvisionAccNo,
	@SpecialCommissionAccNo=PrPrivate.SpCommissionAccNo,
	@GeneralExpensesAccNo = PrPrivate.ExpenesAccNo,
	@BonusAccNo = PrPrivate.BonusAccNo,
	@WithholdingTaxAccNo =PrPrivate.WithholdingTax

from PrReference 
INNER JOIN PtPosition On PrReference.Id = PtPosition.ProdReferenceId
INNER JOIN CyBase On CyBase.Symbol = PrReference.Currency
INNER JOIN PrPrivate ON PrPrivate.ProductId = PrReference.ProductId
Where PtPosition.Id = @PositionId

if(@DebitInterestAccNo is not null)
begin
	select	@DebitInterestProdRefId = PrReference.Id
	from PrReference INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @DebitInterestAccNo
	and PrReference.Currency = @strAccCurrency
	if(@DebitInterestProdRefId is NULL)
		select	@DebitInterestProdRefId = PrReference.Id
		from PrReference INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @DebitInterestAccNo
		and PrReference.Currency = 'CHF'
end


if(@CreditInterestNoTaxAccNo is not null)
begin
	select 	@CreditInterestNoTaxProdRefId  = PrReference.Id		
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @CreditInterestNoTaxAccNo
	and PrReference.Currency = @strAccCurrency
	if(@CreditInterestNoTaxProdRefId is NULL)
		select 	@CreditInterestNoTaxProdRefId  = PrReference.Id		
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @CreditInterestNoTaxAccNo
		and PrReference.Currency = 'CHF'
	
end

if(@CreditInterestWithTaxAccNo is not null)
begin
	select 	@CreditInterestWithTaxProdRefId = PrReference.Id
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @CreditInterestWithTaxAccNo
	and PrReference.Currency = @strAccCurrency
	if @CreditInterestWithTaxProdRefId is null
		select 	@CreditInterestWithTaxProdRefId = PrReference.Id
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @CreditInterestWithTaxAccNo
		and PrReference.Currency = 'CHF'	
end

if(@CommissionAccNo is not null)
begin
	select	@CommissionProdRefId = PrReference.Id
	from PrReference
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @CommissionAccNo
	and PrReference.Currency = @strAccCurrency
	if(@CommissionProdRefId is null)
		select	@CommissionProdRefId = PrReference.Id
		from PrReference
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @CommissionAccNo
		and PrReference.Currency = 'CHF'
	
end

if(@ProvisionAccNo is not null)
begin
	select 	@ProvisionProdRefId = PrReference.Id
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @ProvisionAccNo
	and PrReference.Currency = @strAccCurrency
	if(@ProvisionProdRefId is NULL)
		select 	@ProvisionProdRefId = PrReference.Id
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @ProvisionAccNo
		and PrReference.Currency = 'CHF'
		
end

if(@SpecialCommissionAccNo is not null)
begin
	select 	@SpecialCommissionProdRefId = PrReference.Id	
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @SpecialCommissionAccNo
	and PrReference.Currency = @strAccCurrency
	if(@SpecialCommissionProdRefId is null)
		select 	@SpecialCommissionProdRefId = PrReference.Id	
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @SpecialCommissionAccNo
		and PrReference.Currency = 'CHF'
end

if(@WithholdingTaxAccNo is not null)
begin
	select 	@WithholdingTaxProdRefId = PrReference.Id	
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @WithholdingTaxAccNo
	and PrReference.Currency = @strAccCurrency
	if(@WithholdingTaxProdRefId is NULL)
		select 	@WithholdingTaxProdRefId = PrReference.Id	
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @WithholdingTaxAccNo
		and PrReference.Currency =  'CHF'
end

if(@GeneralExpensesAccNo is not null)
begin
	select 	@GeneralExpensesProdRefId = PrReference.Id	
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @GeneralExpensesAccNo
	and PrReference.Currency = @strAccCurrency
	if(@GeneralExpensesProdRefId is NULL)
		select 	@GeneralExpensesProdRefId = PrReference.Id	
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @GeneralExpensesAccNo
		and PrReference.Currency = 'CHF'	
end

if(@BonusAccNo is not null)
begin
	select  @BonusProdRefId = PrReference.Id	
	from PrReference 
	INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
	Where PtAccountBase.AccountNo = @BonusAccNo
	and PrReference.Currency = @strAccCurrency
	if(@BonusProdRefId is NULL)
		select  @BonusProdRefId = PrReference.Id	
		from PrReference 
		INNER JOIN PtAccountBase On PrReference.AccountId = PtAccountBase.Id
		Where PtAccountBase.AccountNo = @BonusAccNo
		and PrReference.Currency = NULL
end
select  @strAccCurrency as Currency ,
 @IsDueRelevant as IsDueRelevant,
 @RndType as RndType,
 @PrPrivateId as PrPrivateId,
 @DebitInterestAccNo as DebitInterestAccNo,
 @CreditInterestNoTaxAccNo as CreditInterestNoTaxAccNo ,
 @CreditInterestWithTaxAccNo as CreditInterestWithTaxAccNo ,  
 @CommissionAccNo as CommissionAccNo,  
 @ProvisionAccNo as ProvisionAccNo,
 @SpecialCommissionAccNo as SpecialCommissionAccNo,
 @WithholdingTaxAccNo as WithholdingTaxAccNo,
 @DebitInterestProdRefId as DebitInterestProdRefId,
 @CreditInterestNoTaxProdRefId as CreditInterestNoTaxProdRefId,
 @CreditInterestWithTaxProdRefId as CreditInterestWithTaxProdRefId ,
 @CommissionProdRefId as CommissionProdRefId,
 @ProvisionProdRefId as ProvisionProdRefId,
 @SpecialCommissionProdRefId as SpecialCommissionProdRefId,
 @WithholdingTaxProdRefId as WithholdingTaxProdRefId,
 @GeneralExpensesProdRefId  as GeneralExpensesProdRefId,
 @BonusProdRefId  as BonusProdRefId

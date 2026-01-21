--liquibase formatted sql

--changeset system:create-alter-function-GetStalePriceInfoByPositionId context:any labels:c-any,o-function,ot-schema,on-GetStalePriceInfoByPositionId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetStalePriceInfoByPositionId
CREATE OR ALTER FUNCTION dbo.GetStalePriceInfoByPositionId
(
    @PositionId uniqueidentifier
)
RETURNS TABLE
AS
RETURN
(
select acc_info.*, closing.calculationdate from (
select ptaccountclosingresult.AccountComponentId, max(ptaccountclosingperiod.calculationdate) as calculationdate  from ptaccountclosingperiod 
inner join ptaccountclosingresult on ptaccountclosingperiod.id = ptaccountclosingresult.AccountClosingPeriodId
where 
ptaccountclosingperiod.PositionId = @PositionId 
and ptaccountclosingperiod.PeriodType = 1
and ptaccountclosingperiod.ExecutedDate is null
group by ptaccountclosingresult.AccountComponentId
)closing
inner join (
select  PtAccountComposedPrice.AccountComponentId , max(PtAccountComposedPrice.hdchangedate)as max_acc_composed_price_date, max(max_product_change_date) as max_product_change_date from PtAccountComposedPrice

inner join ( select PrComposedPrice.PrivateComponentNo, min(PrComposedPrice.hdchangedate) as min_change_date, max(hdchangedate) max_product_change_date from PrComposedPrice where PrComposedPrice.state = 2
group by PrComposedPrice.PrivateComponentNo
) composed_price on composed_price.PrivateComponentNo = ptaccountcomposedprice.PrivateComponentNo

inner join PtAccountComponent on PtAccountComposedPrice.AccountComponentId = PtAccountComponent.Id
inner join ptAccountbase on PtAccountBase.Id = PtAccountComponent.AccountBaseId
inner join PtPortfolio ON PtAccountBase.PortfolioId = PtPortfolio.Id 
inner join PrReference on PrReference.AccountId = ptAccountbase.Id
inner join PtPosition on PtPosition.ProdReferenceId = PrReference.Id and PtPosition.PortfolioId = PtPortfolio.Id
where PtPosition.Id = @PositionId 
group by PtAccountComposedPrice.AccountComponentId
)acc_info on acc_info.AccountComponentId = closing.AccountComponentId
where acc_info.max_acc_composed_price_date < acc_info.max_product_change_date or closing.calculationdate < cast(acc_info.max_acc_composed_price_date as date) or closing.calculationdate < cast(acc_info.max_product_change_date as date)
)

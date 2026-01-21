--liquibase formatted sql

--changeset system:create-alter-function-GetAccountConditionsForPM1 context:any labels:c-any,o-function,ot-schema,on-GetAccountConditionsForPM1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetAccountConditionsForPM1
CREATE OR ALTER FUNCTION dbo.GetAccountConditionsForPM1
(
@AccountId uniqueidentifier
)
RETURNS TABLE
AS
RETURN (
select top 1 AccountNo, PtAccountComposedPrice.ValidFrom, PtAccountComposedPrice.ValidTo,PtAccountComposedPrice.InterestRate, PtAccountComposedPrice.Value,
PtAccountBase.collclean,  PtAccountComposedPrice.HdChangeDate as CompPriceChangeDate from PtAccountBase 
inner join PtAccountComponent on PtAccountBase.Id = PtAccountComponent.AccountBaseId and PtAccountComponent.IsOldComponent = 0 
inner join PtAccountComposedPrice on PtAccountComponent.Id = PtAccountComposedPrice.AccountComponentId and Value <> 0
inner join PrPrivateCompType on PtAccountComponent.PrivateCompTypeId = PrPrivateCompType.Id and PrPrivateCompType.IsLimitRelevant = 1 and PrPrivateCompType.IsDebit = 1
Where PtAccountBase.Id = @AccountId
Order by ValidFrom desc
)

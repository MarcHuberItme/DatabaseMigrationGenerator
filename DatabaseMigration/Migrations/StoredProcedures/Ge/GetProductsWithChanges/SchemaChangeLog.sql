--liquibase formatted sql

--changeset system:create-alter-procedure-GetProductsWithChanges context:any labels:c-any,o-stored-procedure,ot-schema,on-GetProductsWithChanges,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetProductsWithChanges
CREATE OR ALTER PROCEDURE dbo.GetProductsWithChanges
AS
select distinct PrPrivate.ProductNo from PrPrivate
inner join PrPrivateCurrRegion on PrPrivate.ProductNo = PrPrivateCurrRegion.ProductNo
inner join PrPrivateComponent on PrPrivateComponent.PrivateCurrRegionId = PrPrivateCurrRegion.Id
inner join (
select PrPrivateComponent.Id as ComponentId, 
max(PrPrivate.HdChangedate) PrPrivateChangeDate,
max(PrPrivateCurrRegion.HdChangedate) PrPrivateCurrRegionChangeDate,
max(PrPrivateComponent.HdChangedate) PrPrivateComponentChangeDate,
max(PrPrivateCompPrice.HdChangedate) PrPrivateCompPriceChangeDate,
max(PrStandardPriceValue.HdChangedate) PrStandardPriceValueChangeDate

from PrPrivate
left outer join PrPrivateCurrRegion on PrPrivate.ProductNo = PrPrivateCurrRegion.ProductNo
left outer join PrPrivateComponent on PrPrivateComponent.PrivateCurrRegionId = PrPrivateCurrRegion.Id
left outer join PrPrivateCompPrice on PrPrivateCompPrice.PrivateComponentNo = PrPrivateComponent.PrivateComponentNo
left outer join PrStandardPriceValue on PrStandardPriceValue.StandardPriceNo = PrPrivateCompPrice.StandardPriceNo
group by PrPrivateComponent.Id ) CompDates on PrPrivateComponent.Id = CompDates.ComponentId

inner join (
select PrComposedPrice.PrivateComponentId,max(hdchangedate) PrComposedPriceChangeDate from PrComposedPrice
group by PrComposedPrice.PrivateComponentId 
) ComposedPrice on ComposedPrice.PrivateComponentId = PrPrivateComponent.Id
where 
 1= 0
or ComposedPrice.PrComposedPriceChangeDate < CompDates.PrPrivateChangeDate
or ComposedPrice.PrComposedPriceChangeDate < CompDates.PrPrivateCurrRegionChangeDate
or ComposedPrice.PrComposedPriceChangeDate < CompDates.PrPrivateComponentChangeDate
or ComposedPrice.PrComposedPriceChangeDate < CompDates.PrPrivateCompPriceChangeDate
or ComposedPrice.PrComposedPriceChangeDate < CompDates.PrStandardPriceValueChangeDate

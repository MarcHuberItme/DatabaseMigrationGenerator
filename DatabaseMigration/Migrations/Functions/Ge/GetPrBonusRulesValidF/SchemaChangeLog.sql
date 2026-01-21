--liquibase formatted sql

--changeset system:create-alter-function-GetPrBonusRulesValidF context:any labels:c-any,o-function,ot-schema,on-GetPrBonusRulesValidF,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetPrBonusRulesValidF
CREATE OR ALTER FUNCTION dbo.GetPrBonusRulesValidF
(
@ProductNo int,
@DateTo datetime,
@DateFrom datetime
)
RETURNS TABLE
As
Return
(
Select * from 
(
Select 
PrPrivateBonusRules.ProductNo,
PrPrivateBonusRules.BonusRate, 
PrPrivateBonusRules.ValidFrom, 
PrPrivateBonusRules.MinimumBalance, 
PrPrivateBonusRules.MaximumWithdraw, 
Min(ISNULL(PrPrivateBonusRules_1.ValidFrom,'99991231 23:59:59.997')) as ValidTo

from PrPrivateBonusRules
Left Outer Join PrPrivateBonusRules PrPrivateBonusRules_1

ON PrPrivateBonusRules.ProductNo = PrPrivateBonusRules_1.ProductNo
and PrPrivateBonusRules.ValidFrom < PrPrivateBonusRules_1.ValidFrom

Where
PrPrivateBonusRules.ProductNo = @ProductNo and
@DateTo > PrPrivateBonusRules.ValidFrom

Group By PrPrivateBonusRules.ProductNo,
PrPrivateBonusRules.BonusRate, 
PrPrivateBonusRules.ValidFrom, 
PrPrivateBonusRules.MinimumBalance, 
PrPrivateBonusRules.MaximumWithdraw

/*
Having 
@DateTo<= Min(ISNULL(PrPrivateBonusRules_1.ValidFrom,'99991231 23:59:59.997'))
*/


) a
Where a.ValidTo > @DateFrom
)


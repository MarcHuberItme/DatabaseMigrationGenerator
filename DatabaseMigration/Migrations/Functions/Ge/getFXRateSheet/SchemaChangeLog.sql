--liquibase formatted sql

--changeset system:create-alter-function-getFXRateSheet context:any labels:c-any,o-function,ot-schema,on-getFXRateSheet,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function getFXRateSheet
CREATE OR ALTER FUNCTION dbo.getFXRateSheet
( @rateType as smallint, @AsOfDate datetime )
RETURNS TABLE
As
Return (
select CySymbolOriginate as ForeignCurrency,min(rate) as fxrate from CyRateRecent where RateType=@rateType and CySymbolTarget = 'CHF' and  CyRateRecent.HdVersionNo between 1 and 999999998 and CyRateRecent.ValidFrom <= @AsOfDate and CyRateRecent.ValidTo >= @AsOfDate
 group by CySymbolOriginate
 UNION select 'CHF',1.0
)

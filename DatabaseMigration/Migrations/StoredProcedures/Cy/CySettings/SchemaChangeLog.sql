--liquibase formatted sql

--changeset system:create-alter-procedure-CySettings context:any labels:c-any,o-stored-procedure,ot-schema,on-CySettings,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CySettings
CREATE OR ALTER PROCEDURE dbo.CySettings
@ID   as uniqueidentifier

AS

Select Top 1 RR.ValidFrom, RR.ValidTo, C.Symbol, RR.CySymbolTarget, C.Amount, RUL.LimitingValue, RR.Rate, RR.Rate - C.SpreadTrader - C.SpreadManager AS Geld
, RR.Rate + C.SpreadTrader + C.SpreadManager AS Brief, C.SpreadTrader, C.SpreadManager, C.AgioTrader, C.AgioManager
,C.SpreadTraderWithRebate,C.SpreadManagerWithRebate, C.AgioTraderWithRebate, C.AgioManagerWithRebate, RUL.RateValidity
, RUL.MemoryPoolValidity, RUL.RecentValidity, RUL.ArchiveValidity, RUL.Tolerance, RUL.FeedSymbol 
from cyCommission C
Inner Join CyRateType RT on RT.PaymentInstrumentNo = C.PaymentInstrumentNo
Inner Join CyRateRecent RR on RR.cySymbolOriginate = C.Symbol AND RR.RateType = RT.RateType --AND RR.PaymentInstrumentNo = C.PaymentInstrumentNo
Inner Join CyRateRule RUL on RUL.cySymbolOriginate = C.Symbol AND RUL.PaymentInstrumentNo = C.PaymentInstrumentNo
Where C.ID = @ID
AND RR.ValidTo > getdate()
Order by RR.ValidTo Desc


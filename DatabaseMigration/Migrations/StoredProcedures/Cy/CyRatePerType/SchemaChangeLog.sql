--liquibase formatted sql

--changeset system:create-alter-procedure-CyRatePerType context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRatePerType,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRatePerType
CREATE OR ALTER PROCEDURE dbo.CyRatePerType
@Type smallint
AS
Select RR.cySymbolOriginate, RR.cySymbolTarget
, Rate, Rate - C.SpreadTrader - C.SpreadManager AS Geld 
, Rate + C.SpreadTrader + C.SpreadManager AS Brief
, C.Amount
, ValidFrom
, ValidTo
, C.ID
, 'None' as Style
from CyRateRecent RR
Inner Join CyRateType RT on RR.RateType = RT.RateType
Inner join CyPaymentInstrument AS PI on RT.PaymentInstrumentNo = PI.PaymentInstrumentNo
Inner Join CyCommission C on C.Symbol = cySymbolOriginate
Inner Join CyBase B on B.Symbol = RR.cySymbolOriginate
Where ValidFrom <= getdate() AND Validto > getdate()
AND RR.HdVersionNo Between 1 AND 999999998
AND RT.HdVersionNo Between 1 AND 999999998
AND PI.HdVersionNo Between 1 AND 999999998
AND C.HdVersionNo Between 1 AND 999999998
AND RT.PaymentInstrumentNo= @Type
AND C.PaymentInstrumentNo= @Type
AND  RR.cySymbolOriginate <> 'CHF'
Order by B.Sequence, C.Amount



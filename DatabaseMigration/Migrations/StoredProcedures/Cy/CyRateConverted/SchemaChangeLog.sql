--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateConverted context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateConverted,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateConverted
CREATE OR ALTER PROCEDURE dbo.CyRateConverted
@SourceCurrency varchar(3),
@DestCurrency varchar(3),
@Amount money
AS
SELECT TOP 1 Rate, Rate - C.SpreadTrader - C.SpreadManager AS Geld 
, Rate + C.SpreadTrader + C.SpreadManager AS Brief
FROM CyRateRecent RR
INNER JOIN CyRateType RT ON RR.RateType = RT.RateType
INNER JOIN CyPaymentInstrument AS PI ON RT.PaymentInstrumentNo = PI.PaymentInstrumentNo
INNER JOIN CyCommission C ON C.Symbol = cySymbolOriginate
INNER JOIN CyBase B ON B.Symbol = RR.cySymbolOriginate
WHERE ValidFrom <= getdate() AND Validto > getdate()
AND RR.HdVersionNo BETWEEN 1 AND 999999998
AND RT.HdVersionNo BETWEEN 1 AND 999999998
AND PI.HdVersionNo BETWEEN 1 AND 999999998
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND RT.PaymentInstrumentNo= 20
AND C.PaymentInstrumentNo= 20
AND RR.cySymbolOriginate = @SourceCurrency
AND RR.CySymbolTarget = @DestCurrency
AND @Amount < C.Amount
ORDER BY B.Sequence, C.Amount


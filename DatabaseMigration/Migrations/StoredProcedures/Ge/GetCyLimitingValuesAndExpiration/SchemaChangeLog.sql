--liquibase formatted sql

--changeset system:create-alter-procedure-GetCyLimitingValuesAndExpiration context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCyLimitingValuesAndExpiration,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCyLimitingValuesAndExpiration
CREATE OR ALTER PROCEDURE dbo.GetCyLimitingValuesAndExpiration
@SymbolOriginate as char(3),
@SymbolTarget as char(3),
@Instrument as int
AS
DECLARE @LimitingValue as money
DECLARE @ExpirationTrader as int
DECLARE @ExpirationManager as int
If EXISTS(Select * from CyRateRule Where HdVersionNo between 1 and 999999998 AND 
	CySymbolOriginate = @SymbolOriginate AND CySymbolTarget = @SymbolTarget AND
	PaymentInstrumentNo = @Instrument)
	BEGIN
		Select @LimitingValue = LimitingValue, @ExpirationTrader=ExpirationTrader, 
		@ExpirationManager=ExpirationManager  from CyRateRule 
		Where HdVersionNo between 1 and 999999998 AND 
		CySymbolOriginate = @SymbolOriginate AND CySymbolTarget = @SymbolTarget AND
		PaymentInstrumentNo = @Instrument	
	END
ELSE
	BEGIN
		Select @LimitingValue = Min(isnull(LimitingValue,0)), @ExpirationTrader = Avg(ExpirationManager), 
		@ExpirationManager = Avg(ExpirationTrader) from CyRateRule 
		Where HdVersionNo between 1 and 999999998 AND PaymentInstrumentNo = @Instrument AND
		((CySymbolOriginate = @SymbolOriginate AND CySymbolTarget = 'CHF')OR
		(CySymbolOriginate = 'CHF' AND CySymbolTarget = @SymbolTarget))
	END

Select @LimitingValue as LimitValue, @ExpirationTrader as ExpirationTrader, @ExpirationManager as ExpirationManager

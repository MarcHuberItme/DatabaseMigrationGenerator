--liquibase formatted sql

--changeset system:create-alter-procedure-CyRatePerTypeAndCurrency context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRatePerTypeAndCurrency,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRatePerTypeAndCurrency
CREATE OR ALTER PROCEDURE dbo.CyRatePerTypeAndCurrency
@Type smallint,
@Currency char(3)

AS
Select Top 90 RR.cySymbolOriginate, RR.cySymbolTarget
, RR.Rate
, ValidFrom, ValidTo 
, RR.Rate as Diff
From CyRateRecent RR
Inner Join CyRateType RT on RR.RateType = RT.RateType AND RT.HdVersionNo between 1 AND 999999998
Where cySymbolOriginate = @Currency 
AND RT.PaymentInstrumentNo=@Type 
AND RR.HdVersionNo between 1 AND 999999998
Order by ValidFrom DESC, ValidTo DESC

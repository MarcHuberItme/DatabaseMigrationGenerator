--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateRecent_GetSingleRate context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateRecent_GetSingleRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateRecent_GetSingleRate
CREATE OR ALTER PROCEDURE dbo.CyRateRecent_GetSingleRate
		 @SymbolOriginate char( 3),
		 @SymbolTarget char( 3),
		 @RateType smallint,
		 @ExchangeDate datetime 
AS 
SELECT TOP 1 * FROM CyRateRecent
   WHERE CySymbolOriginate=@SymbolOriginate 
      AND  CySymbolTarget=@SymbolTarget
      AND  RateType=@RateType
      AND  ValidFrom <=@ExchangeDate
      AND  HdVersionNo BETWEEN 1 AND 999999998
   ORDER BY ValidFrom DESC

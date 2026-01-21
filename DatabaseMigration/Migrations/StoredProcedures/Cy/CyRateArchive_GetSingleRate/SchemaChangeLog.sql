--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateArchive_GetSingleRate context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateArchive_GetSingleRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateArchive_GetSingleRate
CREATE OR ALTER PROCEDURE dbo.CyRateArchive_GetSingleRate
@SymbolOriginate char( 3),
		 @SymbolTarget char( 3),
		 @RateType smallint,
		 @ExchangeDate datetime 
AS 
SELECT TOP 1 * FROM CyRateArchive
   WHERE CySymbolOriginate=@SymbolOriginate 
      AND  CySymbolTarget=@SymbolTarget
      AND  RateType=@RateType
      AND  ValidFrom <=@ExchangeDate
      AND  HdVersionNo BETWEEN 1 AND 999999998
   ORDER BY ValidFrom DESC

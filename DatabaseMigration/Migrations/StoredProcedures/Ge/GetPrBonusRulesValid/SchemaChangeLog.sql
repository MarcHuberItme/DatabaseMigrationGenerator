--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrBonusRulesValid context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrBonusRulesValid,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrBonusRulesValid
CREATE OR ALTER PROCEDURE dbo.GetPrBonusRulesValid
@ProductNo int,
@DateTo datetime,
@DateFrom datetime
AS

Select * from GetPrBonusRulesValidF( @ProductNo , @DateTo,@DateFrom)

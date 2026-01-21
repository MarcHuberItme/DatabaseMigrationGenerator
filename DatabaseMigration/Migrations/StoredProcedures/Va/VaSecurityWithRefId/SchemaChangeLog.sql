--liquibase formatted sql

--changeset system:create-alter-procedure-VaSecurityWithRefId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaSecurityWithRefId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaSecurityWithRefId
CREATE OR ALTER PROCEDURE dbo.VaSecurityWithRefId
--Storeprocedure: VaSecurityWithRefId

@RefId  UniqueIdentifier,
@ValuationDate Datetime
/*
@MarketValueCurrency Char (3) OUTPUT
@MarketValue Decimal(38,2) OUTPUT
@AccruedInterestCurrency Char (3) OUTPUT
@AccruedInterest Decimal(38,2) OUTPUT
@PriceDate DateTime OUTPUT
*/
AS

/*
Declare @RefId  AS UniqueIdentifier
Declare @ValuationDate AS Datetime

Set @RefId = '88975274-02CD-473B-9AB4-6B4AA4C4A0AD'
Set @ValuationDate = '20080630'
*/

DECLARE @ID Uniqueidentifier EXEC VaRunWithValuationDate @ValuationDate , @ID OUTPUT

Select RV.PriceCurrency as MarketValueCurrency
, RV.MarketValuePrCu as MarketValue
, RV.PriceCurrency as AccruedInterestCurrency
, RV.AccruedInterestPrCu as AccruedInterest
, RV.PriceDate as PriceDate
From VaRefVal RV
Where 
    ProdReferenceId = @RefId
AND ValRunID = @ID 

--liquibase formatted sql

--changeset system:create-alter-procedure-VaGetRunStatistics context:any labels:c-any,o-stored-procedure,ot-schema,on-VaGetRunStatistics,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaGetRunStatistics
CREATE OR ALTER PROCEDURE dbo.VaGetRunStatistics
@VaRunId AS uniqueidentifier
AS
DECLARE @PublicMarketValueCHF as numeric(19,2), @PublicAccruedInterestCHF as numeric(19,2), @PrivateMarketValueCHF as numeric(19,2), @PrivateAccruedInterestCHF as numeric(19,2)
Select @PublicMarketValueCHF = cast(Sum(MarketValueCHF) as numeric (19,2)), @PublicAccruedInterestCHF = cast(Sum(AccruedInterestCHF) as numeric (19,2))From vaPublicView Where VaRunId =@VaRunId
Select @PrivateMarketValueCHF = cast(Sum(MarketValueCHF) as numeric (19,2)), @PrivateAccruedInterestCHF = cast(Sum(AccruedInterestCHF) as numeric (19,2)) From vaPrivateView Where VaRunId = @VaRunId

Select
(Select Count(Id) From VaPortfolio Where ValRunId =@VaRunId) AS Portfolio , 
(Select Count(PQ.Id) From VaPosQuant PQ Where VaRunId =@VaRunId) AS Positionen , 
(Select Count(Id) From VaRefVal Where ValRunId = @VaRunId) AS Kurse , 
(Select Count(Id) From VaCurrencyRate Where ValRunId = @VaRunId AND RatePrCuVaCu is not Null AND RatePrCuVaCu <> 0 ) AS Währungen , 
(Select cast(Sum(Quantity)/ 1000000 as varchar) + ' Mio.' From vaPosquant Where VaRunId =@VaRunId) AS Positionsquantity , 
(Select @PublicMarketValueCHF) AS PublicMarketValueCHF , 
(Select @PrivateMarketValueCHF) AS PrivateMarketValueCHF , 
(Select @PublicAccruedInterestCHF) AS PublicAccruedInterestCHF ,
(Select @PrivateAccruedInterestCHF) AS PrivateAccruedInterestCHF


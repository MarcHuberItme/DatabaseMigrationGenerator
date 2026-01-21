--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioCurrency_OnATradeDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioCurrency_OnATradeDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioCurrency_OnATradeDate
CREATE OR ALTER PROCEDURE dbo.GetPortfolioCurrency_OnATradeDate

@PortfolioId  uniqueidentifier,
@TradeDate datetime

AS

SELECT    	IsNull(PCC.NewPortfolioCurrency ,PTF.Currency) AS PortfolioCurrency
FROM      	PtPortfolio PTF 
LEFT OUTER JOIN	PtPortfolioCurrencyChange PCC ON PCC.PortfolioId = PTF.Id 
                      	AND PCC.HdVersionNo < 999999999 
                      	AND PCC.CurrencyChangeStatusNo = 9 
                      	AND PCC.BeginDate <= @TradeDate 
                      	AND PCC.EndDate >= @TradeDate 
WHERE     	PTF.Id = @PortfolioId  


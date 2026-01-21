--liquibase formatted sql

--changeset system:create-alter-procedure-PMSGetPortfolioValuation context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSGetPortfolioValuation,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSGetPortfolioValuation
CREATE OR ALTER PROCEDURE dbo.PMSGetPortfolioValuation
@VaRunId uniqueidentifier,
@PortfolioId uniqueidentifier,
@PortfolioValue money output,
@AccrInterestValue money output
As 
declare @secValue money;
declare @cashValue money;
declare @accrIntrValue money;
-- get current valuation
select @secValue   = isnull(sum(marketvaluevacu), 0) FROM VaPublicView where  VaRunId = @VaRunId and PortfolioId = @PortfolioId
select @accrIntrValue = isnull(sum(AccruedInterestVaCu), 0) FROM VaPublicView where  VaRunId = @VaRunId and PortfolioId = @PortfolioId
select @cashValue  = isnull(sum(marketvaluevacu), 0) FROM VaPrivateView where  VaRunId = @VaRunId and PortfolioId = @PortfolioId

set @PortfolioValue = @secValue + @cashValue;
set @AccrInterestValue = @accrIntrValue;;

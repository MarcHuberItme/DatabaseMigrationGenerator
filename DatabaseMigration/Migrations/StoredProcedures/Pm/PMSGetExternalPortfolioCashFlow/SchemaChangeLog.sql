--liquibase formatted sql

--changeset system:create-alter-procedure-PMSGetExternalPortfolioCashFlow context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSGetExternalPortfolioCashFlow,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSGetExternalPortfolioCashFlow
CREATE OR ALTER PROCEDURE dbo.PMSGetExternalPortfolioCashFlow
@PortfolioNo varchar(11), 
@ValuationDate date,
@PerfMethod tinyint, 
@VaRunId uniqueidentifier,
@ExtTotalCashFlow money output,
@SecIn money output,
@SecOut money output,
@CapIn money output,
@CapOut money output
As
Declare @csvTransTypeNo nvarchar(100) = (Select Value from AsParameterView where GroupName = 'ValueAssessment' and ParameterName = 'PerfProcExclCashFlowTransTypes');

with currency_lookup as -- provide currency exchange table up to 'valuation date'
(
	select cur.*, ROW_NUMBER()  over (partition by valuationcurrency, accountcurrency order by run.ValuationDate desc) as ranking
	from VaCurrencyRate cur 
	join VaRun run on run.id = cur.ValRunId
	where 1=1
	and run.ValuationDate <= @ValuationDate 
)
Select
@ExtTotalCashFlow = isnull(sum(trans.subExtTotalCashFlow), 0),
@SecIn = isnull(sum(trans.subSecIn), 0),
@SecOut = isnull(sum(trans.subSecOut), 0),
@CapIn = isnull(sum(trans.subCapIn), 0),
@CapOut = isnull(sum(trans.subCapOut), 0)
From
(
	Select isnull(sum(case when  p.CreditDebitInd = 'CRDT' then (p.Amount*cur.RatePrCuVaCu) else (p.Amount*cur.RatePrCuVaCu)*-1 end), 0) as subExtTotalCashFlow,
		   isnull(sum(case when  p.CreditDebitInd = 'CRDT' and (PositionId is not null) then (p.Amount*cur.RatePrCuVaCu) else 0 end), 0) as subSecIn,
		   isnull(sum(case when  p.CreditDebitInd = 'DBIT' and (PositionId is not null) then (p.Amount*cur.RatePrCuVaCu) else 0 end), 0) as subSecOut,
	       isnull(sum(case when  p.CreditDebitInd = 'CRDT' and (PositionId is null) then (p.Amount*cur.RatePrCuVaCu) else 0 end), 0) as subCapIn,
		   isnull(sum(case when  p.CreditDebitInd = 'DBIT' and (PositionId is null) then (p.Amount*cur.RatePrCuVaCu) else 0 end), 0) as subCapOut
	from PmPerfTransData p
		join PtPortfolio por on por.id = p.portfolioid
		join currency_lookup cur on cur.ValuationCurrency = por.Currency and p.currency = cur.AccountCurrency and cur.ranking = 1 -- take most recent available currency rate (ranking =1)
	where p.PortfolioNo = @PortfolioNo
		and p.TransactionDate = @ValuationDate 
	group by TransactionId, TransTypeNo
	having
	(   
		TransTypeNo not in
		(
			Select * from string_split(@csvTransTypeNo, ',')
		)
		and
		(
			(
				(TransTypeNo in (601,602,621,701)) and (count(TransactionId) = 1)
			)
			or
			(
				(TransTypeNo not in (601,602,621, 701)) and
				sum(case when p.CreditDebitInd = 'CRDT' then 1 else 0 end) <>
				sum(case when p.CreditDebitInd = 'DBIT' then 1 else 0 end)
			)
		)
	)
) trans

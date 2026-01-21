--liquibase formatted sql

--changeset system:create-alter-procedure-PMSGetTransactionDetails context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSGetTransactionDetails,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSGetTransactionDetails
CREATE OR ALTER PROCEDURE dbo.PMSGetTransactionDetails
@PortfolioNo varchar(11), 
@TransactionDate date,
@PerfMethod tinyint, 
@VaRunId uniqueidentifier,
@Coupons money output,
@Interests money output,
@MarchInterests money output,
@ManagementFees money output,
@DepotFees money output,
@TransactionFees money output,
@TaxFees money output
As 
Select
@Coupons = isnull(sum(trans.Coupons), 0),
@Interests = isnull(sum(trans.Interests), 0),
@MarchInterests = isnull(sum(trans.MarchInterests), 0),
@ManagementFees = isnull(sum(trans.ManagementFees), 0),
@DepotFees = isnull(sum(trans.DepotFees), 0),
@TransactionFees = isnull(sum(trans.TransactionFees), 0),
@TaxFees = isnull(sum(trans.TaxFees), 0)
From
(
	Select isnull(sum(case when p.TransTypeNo = 741 or p.TransTypeNo = 42 then case when p.CreditDebitInd = 'CRDT' then (p.Amount/cur.RatePrCuVaCu) else (p.Amount/cur.RatePrCuVaCu)*-1 end end), 0) as Coupons,
		   isnull(sum(case when p.TransTypeNo = 721 then case when p.CreditDebitInd = 'CRDT' then (p.Amount/cur.RatePrCuVaCu) else (p.Amount/cur.RatePrCuVaCu)*-1 end end), 0) as Interests,
		   isnull(sum(case when p.TransTypeNo =  88 then case when p.CreditDebitInd = 'CRDT' then (p.Amount/cur.RatePrCuVaCu) else (p.Amount/cur.RatePrCuVaCu)*-1 end end), 0) as MarchInterests,
		   isnull(sum(case when p.TransTypeNo = 868  or p.TransTypeNo = 869 then (p.Amount/cur.RatePrCuVaCu) end), 0) as ManagementFees,
           isnull(sum(case when p.TransTypeNo = 866 then (p.Amount/cur.RatePrCuVaCu) end), 0) as DepotFees,
		   isnull(sum(case when p.TransTypeNo = 601 or p.TransTypeNo = 602 then (p.TransactionFee/cur.RatePrCuVaCu) end), 0) as TransactionFees,
           isnull(sum(case when p.TransTypeNo = 601 or p.TransTypeNo = 602 then (p.TaxFee/cur.RatePrCuVaCu) end), 0) as TaxFees
	from PmPerfTransData p
		join PtPortfolio por on por.id = p.portfolioid
		join VaCurrencyRate cur on cur.AccountCurrency = por.Currency and p.currency = cur.ValuationCurrency
	where p.PortfolioNo = @PortfolioNo
		and p.TransactionDate = @TransactionDate 
		and cur.ValRunId = @VaRunId
	group by TransactionId, TransTypeNo
	having
	(   
		TransTypeNo in
		( 
			601, -- buy position
			602, -- sell position
			868, -- management fees
            869, -- tax report
			866, -- depot fees
			88,  -- march interest 
			42,  -- k-obli
			741, -- coupon
			721  -- coupon/interest
		)
	)
) trans

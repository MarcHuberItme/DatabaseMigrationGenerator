--liquibase formatted sql

--changeset system:create-alter-procedure-PMSGetPortfolioTransactions context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSGetPortfolioTransactions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSGetPortfolioTransactions
CREATE OR ALTER PROCEDURE dbo.PMSGetPortfolioTransactions
@PortfolioNo varchar(11), 
@From date,
@To date,
@PerfMethod tinyint -- not used yet
As 
-- identify all transactions from or to the portfolio given within from/to date
with cash as
(
select 
bp.HdCreator,
bp.HdEditStamp,
bp.HdVersionNo,
convert(date, bp.BookingDate)  as TransDate, -- booking date is trans date in RoTransItemDetail!
bp.TransactionId as TransactionId,
tt.TransTypeNo  as TransTypeNo,
null as TransMsgStatusNo,
bp.CancelTransMsgId as CancelTransMsgId,
port_bp.PortfolioNo as PortfolioNo, 
port_bp.id as PortfolioId,
bp.Amount as Amount, 
bp.Currency as Currency,
bp.CreditDebitIndicator as CreditDebitInd, 
0 as TransactionFee,
0 as TaxFee,
bp.OwnAccount as Account,
null as PositionId,
0 as PerfMethod
from RoTransItemDetail bp
join PtAccountBase acc on acc.id = bp.AccountId
join PtPortfolio port_bp on port_bp.id = acc.PortfolioId
join PtTransaction t on t.id  = bp.TransactionId
join PtTransType tt on tt.TransTypeNo = t.TransTypeNo
where (1=1) 
and bp.BookingDate >= @From
and bp.BookingDate <= @To
and port_bp.PortfolioNo = @PortfolioNo
),
sec as
(
select 
m.HdCreator,
m.HdEditStamp, 
m.HdVersionNo,
convert(date, tif.TransDate) as TransDate, -- skip time stamps
tif.TransId, 
t.TransTypeNo as TransTypeNo, 
m.TransMsgStatusNo as TransMsgStatusNo,
m.CancelTransMsgId as CancelTransMsgId,
tif.PositionId as PositionID, 
m.debitportfoliono, 
m.DebitAccountNo, 
m.CreditPortfolioNo,m.creditaccountno,
case when (select top(1)va.MarketValuePrCu from VaPositionView va where va.PositionId =pos.Id and va.PriceDate <= tif.TransDate) is not null then
            (select top(1) case when tif.CreditQuantity <> 0 then 
                                   (va.MarketValuePrCu/va.Quantity)*tif.CreditQuantity
                        else
                                    (va.MarketValuePrCu/va.Quantity)*tif.DebitQuantity*-1
                        end
            from VaPositionView va where va.PositionId =pos.Id and va.PriceDate <= tif.TransDate order by va.PriceDate desc)
else
            tif.AmountCvAcCu*tif.RateAcCuPfCu
end as AmountMarketVal,
case when (select top(1)va.MarketValuePrCu from VaPositionView va where va.PositionId =pos.Id and va.PriceDate <= tif.TransDate) is not null then
	(select top(1) va.PriceCurrency from VaPositionView va where va.PositionId =pos.Id and va.PriceDate <= tif.TransDate order by va.PriceDate desc)
else
	port.Currency
end as PriceCurrency,
tif.AmountCvAcCu,
isnull((select sum(DebitAmount) from PtTransItemDetailPosView tipv where tipv.portfolioid = port.id and tipv.TransNo = t.TransNo and SourceCvAmountTypeNo in (1022,1211) and tipv.languageno=1), 0) as TransactionFee,
isnull((select sum(DebitAmount) from PtTransItemDetailPosView tipv where tipv.portfolioid = port.id and tipv.TransNo = t.TransNo and SourceCvAmountTypeNo in (1141,1201) and tipv.languageno=1), 0) as TaxFee,
tif.RateAcCuPfCu, 
tif.CvAmountTypeNo, 
tif.RateSourceAcCuPfCu 
from PtTransItemFull tif
join PtPosition pos on pos.id = tif.PositionId 
join PtPortfolio port on port.id = pos.PortfolioId
join PrReference ref on pos.ProdReferenceId = ref.id
left outer join PrPublic pub on pub.ProductId = ref.ProductId
join pttransmessage m on m.id = tif.MessageId
join PtTransaction t on t.id = tif.TransId 
where (1=1)
and port.PortfolioTypeNo <> 5000
and pos.LatestTransDate >= @From
and PortfolioNo = @PortfolioNo
and tif.TransDate >= @From
and tif.TransDate <= @To
and pub.IsinNo is not null
),
cash_sec as
(
select 
s.HdCreator,
s.HdEditStamp, 
s.HdVersionNo,
s.TransDate as TransDate, 
s.TransId as TransactionId,
s.TransTypeNo as TransTypeNo,
s.TransMsgStatusNo as TransMsgStatusNo,
s.CancelTransMsgId as CancelTransMsgId,
case when (s.CreditPortfolioNo = @PortfolioNo) then s.CreditPortfolioNo 
         when (s.DebitPortfolioNo = @PortfolioNo) then s.DebitPortfolioNo end as PortfolioNo,
(select Id from PtPortfolio port where port.PortfolioNo =  @PortfolioNo) as PortfolioId,
isnull(abs(s.AmountMarketVal), 0) as Amount, 
s.PriceCurrency,
case when (s.AmountMarketVal) > 0  then 'CRDT' else 'DBIT' end as CreditDebitInd,
s.TransactionFee as TransactionFee,
s.TaxFee as TaxFee,
null as Account,
s.PositionID as PositionId,
0 as PerfMethod
from sec s
union
select 
c.HdCreator,
c.HdEditStamp, 
c.HdVersionNo,
c.TransDate, 
c.TransactionId, 
c.TransTypeNo, 
c.TransMsgStatusNo,
c.CancelTransMsgId,
c.PortfolioNo, 
c.PortfolioId, 
c.Amount,
c.Currency, 
c.CreditDebitInd, 
c.TransactionFee,
c.TaxFee,
c.Account, 
c.PositionId, 
c.PerfMethod 
from cash c
)
select 
HdCreator,
HdEditStamp, 
HdVersionNo,
TransDate, 
TransactionId, 
TransTypeNo, 
TransMsgStatusNo,
CancelTransMsgId,
PortfolioNo, 
PortfolioId, 
Amount,
PriceCurrency, 
CreditDebitInd, 
TransactionFee,
TaxFee,
Account, 
PositionId, 
PerfMethod 
from cash_sec 
order by TransDate asc;



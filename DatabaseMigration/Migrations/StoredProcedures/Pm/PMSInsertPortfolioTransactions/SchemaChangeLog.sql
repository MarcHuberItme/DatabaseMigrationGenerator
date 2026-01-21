--liquibase formatted sql

--changeset system:create-alter-procedure-PMSInsertPortfolioTransactions context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSInsertPortfolioTransactions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSInsertPortfolioTransactions
CREATE OR ALTER PROCEDURE dbo.PMSInsertPortfolioTransactions
@PortfolioNo varchar(11), 
@From date,
@To date,
@PerfMethod tinyint -- not used yet
AS 

DELETE from PmPerfTransData WHERE PortfolioNo = @PortfolioNo and PerfMethod = @PerfMethod; 

-- Add transactions to PmPerfTransData (used to calculate external cashflow)
INSERT INTO PmPerfTransData (HdCreator, HdEditStamp, HdVersionNo, TransactionDate , TransactionId, TransTypeNo, TransMsgStatusNo, CancelTransMsgId, PortfolioNo, PortfolioId, Amount, Currency, CreditDebitInd, TransactionFee, TaxFee, AccountNo, PositionId, PerfMethod)
EXEC PMSGetPortfolioTransactions @PortfolioNo, @From, @To, @PerfMethod

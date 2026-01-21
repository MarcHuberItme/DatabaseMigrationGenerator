--liquibase formatted sql

--changeset system:create-alter-procedure-AxCollectTaxReportData context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCollectTaxReportData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCollectTaxReportData
CREATE OR ALTER PROCEDURE dbo.AxCollectTaxReportData

@Creator varchar(20), 
@StartDate date,
@EndDate date


As 

declare @EndLastDate date = Dateadd(d,-1,@StartDate)

declare @TaxReportId uniqueidentifier = NEWID()

declare @SecuritiesCheckOkay bit
declare @BalancesCheckOkay bit
declare @TransDateCheckOkay bit

-- create new AxTaxReport record
exec AxCreateTaxReport @TaxReportId, @Creator, @EndDate

-- select Transactions with account and insert them into AxTaxReportTransaction
exec AxCreateTaxReportTransaction1  @TaxReportId, @Creator, @StartDate, @EndDate

-- select Transactions without account and insert them into AxTaxReportTransaction
exec AxCreateTaxReportTransaction2  @TaxReportId, @Creator, @StartDate, @EndDate

-- select init-balances of all accounts and insert them into AxTaxReportEndOfYearBalance
exec AxCreateTaxReportEndOfYearBalance @TaxReportId, @Creator, @EndLastDate, @StartDate, @EndDate

-- select end-balances of all accounts and insert them into AxTaxReportEndOfYearBalance
exec AxCreateTaxReportEndOfYearBalance @TaxReportId, @Creator, @EndDate, @StartDate, @EndDate

-- select init- and end-balances of all account positions (AxTaxReportEndOfYearBalance) and insert them into AxTaxReportCashMovement
exec AxCreateTaxReportCashMovement @TaxReportId, @Creator, @EndLastDate , @EndDate

-- select init balances of all security positions and insert them into AxTaxReportTransaction
exec AxCreateTaxReportTransactionInitEnd @TaxReportId, @Creator, @EndLastDate, @StartDate, @EndDate, 'INIT'

-- select end balances of all security positions and insert them into AxTaxReportTransaction
exec AxCreateTaxReportTransactionInitEnd @TaxReportId, @Creator, @EndDate, @StartDate, @EndDate, 'END'

-- correcting Transactions due to ISIN change
exec AxCreateTaxReportTransactionISINchange @TaxReportId, @Creator, @EndLastDate, @StartDate, @EndDate

-- add missing init and end balances of all account positions and insert them into AxTaxReportEndOfYearBalance 
exec AxCreateTaxReportEndOfYearBalanceMissing @TaxReportId, @Creator, @EndLastDate, @EndDate

-- add missing init and end balances of all security positions and insert them into AxTaxReportTransaction
exec AxCreateTaxReportTransactionInitEndMissing @TaxReportId, @Creator, @EndLastDate, @EndDate

-- select instruments from AxTaxReportTransaction and insert them into AxTaxReportSecurity
exec AxCreateTaxReportSecurity @TaxReportId, @Creator

-- select prices from AxTaxReportSecurity and insert them into AxTaxReportSecurityPrice
exec AxCreateTaxReportSecurityPrice @TaxReportId, @Creator, @StartDate, @EndDate

-- select exchange values from necessary CyRateRecent and insert them into AxTaxReportExchangeValue
exec AxCreateTaxReportExchangeValue @TaxReportId, @Creator, @StartDate, @EndDate

-- validate data (Init-Quantity + Transactions must be = End-Quantity)
exec AxValidateTaxReportData @TaxReportId, @EndLastDate, @EndDate, @SecuritiesCheckOkay, @BalancesCheckOkay, @TransDateCheckOkay
if @SecuritiesCheckOkay = 0
   begin
      Print char(13) + 'SecuritiesCheck not okay'
   end
if @BalancesCheckOkay = 0
   begin
     Print char(13) + 'BalancesCheck not okay'
   end
if @TransDateCheckOkay = 0
   begin
     Print char(13) + 'BalancesCheck not okay'
   end


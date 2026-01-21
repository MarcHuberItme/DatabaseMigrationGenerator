--liquibase formatted sql

--changeset system:create-alter-procedure-AxCreateTaxReportEndOfYearBalanceMissing context:any labels:c-any,o-stored-procedure,ot-schema,on-AxCreateTaxReportEndOfYearBalanceMissing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AxCreateTaxReportEndOfYearBalanceMissing
CREATE OR ALTER PROCEDURE dbo.AxCreateTaxReportEndOfYearBalanceMissing
@TaxReportId uniqueidentifier,
@Creator varchar(20),
@EndLastDate date,
@EndDate date

as

declare @MissingEndDateAccountsTab table (OwnerIdentification char(7),AccountNo nvarchar(100),AccCurrency char(3))
declare @MissingPrevEndDateAccountsTab table (OwnerIdentification char(7),AccountNo nvarchar(100),AccCurrency char(3))

insert into @MissingEndDateAccountsTab
select OwnerIdentification,AccountNo,AccCurrency 
from   AxTaxReportEndOfYearBalance 
where  ValueDate = @EndLastDate
             and TaxReportId = @TaxReportId
             and AccountNo not in (     select AccountNo 
                                                      from AxTaxReportEndOfYearBalance 
                                                      where ValueDate = @EndDate
													  and TaxReportId = @TaxReportId
                                                 )

insert into @MissingPrevEndDateAccountsTab
select OwnerIdentification,AccountNo,AccCurrency 
from   AxTaxReportEndOfYearBalance 
where  ValueDate = @EndDate
             and TaxReportId = @TaxReportId
             and AccountNo not in (     select AccountNo 
                                                      from AxTaxReportEndOfYearBalance 
                                                      where ValueDate = @EndLastDate
													  and TaxReportId = @TaxReportId
                                                 )

if (select count(*) from @MissingPrevEndDateAccountsTab a join PtAccountBase PAB on a.AccountNo = PAB.AccountNoIbanElect where PAB.OpeningDate < @EndLastDate) > 0
       begin
             print 'Problem with Missing PrevEndDate EndOfYearBalance for Accounts openned before. Check Valuations.'
             select a.AccountNo, PAB.AccountNo, PAB.OpeningDate, PAB.TerminationDate from @MissingPrevEndDateAccountsTab a join PtAccountBase PAB on a.AccountNo = PAB.AccountNoIbanElect
       end

declare @AccountsInTransMissingTable table (OwnerIdentification char(7),AccountNoTax nvarchar(100),AccountNoFinstar nvarchar(100),AccCurrency char(3), OpeningDate date, TerminationDate date)

insert into @AccountsInTransMissingTable
select OwnerIdentification,tr.AccountNo,PAB.AccountNo,AccCurrency,PAB.OpeningDate,PAB.TerminationDate
from AxTaxReportTransaction tr
       join PtAccountBase PAB on tr.AccountNo = PAB.AccountNoIbanElect 
where  tr.AccountNo not in (      select AccountNo from AxTaxReportEndOfYearBalance where TaxReportId = @TaxReportId)
             and tr.TaxReportId = @TaxReportId
             --and PAB.OpeningDate >= @EndLastDate
             --and PAB.TerminationDate <= @EndDate

if (select count(*) from @AccountsInTransMissingTable where OpeningDate < @EndLastDate and (TerminationDate > @EndDate or TerminationDate is null)) > 0
       begin
             print 'Problem with Missing EndOfYearBalance for Accounts openned before or closed after the period. Check Valuations.'
             select * from @AccountsInTransMissingTable where OpeningDate < @EndLastDate and (TerminationDate > @EndDate or TerminationDate is null)
       end

-- CHECKS IF THE ACCOUNTS ARE REALLY 0: they are

insert into AxTaxReportEndOfYearBalance
       select 
             Id = NEWID()
             ,HdCreateDate =  GETDATE()
             ,HdCreator = @Creator
             ,HdChangeDate =  GETDATE()
             ,hdChangeuser = @Creator
             ,Hdeditstamp = NEWID()
             ,HdVersionNo = 1
             ,HdProcessId = Null
             ,HdStatusFlag = Null
             ,HdNoUpdateFlag = Null
             ,Hdpendingchanges = 0
             ,hdpendingsubchanges = 0
             ,hdtriggercontrol = null
             ,TaxReportId = @TaxReportId
             ,OwnerIdentification = right('00000' + cast(PB.PartnerNo as nvarchar(7)), 7)
             ,AccountNo=PAB.AccountNoIbanElect
             ,AccountType = 'GIRO'
             ,AccCurrency=PR.Currency
             ,AccAmount=PPO.ValueProductCurrency
             ,EURAmount=PPO.ValueProductCurrency
                                                           /     ( (     select top 1 Rate 
                                                                                 from   (select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
                                                                                              union  
                                                                                               select 'CHF', 'CHF', @EndDate, Dateadd(dd,1,@EndDate), @EndDate, 1
                                                                                              ) CRR
                                                                                 where       CRR.CySymbolTarget = 'CHF' 
                                                                                              and CRR.CySymbolOriginate = 'EUR'
                                                                                              and cast(@EndDate as date) >= cast(CRR.ValidFrom as date)
                                                                                              and cast(@EndDate as date) < cast(CRR.ValidTo as date)
                                                                                 order by CRR.HdChangeDate desc)
                                                                          /
                                                                          (      select top 1 Rate 
                                                                                 from   (select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
                                                                                              union  
                                                                                               select 'CHF', 'CHF', @EndDate, Dateadd(dd,1,@EndDate), @EndDate, 1
                                                                                              ) CRR
                                                                                 where       CRR.CySymbolTarget = 'CHF' 
                                                                                              and CRR.CySymbolOriginate = PR.Currency
                                                                                              and cast(@EndDate as date) >= cast(CRR.ValidFrom as date)
                                                                                              and cast(@EndDate as date) < cast(CRR.ValidTo as date)
                                                                                 order by CRR.HdChangeDate desc))
                    ,ValueDate = @EndDate
                    ,StatusNo =  0 -- Only StatusNo 1 will be exported to xml
             ,FinstarPortfolioNo = PP.PortfolioNo
             ,FinstarAccountNo = PAB.AccountNo
       from PtBase PB
             join PtPortfolio PP on PP.PartnerId = PB.Id
                                           and PP.ExCustodyBankId is null
             join PtPortfolioType PPT on PPT.PortfolioTypeNo = PP.PortfolioTypeNo
                                           and PPT.IsExCustody = 0
             join PtAccountBase PAB on PAB.PortfolioId = PP.Id
             join PrReference PR on PR.AccountId = PAB.Id
             join PrPrivate PPr on PPr.ProductId = PR.ProductId
             join PtPosition PPO on PPO.ProdReferenceId = PR.Id
       where  PB.ServiceLevelNo = 70
                    and PPr.ProductNo not in (1054,1065)
                    and PB.HdVersionNo < 999999999 and PP.HdVersionNo < 999999999
                    and PPT.HdVersionNo < 999999999 and PAB.HdVersionNo < 999999999
                    and PR.HdVersionNo < 999999999 and PPr.HdVersionNo < 999999999
                    and PPO.HdVersionNo < 999999999
                    and PAB.AccountNoIbanElect in (select AccountNo from @MissingEndDateAccountsTab
                                                                          union select AccountNoTax from @AccountsInTransMissingTable )
       union all
       select 
             Id = NEWID()
             ,HdCreateDate =  GETDATE()
             ,HdCreator = @Creator
             ,HdChangeDate =  GETDATE()
             ,hdChangeuser = @Creator
             ,Hdeditstamp = NEWID()
             ,HdVersionNo = 1
             ,HdProcessId = Null
             ,HdStatusFlag = Null
             ,HdNoUpdateFlag = Null
             ,Hdpendingchanges = 0
             ,hdpendingsubchanges = 0
             ,hdtriggercontrol = null
             ,TaxReportId = @TaxReportId
             ,OwnerIdentification = right('00000' + cast(PB.PartnerNo as nvarchar(7)), 7)
             ,AccountNo=PAB.AccountNoIbanElect --right('0000000' + PAB.AccountNoEdited, 14)
             ,AccountType = 'GIRO'
             ,AccCurrency=PR.Currency
             ,AccAmount=0
             ,EURAmount=0
             ,ValueDate=@EndLastDate
             ,StatusNo =  0 -- Only StatusNo 1 will be exported to xml
             ,FinstarPortfolioNo = PP.PortfolioNo
             ,FinstarAccountNo = PAB.AccountNo
       from PtBase PB
             join PtPortfolio PP on PP.PartnerId = PB.Id
                                           and PP.ExCustodyBankId is null
             join PtPortfolioType PPT on PPT.PortfolioTypeNo = PP.PortfolioTypeNo
                                           and PPT.IsExCustody = 0
             join PtAccountBase PAB on PAB.PortfolioId = PP.Id
             join PrReference PR on PR.AccountId = PAB.Id
             join PrPrivate PPr on PPr.ProductId = PR.ProductId
       where PB.ServiceLevelNo = 70
                    and PPr.ProductNo not in (1054,1065)
                    and PB.HdVersionNo < 999999999 and PP.HdVersionNo < 999999999
                    and PPT.HdVersionNo < 999999999 and PAB.HdVersionNo < 999999999
                    and PR.HdVersionNo < 999999999 and PPr.HdVersionNo < 999999999
                    and PAB.AccountNoIbanElect in (select AccountNo from @MissingPrevEndDateAccountsTab
                                                                                 union select AccountNoTax from @AccountsInTransMissingTable)






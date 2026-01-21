--liquibase formatted sql

--changeset system:create-alter-view-CoEinzelWbMonthDiffView context:any labels:c-any,o-view,ot-schema,on-CoEinzelWbMonthDiffView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEinzelWbMonthDiffView
CREATE OR ALTER VIEW dbo.CoEinzelWbMonthDiffView AS
select 
akt.collno, akt.wbdescription, akt.actflag, akt.dayendflag, akt.monthendflag, akt.quartendflag, 
akt.mevyear, akt.mevmonth, 
akt.ownerid, akt.ptdescription, akt.accountnoedited, 
akt.veragrp, akt.veradate, akt.veradateshort,   
akt.limit, akt.debitbalance, akt.deckungswertohnewb,   
akt.currency, akt.limitkw, akt.debitbalancekw,  akt.exflag, akt.wbassigned,   
akt.productid, akt.producttext, akt.collateralid, akt.accountid, akt.coveradetid,   
akt.allowanceamount, akt.accrualsamount, akt.riskamount, 
prev.allowanceamount as prevallowanceamount, prev.accrualsamount As prevaccrualsamount, prev.riskamount As prevriskamount, 
akt.allowanceamount - isnull(prev.allowanceamount, 0) as diffallowanceamount, 
akt.accrualsamount - isnull(prev.accrualsamount, 0) as diffaccrualsamount, 
akt.riskamount - isnull(prev.riskamount, 0) as diffriskamount,
--(select top 1 prev.allowanceamount from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and            prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevallowanceamount,
--(select top 1 prev.accrualsamount from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and               prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevaccrualsamount,
--(select top 1 prev.riskamount from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and            prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevriskamount,
--akt.allowanceamount - isnull((select top 1 prev.allowanceamount from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and                      prev.accountid = akt.accountid and prev.veragrp < akt.veragrp order by prev.veragrp desc),0) as diffallowanceamount,
-- akt.accrualsamount - isnull((select top 1 prev.accrualsamount from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and                       prev.accountid = akt.accountid and prev.veragrp < akt.veragrp order by prev.veragrp desc),0) as diffaccrualsamount,
-- akt.riskamount - isnull((select top 1 prev.riskamount from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid =                 akt.accountid and prev.veragrp < akt.veragrp order by prev.veragrp desc),0) as diffriskamount,
prev.veragrp as prevveragrp, prev.veradate as prevveradate, prev.coveradetid as prevcoveradetid
-- (select top 1 prev.veragrp from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and                       prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevveragrp,
-- (select top 1 prev.veradate from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and                       prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevveradate,
-- (select top 1 prev.coveradetid from CoEinZelWbMonthView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and                    prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevcoveradetid
from CoEinZelWbMonthView as akt Outer Apply (
	select top 1 allowanceamount, accrualsamount, riskamount, veragrp, veradate, coveradetid
	from CoEinzelWbMonthView 
	where wbassigned = 1 and accountid = akt.accountid and veragrp < akt.veragrp and monthendflag = 1
	order by veragrp desc) prev 
where  akt.wbassigned = 1 and akt.monthendflag = 1

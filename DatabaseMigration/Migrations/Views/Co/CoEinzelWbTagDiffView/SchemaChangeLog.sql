--liquibase formatted sql

--changeset system:create-alter-view-CoEinzelWbTagDiffView context:any labels:c-any,o-view,ot-schema,on-CoEinzelWbTagDiffView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEinzelWbTagDiffView
CREATE OR ALTER VIEW dbo.CoEinzelWbTagDiffView AS
select
akt.collno, akt.wbdescription, akt.actflag, akt.dayendflag, akt.monthendflag, akt.quartendflag, 
akt.mevyear, akt.mevmonth, 
akt.ownerid, akt.ptdescription, akt.accountnoedited, 
akt.veragrp, akt.veradate, akt.veradateshort, 
akt.limit, akt.debitbalance, akt.deckungswertohnewb, akt.currency, akt.limitkw, akt.debitbalancekw, 
akt.exflag, akt.wbassigned, 
akt.productid, akt.producttext, akt.collateralid, akt.accountid, akt.coveradetid, 
akt.allowanceamount, akt.accrualsamount, akt.riskamount , 
prev.allowanceamount as prevallowanceamount, prev.accrualsamount As prevaccrualsamount, prev.riskamount As prevriskamount, 
akt.allowanceamount - isnull(prev.allowanceamount, 0) as diffallowanceamount, 
akt.accrualsamount - isnull(prev.accrualsamount, 0) as diffaccrualsamount, 
akt.riskamount - isnull(prev.riskamount, 0) as diffriskamount, 
--(select top 1 prev.allowanceamount from coeinzelwbTagView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and            prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevallowanceamount, 
--(select top 1 prev.accrualsamount from CoEinZelWbTagView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and               prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevaccrualsamount, 
--(select top 1 prev.riskamount from CoEinZelWbTagView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and            prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevriskamount, 
--akt.allowanceamount - isnull((select top 1 prev.allowanceamount from CoEinZelWbTagView as prev where prev.wbassigned = 1 and                      prev.accountid = akt.accountid and prev.veragrp < akt.veragrp order by prev.veragrp desc), 0) as diffallowanceamount, 
-- akt.accrualsamount - isnull((select top 1 prev.accrualsamount from CoEinZelWbTagView as prev where prev.wbassigned = 1 and                       prev.accountid = akt.accountid and prev.veragrp < akt.veragrp order by prev.veragrp desc), 0) as diffaccrualsamount, 
-- akt.riskamount - isnull((select top 1 prev.riskamount from CoEinZelWbTagView as prev where prev.wbassigned = 1 and prev.accountid =                 akt.accountid and prev.veragrp < akt.veragrp order by prev.veragrp desc), 0) as diffriskamount, 
prev.veragrp as prevveragrp, prev.veradate as prevveradate, prev.coveradetid as prevcoveradetid
-- (select top 1 prev.veragrp from CoEinZelWbTagView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and                       prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevveragrp, 
-- (select top 1 prev.veradate from CoEinZelWbTagView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and                       prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevveradate, 
-- (select top 1 prev.coveradetid from CoEinZelWbTagView as prev where prev.wbassigned = 1 and prev.accountid = akt.accountid and                    prev.veragrp < akt.veragrp order by prev.veragrp desc) as prevcoveradetid
from CoEinzelWbTagView as akt Outer Apply (
	select top 1 allowanceamount, accrualsamount, riskamount, veragrp, veradate, coveradetid
	from CoEinzelWbTagView 
	where wbassigned = 1 and accountid = akt.accountid and veragrp < akt.veragrp 
	order by veragrp desc) prev 
where  akt.wbassigned = 1 

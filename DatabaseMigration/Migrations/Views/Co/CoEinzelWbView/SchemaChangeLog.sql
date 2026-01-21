--liquibase formatted sql

--changeset system:create-alter-view-CoEinzelWbView context:any labels:c-any,o-view,ot-schema,on-CoEinzelWbView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEinzelWbView
CREATE OR ALTER VIEW dbo.CoEinzelWbView AS
select 
WB.Collno, WB.Collsubtype, WB.wbdescription,
--c.collno, c.Collsubtype, c.description as wbdescription, 

cast(IIF(mev.AccountId Is Not Null,1,0) as bit) As actflag,
--case when ( exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear = 9999))
--then 
--1
--else
--0
--end as actflag,	

case when ( mev.Accountid is not null ) then 1 else 0 end as dayendflag,
--case when ( ed.accountid is not null ) or ( mev.Accountid is not null ) then 1 else 0 end as dayendflag,

case When mev.Accountid Is Not Null Or mevM.Accountid Is Not Null Then 1 Else 0 End As monthendflag,
--case when (exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999) )
--or
--( exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear = 9999))
--then 
--1
--else
--0
--end as monthendflag,

case When mev.Accountid Is Not Null Or mevM.mevmonth in (12,3,6,9) Then 1 Else 0 End As quartendflag, mevM.MevYear, mevM.MevMonth,
--case when (exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999 and mevmonth in (12,3,6,9) ))
--or
--( exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear = 9999))
--then 
--1
--else
--0
--end as quartendflag,
--(select mevyear from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999) as mevyear,
--(select mevmonth from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999) as mevmonth,

WB.ownerid, WB.ptdescription, WB.WBPartnerNo,
--c.ownerid, v.ptdescription,

A.AccountNoEdited,
--(select accountnoedited from ptaccountbase where id = d.accountid) as accountnoedited,

d.veragrp, d.veradate, cast(d.veradate as date) as veradateshort, isnull(d.limit,0) as limit,
case when (isnull(d.balance,0) < 0) then abs(isnull(d.balance,0)) else 0 end as debitbalance,

dw.deckungswertohnewb, 
--(select isnull(sum(pledgevalueassign),0) from cobaseasscalc ac where d.veragrp = ac.veragrp and ac.accountid = d.accountid and ac.collateralid <> c.id) as deckungswertohnewb,

d.currency, isnull(d.limitkw,0) as limitkw, 
case when (isnull(d.balancekw,0) < 0) then abs(isnull(d.balancekw,0)) else 0 end as debitbalancekw,
d.exflag, d.wbassigned, d.productid,

TxA.TextShort As producttext,
--case when d.productid is not null
--then
--(select TextShort From AsText where MasterId= (select id from prprivate where productid =d.productid) and LanguageNo=2)
--else
--null
--end
--as producttext,

WB.id as collateralid, d.accountid, d.id as coveradetid,
--c.id as collateralid, d.accountid, d.id as coveradetid,

isnull(d.allowanceamount,0) as allowanceamount, isnull(d.accrualsamount,0) as accrualsamount, 
isnull(d.allowanceamount,0) + isnull(d.accrualsamount,0) as riskamount

from coveradet d 
--join cobase c on d.verabflag = 1 and d.colworkingtype = 130 --And d.Veradate>'2022.10.01' --and d.Veragrp=9529856
--Outer Apply (select isnull(sum(pledgevalueassign),0) As deckungswertohnewb
--	from cobaseasscalc 
--	where d.veragrp = veragrp and accountid = d.accountid and collateralid <> c.id) as dw
--left outer join coveraendday ed on ed.accountid = d.accountid and ed.veragrp =d.veragrp
left outer join cocalcmev mev on mev.accountid = d.accountid and mev.veragrp =d.veragrp and mev.mevyear = 9999
left outer join cocalcmev mevM on mevM.accountid = d.accountid and mevM.veragrp =d.veragrp and mevM.mevyear < 9999
--Join ptdescriptionView v on v.id = c.ownerid
Join PtAccountBase A On d.Accountid=A.Id
Join PrPrivate Pri On d.ProductId=Pri.ProductId
Join AsText TxA On TxA.MasterId=Pri.Id And TxA.LanguageNo=2
Outer Apply (
	Select Distinct B.Id, B.Collno, BA.AccountId, BA.Inactflag, BC.Veragrp, 
	  B.Collsubtype, B.description as wbdescription, B.OwnerId, V.PtDescription,  v.PartnerNo As WBPartnerNo
	From CoBase B Join CoBaseAss BA On B.Id=BA.CollateralId 
	  And B.CollSubType = 6100 And B.Inactflag=0 And BA.Inactflag=0
	  And B.HdVersionNo<999999999 And BA.HdVersionNo<999999999
	Join ptdescriptionView v on v.id = B.ownerid
	Join CoVeraDet BC On D.Accountid=BA.AccountId And BC.Verabflag = 1 and BC.Colworkingtype = 130 and BC.Veragrp = D.Veragrp  
	Join CoVeraGrp G On G.Veragrp=BC.Veragrp And G.Verastat = 100 and G.Wheredowecamefrom = 0 And d.Veragrp=G.Veragrp and A.Id=BA.AccountId
) WB
Outer Apply (select isnull(sum(pledgevalueassign),0) As deckungswertohnewb
	from cobaseasscalc 
	where d.veragrp = veragrp and accountid = d.accountid and collateralid <> WB.id) as dw
where 1=1 
And WB.Collno Is Not Null 
and d.verabflag = 1 and d.colworkingtype = 130 And d.Veragrp=WB.Veragrp and A.Id=WB.AccountId

--And d.veragrp in
--(
--select distinct dx.veragrp from coveradet dx, coveragrp gx
--where 
--dx.verabflag = 1 and 
--dx.colworkingtype = 140 and 
--dx.veragrp = gx.veragrp and 
--gx.verastat = 100 and 
--gx.wheredowecamefrom = 0 and
--dx.collateralid in (select cx.id from cobase  cx where cx.collsubtype = 6100 and cx.inactflag = 0)
--)
--and c.id = (
--select DISTINCT dy.collateralid 
--from coveradet dy,cobase cy,CoBaseass aa 
--where 
--dy.verabflag = 1 and 
--dy.colworkingtype = 140 and 
--dy.veragrp = d.veragrp and 
--dy.verabflag = 1 and
--cy.collsubtype = 6100 and 
--cy.inactflag = 0 and
--dy.collateralid = cy.id and
--aa.collateralid = dy.collateralid and
--aa.accountid =  d.accountid
--)

--liquibase formatted sql

--changeset system:create-alter-view-CoEinzelWbViewFV context:any labels:c-any,o-view,ot-schema,on-CoEinzelWbViewFV,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEinzelWbViewFV
CREATE OR ALTER VIEW dbo.CoEinzelWbViewFV AS
select 
c.collno,
c.description as wbdescription, 
case when ( exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear = 9999))
then 
1
else
0
end as actflag,
case when ( ed.accountid is not null ) or ( mev.Accountid is not null ) then 1 else 0 end as dayendflag,
case when (exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999) )
or
( exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear = 9999))
then 
1
else
0
end as monthendflag,
case when (exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999 and mevmonth in (12,3,6,9) ))
or
( exists (select * from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear = 9999))
then 
1
else
0
end as quartendflag,
(select mevyear from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999) as mevyear,
(select mevmonth from cocalcmev where accountid = d.accountid and veragrp =d.veragrp and mevyear < 9999) as mevmonth,
c.ownerid,
v .ptdescription,
(select accountnoedited from ptaccountbase where id = d.accountid) as accountnoedited,
d.veragrp,
d.veradate,
cast(d.veradate as date) as veradateshort,
isnull(d.limit,0) as limit,
case when (isnull(d.balance,0) < 0)
then
    abs(isnull(d.balance,0))
else
    0
end as debitbalance,
(select isnull(sum(pledgevalueassign),0) from cobaseasscalc ac where d.veragrp = ac.veragrp and ac.accountid = d.accountid and ac.collateralid <> c.id) as deckungswertohnewb,
d.currency,
isnull(d.limitkw,0) as limitkw,
case when (isnull(d.balancekw,0) < 0)
then
    abs(isnull(d.balancekw,0))
else
    0
end as debitbalancekw,
d.exflag,
d.wbassigned,
d.productid,
case when productid is not null
then
(select TextShort From AsText where MasterId= (select id from prprivate where productid =d.productid) and LanguageNo=2)
else
null
end
as producttext,
c.id as collateralid, 
d.accountid,
d.id as coveradetid,
isnull(d.allowanceamount,0) as allowanceamount ,
isnull(d.accrualsamount,0) as accrualsamount,
isnull(d.allowanceamount,0) + isnull(d.accrualsamount,0) as riskamount
from  coveradet d join cobase c on d.verabflag = 1 and d.colworkingtype = 130 
left outer join coveraendday ed on ed.accountid = d.accountid and ed.veragrp =d.veragrp
left outer join cocalcmev mev on mev.accountid = d.accountid and mev.veragrp =d.veragrp and mev.mevyear = 9999
Join ptdescriptionView v on v.id = c.ownerid
where 
d.veragrp in
(
select distinct dx.veragrp from coveradet dx, coveragrp gx
where 
dx.verabflag = 1 and 
dx.colworkingtype = 140 and 
dx.veragrp = gx.veragrp and 
gx.verastat = 100 and 
gx.wheredowecamefrom = 0 and
dx.collateralid in (select cx.id from cobase  cx where cx.collsubtype = 6100 and cx.inactflag = 0)
)
and c.id = (select dy.collateralid from coveradet dy,cobase cy,CoBaseass aa where 
dy.verabflag = 1 and 
dy.colworkingtype = 140 and 
dy.veragrp = d.veragrp and 
dy.verabflag = 1 and
cy.collsubtype = 6100 and 
cy.inactflag = 0 and
dy.collateralid = cy.id and
aa.collateralid = dy.collateralid and
aa.accountid =  d.accountid
)

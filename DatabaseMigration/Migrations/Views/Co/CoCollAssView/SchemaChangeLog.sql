--liquibase formatted sql

--changeset system:create-alter-view-CoCollAssView context:any labels:c-any,o-view,ot-schema,on-CoCollAssView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoCollAssView
CREATE OR ALTER VIEW dbo.CoCollAssView AS
select 
a.Clientid  as AccountClientid,
(select PtDescription from PtDescriptionView where id = a.Clientid) as AccountPtDescription,
case when ((select count(*) from coveradet where  colworkingtype = 130 and accountid = a.accountid  and msgnr = 100 and veragrp = a.veragrp) > 0)
then 'U'
else ' '
end as overflag,
a.veragrp,
a.accountid ,
a.accountNoText,
a.accountNoEdited,
a.accengagament,
a.totamount,
b.pricover,
b.SubpriCover,
b.typecov,
b.pledgevalueassign,
c.PartnerNoEdited,
c.PartnerNo,
c.PtDescription,
c.ownerid,
c.collateralid,
c.cobasecalcid,
c.collno,
c.collsubtype,
c.extkey,

case when c.collno is not null
then c.description
else
'<Neu>' 
end
as description1,
C.pledgevalueper,
c.IsGruppe,
c.pledgevalue,
c.pledgevaluefree,
c.covaluetot,
c.copremresult,
c.drittbetrag, 
c.drittkonto, 
c.drittanz, 
c.drittpfand, 
c.katmaxp,
c.descriptionGe,
case when c.collno is not null
then
case when (drittanz = 0 and drittpfand is null ) or (c.Colltype <> 7000)
then
DescriptionGe 
when (drittanz = 1)
then
DescriptionGe
when (drittanz > 1)
then
DescriptionGe 
else
DescriptionGe + ' ' + drittpfand + ' ' + convert(varchar(30), drittbetrag,1)
end
else
/* noch ändern wenn CoEngDetCalc .id auf cobaseasscalc ist */
(select top 1 remark from CoEngDetCalc where engtype = 2001 and a.veragrp = veragrp and b.typecov = typecov)
end
as detailGe,
c.premisesid
from coengcalc d,coengdetviewacc a, cobaseasscalc b
left join cocollview c 
on c.veragrp = b.veragrp and 
c.cobasecalcid = b.cobasecalcid
 where
d.engstat = 100 and
d.veragrp = b.veragrp and
a.veragrp = b.veragrp and
a.accountid = b.accountid and
(b.collateralid is null or (b.collateralid = c.collateralid))

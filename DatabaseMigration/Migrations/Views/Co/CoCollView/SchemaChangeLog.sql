--liquibase formatted sql

--changeset system:create-alter-view-CoCollView context:any labels:c-any,o-view,ot-schema,on-CoCollView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoCollView
CREATE OR ALTER VIEW dbo.CoCollView AS
select  
x.veragrp,
c.PartnerNoEdited,
d.PartnerNo,
c.PtDescription,
b.ownerid,
b.collateralid,
b.id as cobasecalcid,
b.collno,
b.collsubtype,
b.Colltype,
b.extkey,
b.description,
b.pricover,
b.SubpriCover,
b.typecov,
case when (b.covaluetot = 0)
then 0
else ROUND(pledgevalue/ (covaluetot / 100),1)
end as pledgevalueper, 
case when (b.ownerid in (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 ))
then 1
else 0
end as IsGruppe, 
b.pledgevalue,
b.pledgevaluefree,
b.covaluetot,
b.copremresult,
case 
/* Hier checken auf Drittpfand geber  */     
when (b.ownerid in 
         (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 ) and
     (b.collateralid in (select d1.Collateralid from cobaseasscalc d1 where d1.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
                       (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc 
                        Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
               and d1.veragrp = x.veragrp)))
then 
/*Drittpfand Geber, gehört Kreditnehmer oder Gruppe*/
   (select sum(e1.pledgevalueassign) from cobaseasscalc e1 where b.id = e1.cobasecalcid and
  e1.veragrp = x.veragrp
and 
  e1.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
     (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
) 
when (b.ownerid in (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 ))
then NULL  /*Normal gehört Kreditnehmer oder Gruppe*/
else    /*Drittpfandnehmer ausserhalb Grupper*/
 (select sum(e1.pledgevalueassign) from cobaseasscalc e1 where b.id = e1.cobasecalcid and
  e1.veragrp = x.veragrp
and 
  e1.accountid in 
/* Gibt es Konti welches diese Sicherheit braucht und das Konto gehört zur Gruppe ?, */
     (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
) 
end as drittbetrag, 
case 
/* Hier checken auf Drittpfand geber  */     
when (b.ownerid in 
         (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 ) and
     (b.collateralid in (select d1.Collateralid from cobaseasscalc d1 where d1.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
                       (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc 
                        Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
               and d1.veragrp = x.veragrp)))
then 
/*Drittpfand Geber, gehört Kreditnehmer oder Gruppe*/
 (select e5.AccountNoEdited from ptaccountbase e5 where e5.id = (select top (1) e2.accountid  from cobaseasscalc e2 where b.id = e2.cobasecalcid and
  e2.veragrp = x.veragrp
and 
  e2.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
     (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
)) 
else   
 null
end as drittkonto, 
case 
/* Hier checken auf Drittpfand geber  */     
when (b.ownerid in 
         (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 ) and
     (b.collateralid in (select d1.Collateralid from cobaseasscalc d1 where d1.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
                       (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc 
                        Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
               and d1.veragrp = x.veragrp)))
then 
( select count(*)  from cobaseasscalc e2 where b.id = e2.cobasecalcid and
  e2.veragrp = x.veragrp
and 
  e2.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
     (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
)
else   
0
end as drittanz, 
case 
/* Hier checken auf Drittpfand geber  */     
when (b.ownerid in (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 )and
     (b.collateralid in (select d1.Collateralid from cobaseasscalc d1 where d1.accountid NOT in 
/* Gibt es ein Konto welches diese Sicherheit braucht und das Konto gehört nicht zur Gruppe ?, Wenn ja wird die Sicherheit als Drittpfand (auch) verwendet*/
                       (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc 
                        Where Coengclicalc.veragrp=x.veragrp   and Coengclicalc.isSelected = 1 ))
and d1.typecov = b.typecov    and d1.veragrp = x.veragrp)))
then 'geg. Drittpfand'  /*Drittpfand Geber, gehört Kreditnehmer oder Gruppe*/
when (b.ownerid in (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp and Coengclicalc.isSelected = 1 ))
then  null  /*Normal gehört Kreditnehmer oder Gruppe*/
else 'Drittpfand'  /*Drittpfandnehmer ausserhalb Grupper*/
end as drittpfand, 
case 
when b.copremresult is not null 
then 
(select isnull(DescriptionGes,cast(copremresult as varchar(20))) + '/' + 
isnull(cast (pledgevalueper1 as varchar(2)),'') +
isnull('+' + cast (pledgevalueper2 as varchar(2)),'') +
isnull('+' + cast (pledgevalueper3 as varchar(2)),'') 
/* cast(isnull(pledgevalueper1,0)+isnull(pledgevalueper2,0)+isnull(pledgevalueper3,0) as varchar(6))  */
from copremres 
 where copremres.Copremresult= b.copremresult and copremres.hdversionno < 999999999 )
else 
NULL end as katmaxp,
CASE when (b.Colltype = 7000 )
then b.gbDescription
when (b.Colltype = 1000)
then 'Konto '+ b.extkey
when (b.Colltype = 2000)
then 'Portfolio '+ b.extkey
when (b.Colltype = 4000)
then description
when (b.Colltype = 5000)
then 'Policenr '+ b.extkey
when (b.Colltype = 6000)
then description
else '--undef---'  end 
as DescriptionGe,
b.premisesid
from cobasecalc as b, PtDescriptionView as c,ptbase as d,coveradet as x
where 
b.collateralid = x.collateralid and
b.calcgrp = x.calcgrp and
x.colworkingtype = 140 and
x.verabflag =1 and
c.id = b.ownerid and
c.id = d.id and
b.collateralid in (select collateralid from coveradet  where colworkingtype = 140 and verabflag =1 and veragrp =x.veragrp ) and
b.calcgrp in (select calcgrp from coveradet where colworkingtype = 140 and verabflag =1 and veragrp = x.veragrp )
/* collateral nur bringen wenn es einem aus der Gruppe gehört */
and (b.ownerid in (select clientid  from coengclicalc where Coengclicalc.veragrp=x.veragrp 
                   and Coengclicalc.isSelected = 1 )
/* oder collateral bringen als drittpfand nehmer wenn ein Kredit der einem aus der Gruppe gehören muss das braucht */     
or (b.collateralid in (select dd.Collateralid from cobaseasscalc dd where             
               dd.accountid in (select accountid  from CoEngDetCalc where  clientid in (select clientid  from coengclicalc 
               Where Coengclicalc.veragrp= x.veragrp  and Coengclicalc.isSelected = 1 ))
               and dd.veragrp = x.veragrp))
)


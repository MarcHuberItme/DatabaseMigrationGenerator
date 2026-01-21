--liquibase formatted sql

--changeset system:create-alter-view-CoRiskView context:any labels:c-any,o-view,ot-schema,on-CoRiskView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoRiskView
CREATE OR ALTER VIEW dbo.CoRiskView AS
select 
 a.veragrp, 
 a.veradate,
'K' as recordflag,
 a.priocredit,
 a.accountid,
 m.AccountNo,
 m.AccountNoEdited,
(Select Pri.ProductNo
From PtPosition Pos Join PtPortfolio O On O.Id = Pos.PortfolioId
Join PrReference Ref ON Ref.Id = Pos.ProdReferenceId
Join PrPrivate Pri On Pri.ProductId=Ref.ProductId
Join AsText X On X.MasterId=Pri.Id And X.LanguageNo=2
Join PtAccountBase A On A.Id=Ref.AccountId
Where A.ID = M.ID) AS  Produktno,
(Select Ref.currency
From PtPosition Pos Join PtPortfolio O On O.Id = Pos.PortfolioId
Join PrReference Ref ON Ref.Id = Pos.ProdReferenceId
Join PrPrivate Pri On Pri.ProductId=Ref.ProductId
Join AsText X On X.MasterId=Pri.Id And X.LanguageNo=2
Join PtAccountBase A On A.Id=Ref.AccountId
Where A.ID = M.ID) AS  Accountcurrency,

(Select X.TextShort
From PtPosition Pos Join PtPortfolio O On O.Id = Pos.PortfolioId
Join PrReference Ref ON Ref.Id = Pos.ProdReferenceId
Join PrPrivate Pri On Pri.ProductId=Ref.ProductId
Join AsText X On X.MasterId=Pri.Id And X.LanguageNo=2
Join PtAccountBase A On A.Id=Ref.AccountId
Where A.ID = M.ID) AS  Produkttext,
 a.msgnr as Kontomsg,
 (select textlong from Comsg,astext 
  where a.msgnr = comsg.comsgnr and astext.masterid = comsg.id and astext.languageno = 2) as msgtext, 
 a.remark as FehlernderBetrag,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov in (1,2,3,4,5,6)) as ZugewiesenenTotal,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov = 1) as ZugewiesenenGpf,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov = 2) as ZugewiesenenKurant,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov = 3) as ZugewiesenenOerk,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov = 4) as ZugewiesenUnkurant,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov = 5) as ZugewiesenerBlanko,
 (select sum(Pledgevalueassign)  
   from cobaseasscalc where 
     cobaseasscalc.accountid = a.accountid and 
     cobaseasscalc.veragrp = a.veragrp and cobaseasscalc.Typecov = 6) as ZugewiesenerSchwachBlanko,
 (select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 1 and isGeneralSummary = 1) 
					as debitbalance,					
(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 2 and isGeneralSummary = 1) 
					as existinglimit,					
(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 3 and isGeneralSummary = 1) 
					as intrestoutstanding,	
(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 4 and isGeneralSummary = 1) 
					as existingamoamount,	
(select top (1) dateamount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 4 and isGeneralSummary = 1) 
					as existingdateamo,	
(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 5 and isGeneralSummary = 1) 
					as valuationallowance,	
(select top (1) Compwbbez from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 5 and isGeneralSummary = 1) 
					as Compwbbez,	
(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = a.veragrp and 
					coengdetcalc.accountid = a.accountid and
					coengdetcalc.engtype = 6 and isGeneralSummary = 1) 
					as accengagament,
 null as collateralid,
 null as calcgrp,
        null as Collsubtype,
 null as Colltext,
        null as Collno,
 null as Collmsg1,
 null as msgtext1,
 null as Collmsg2,
 null as msgtext2,
 null as GesamterBelehnungswert,
 null as FreierBelehnungswert,
 null as CollTx1,
 null as CollTx2, 
 null as CollTx3,
 null as CollTx4,
 null as CollTx5,
 null as CollTx6,
(select (select   top (1) UserGroupName from asusergrouping where usergroupNameno = c1.consultantteamname and hdversionno < 999999999 ) 
/* read only one kundenbetreuer out of entire group, take account with the highest priority  */
 FROM ptbase as c1,  ptaccountbase as d1,  ptportfolio as e1
 where  d1.id =  (select top (1) coveradet.accountid from coveradet, coveragrp
 where  coveradet.veragrp = coveragrp.veragrp and  coveragrp.verastat = 100 and
 coveragrp.wheredowecamefrom = 0 and
 coveradet.colworkingtype = 130 and
 coveragrp.veragrp = b.veragrp
 order by coveradet.Priocredit 
 )   and  e1.id = d1.portfolioid and c1.id = e1.partnerid ) as usergroupname
 from coveradet a, coveragrp b, ptaccountbase m
 where
 a.veragrp = b.veragrp and
 b.verastat = 100 and
 b.wheredowecamefrom = 0 and
 a.colworkingtype = 130 and
 a.accountid = m.id 
union
select
 a.veragrp, 
 a.veradate,
'S' as recordflag,
 null as priocredit,
 null as accountid,
 null as accountNo,
 null as accountNoEdited,
 null as Produktno,
null as Accountcurrency,
null as Produkttext,
 null as Kontomsg,
 null as msgtext, 
 null as FehlernderBetrag,
 null as ZugewiesenenTotal,
 null as ZugewiesenenGpf,
 null as ZugewiesenenKurant,
 null as ZugewiesenenOerk,
 null as ZugewiesenUnkurant,
 null as ZugewiesenerBlanko,
 null as ZugewiesenerSchwachBlanko,
 null				as debitbalance,					
null				as existinglimit,					
null	  		as intrestoutstanding,	
null				as existingamoamount,	
null				as existingdateamo,	
null				as valuationallowance,	
null				as Compwbbez,	
null				as accengagament,
 a.collateralid,
 a.calcgrp,
 (select min(Collsubtype)
   from cobasecalc where 
     cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp) as Collsubtype,
 (select textlong from astext ,cosubtype
  where  (select min(Collsubtype)
   from cobasecalc where 
     cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp) 
 = cosubtype.collsubtype  and astext.masterid = cosubtype.id and astext.languageno = 2) as Colltext,
 (select min(Collno)
   from cobasecalc where 
     cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp) as Collno,
 a.msgnr as Collmsg1,
 (select textlong from Comsg,astext 
  where a.msgnr = comsg.comsgnr and astext.masterid = comsg.id and astext.languageno = 2) as msgtext1,
 a.msgnrblowup as Collmsg2,
 (select textlong from Comsg,astext 
  where a.msgnrblowup = comsg.comsgnr and astext.masterid = comsg.id and astext.languageno = 2) as msgtext2,
 (select sum(Pledgevalue)  
   from cobasecalc where 
     cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp) as GesamtBelehnungswert,
 (select sum(Pledgevaluefree)  
   from cobasecalc where 
     cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp) as FreierBelehnungswert,
coalesce((select textshort  from astext ,cotypecov
  where 
   astext.masterid = cotypecov.id and 
    astext.languageno = 2 and
     cotypecov.typecov   in (select distinct cobasecalc.typecov from  cobasecalc where cobasecalc.typecov = 1
     and      cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp
)) ,' ') as 
CollTx1,
coalesce((select textshort  from astext ,cotypecov
  where 
   astext.masterid = cotypecov.id and 
    astext.languageno = 2 and
     cotypecov.typecov  in (select distinct cobasecalc.typecov from  cobasecalc where cobasecalc.typecov = 2
     and      cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp
)) ,' ') as 
CollTx2,
coalesce ((select textshort from astext ,cotypecov
  where 
   astext.masterid = cotypecov.id and 
    astext.languageno = 2 and
     cotypecov.typecov   in (select distinct cobasecalc.typecov from  cobasecalc where cobasecalc.typecov = 3
     and      cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp
)) ,' ') as 
CollTx3,
coalesce ((select textshort  from astext ,cotypecov
  where 
   astext.masterid = cotypecov.id and 
    astext.languageno = 2 and
     cotypecov.typecov   in (select distinct cobasecalc.typecov from  cobasecalc where cobasecalc.typecov = 4
     and      cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp
)),' ')  as 
CollTx4,
coalesce ((select textshort  from astext ,cotypecov
  where 
   astext.masterid = cotypecov.id and 
    astext.languageno = 2 and
     cotypecov.typecov   in (select distinct cobasecalc.typecov from  cobasecalc where cobasecalc.typecov = 5
     and      cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp
) ),' ') as 
CollTx5,
coalesce ((select textshort  from astext ,cotypecov
  where 
   astext.masterid = cotypecov.id and 
    astext.languageno = 2 and
     cotypecov.typecov   in (select distinct cobasecalc.typecov from  cobasecalc where cobasecalc.typecov = 6
     and      cobasecalc.collateralid = a.collateralid and 
     cobasecalc.Calcgrp = a.Calcgrp
)),' ') as 
CollTx6,
(select (select   top (1) UserGroupName from asusergrouping where usergroupNameno = c1.consultantteamname and hdversionno < 999999999 ) 
/* read only one kundenbetreuer out of entire group, take account with the highest priority  */
 FROM ptbase as c1,  ptaccountbase as d1,  ptportfolio as e1
 where  d1.id =  (select top (1) coveradet.accountid from coveradet, coveragrp
 where  coveradet.veragrp = coveragrp.veragrp and  coveragrp.verastat = 100 and
 coveragrp.wheredowecamefrom = 0 and
 coveradet.colworkingtype = 130 and
 coveragrp.veragrp = b.veragrp
 order by coveradet.Priocredit 
 )   and  e1.id = d1.portfolioid and c1.id = e1.partnerid ) as usergroupname
 from coveradet a, coveragrp b
 where
 a.veragrp = b.veragrp and
 b.verastat = 100 and
 b.wheredowecamefrom = 0 and
 a.colworkingtype = 140 
 and (select count(*) from coveradet c9 where c9.veragrp = a.veragrp and c9.colworkingtype in (30,130)) > 0

union
select
 b.veragrp, 
 b.veradate,
'Z' as recordflag,
 null as priocredit,
 null as accountid,
 null as accountNo,
 m.AccountNoEdited as AccountNoEdited,
 null as Produktno,
null as Accountcurrency,
null as Produkttext,
 null as Kontomsg,
 null as msgtext, 
 null as FehlernderBetrag,
 null as ZugewiesenenTotal,
 null as ZugewiesenenGpf,
 null as ZugewiesenenKurant,
 null as ZugewiesenenOerk,
 null as ZugewiesenUnkurant,
 null as ZugewiesenerBlanko,
 null as ZugewiesenerSchwachBlanko,
 null				as debitbalance,					
null				as existinglimit,					
null	  		as intrestoutstanding,	
null				as existingamoamount,	
null				as existingdateamo,	
null				as valuationallowance,	
null				as Compwbbez,	
null				as accengagament,

 null as collateralid,
 null as calcgrp,
        null as Collsubtype,
 null as Colltext,
 p.Collno as collno,
 null as Collmsg1,
 null as msgtext1,
 null as Collmsg2,
 null as msgtext2,
 null as GesamterBelehnungswert,
 null as FreierBelehnungswert,
 null as CollTx1,
 null as CollTx2, 
 null as CollTx3,
 null as CollTx4,
 null as CollTx5,
 null as CollTx6,
(select (select   top (1) UserGroupName from asusergrouping where usergroupNameno = c1.consultantteamname and hdversionno < 999999999 ) 
/* read only one kundenbetreuer out of entire group, take account with the highest priority  */
 FROM ptbase as c1,  ptaccountbase as d1,  ptportfolio as e1
 where  d1.id =  (select top (1) coveradet.accountid from coveradet, coveragrp
 where  coveradet.veragrp = coveragrp.veragrp and  coveragrp.verastat = 100 and
 coveragrp.wheredowecamefrom = 0 and
 coveradet.colworkingtype = 130 and
 coveragrp.veragrp = b.veragrp
 order by coveradet.Priocredit 
 )   and  e1.id = d1.portfolioid and c1.id = e1.partnerid ) as usergroupname
 from coveragrp b, ptaccountbase m, cobasecalc p,cobaseasscalc r
 where
 r.veragrp = b.veragrp and
 b.verastat = 100 and
 b.wheredowecamefrom = 0 and
 r.accountid = m.id and
 r.cobasecalcid = p.id and
 r.collateralid is not null


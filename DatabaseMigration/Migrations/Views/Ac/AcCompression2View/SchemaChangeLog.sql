--liquibase formatted sql

--changeset system:create-alter-view-AcCompression2View context:any labels:c-any,o-view,ot-schema,on-AcCompression2View,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcCompression2View
CREATE OR ALTER VIEW dbo.AcCompression2View AS
SELECT TOP 100 PERCENT
		 x.AccountancyPeriod
		, x.Kat
		, x.GroupDesc
		, x.ProdGroup as  ProductGroup
		, SUM(x.Soll) AS Soll
		, SUM(x.Haben) AS Haben
		, SUM(x.AnzK) As AnzK
		, SUM(x.BestehendeKonti) AS BestehendeKonti
		, SUM(x.NeuerKundeNeuesKonto) AS NeuerKundeNeuesKonto
		, SUM(x.BestehenderKundeNeuesKonto) AS BestehenderKundeNeuesKonto
FROM

(

SELECT M.AccountancyPeriod
		, 'Kat' = ''
		, M.Prod As ProdGroup
		, M.Org As GroupDesc
		, 'Soll' = 0
		, 'Haben' = 0
		, 'AnzK' = 0
		, 'BestehendeKonti' = 0
		, 'NeuerKundeNeuesKonto' = 0
		, 'BestehenderKundeNeuesKonto' = 0
FROM AsMatrixProdOrg M
--WHERE M.AccountancyPeriod = 200912


UNION

select	d.accountancyperiod
		, 'Kat' = 'Budget'
		, d.Prodgroup
		, d.GroupDesc
		, sum(d.Soll) as Soll
		, sum(d.haben) as Haben
		, 'AnzK' = 0
		, 'BestehendeKonti' = 0
		, 'NeuerKundeNeuesKonto' = 0
		, 'BestehenderKundeNeuesKonto' = 0
from	
(
		select	c.accountancyperiod, c.ProdGroup, isnull(c.GroupNo, 22) as GroupNo, isnull(c.GroupDesc,'Ãœbrige') as GroupDesc
				, sum(c.soll) as Soll, sum(c.haben) as Haben
		
		from	(

				select	b.accountancyperiod, b.ProdGroup, isnull(ast.textshort, 'Ãœbrige') as GroupDesc, isnull(augn.GroupNo, 22) as GroupNo
						, b.soll as Soll, b.haben as Haben
				from	(

						select	a.Accountancyperiod, a.privateproductno, a.valuesign, a.positionid,	a.xx
								, case	when	a.xx = 'Aktiv'		then	astsoll.textshort
									when	a.xx = 'Passiv'		then	asthaben.textshort else	'Fehler' end as ProdGroup
								, asthaben.textshort as habengruppe, astsoll.textshort as sollgruppe, a.soll, a.haben
						from	(

								select	Ac2.Accountancyperiod, ac2.privateproductno, ac2.valuesign, pri.id as privateid, ac2.positionid as positionid
										, case	when	ac2.valuesign = 1 then	'Aktiv'
											when	ac2.valuesign = 2 then	'Passiv' else	'falsch' end as 'xx'
										, 'Soll'	= CASE WHEN ac2.ValueSign = 1 THEN ac2.ValueBasicCurrency ELSE 0 END
										, 'Haben'	= CASE WHEN ac2.ValueSign = 2 THEN ac2.ValueBasicCurrency ELSE 0 END	
								from	accompression2 ac2
								join	prprivate pri on pri.productno = ac2.privateproductno
								where	ac2.amounttype = 1
								--and		Ac2.Accountancyperiod = 200912
								) as a
								left join	asgroupmember agmsoll on agmsoll.targetrowid = a.privateid and a.xx = 'Aktiv' 
												and agmsoll.grouptypeid = '{055A87C5-37DA-4446-B332-8933817D8F28}' --nur aktive
								left join	asgroupmember agmhaben on agmhaben.targetrowid = a.privateid and a.xx = 'Passiv'  
												and agmhaben.grouptypeid = '{33574409-2E6F-4754-9720-C6628E58FD75}' --nur passive
								left join	asgroup aghaben on aghaben.id = agmhaben.groupid
								left join	asgroup agsoll on agsoll.id = agmsoll.groupid
								left join	astext asthaben on asthaben.masterid = aghaben.id and asthaben.languageno = 2
								left join	astext astsoll on astsoll.masterid = agsoll.id and astsoll.languageno = 2
						) b
						join	ptposition pos on pos.id = b.positionid
						join	prreference ref on ref.id = pos.prodreferenceid
						join	ptaccountbase pab on pab.id = ref.accountid
						join	ptportfolio ppf on ppf.id = pab.portfolioid
						join	ptbase ptb on ptb.id = ppf.partnerid
						left JOIN	AsUserGroup aug ON isnull(ptb.ConsultantTeamName, 301) = aug.UserGroupName 
						left JOIN	AsUserGrouping augn ON aug.UserGroupName = augn.UserGroupNameNo 
						left JOIN	AsUserGroupingDesc augnd ON augn.GroupNo = augnd.GroupNo 
						left JOIN	AsText ast ON augnd.Id = ast.MasterId AND ast.LanguageNo = 2
						where	aug.hdversionno < 999999999
						and		augn.hdversionno < 999999999
						and		augnd.hdversionno < 999999999
				) c
					group	by	c.accountancyperiod, c.ProdGroup, c.GroupNo, c.GroupDesc
) d
group by d.accountancyperiod, d.Prodgroup, d.groupNo, d.GroupDesc

UNION

select	d.accountancyperiod
		, 'Kat' = 'Menge'
		, d.Prodgroup
		, d.GroupDesc
		, 'Soll' = 0
		, 'Haben' = 0		
		, SUM(d.AnzK) As AnzK
		, SUM(d.NichtNeu) As BestehendeKonti
		, SUM(d.NKNK) As NeuerKundeNeuesKonto
		, SUM(d.BKNK) As BestehenderKundeNeuesKonto
from	
(
		select	c.accountancyperiod, c.ProdGroup, isnull(c.GroupNo, 22) as GroupNo, isnull(c.GroupDesc,'Ãœbrige') as GroupDesc
				, sum(c.soll) as Soll, sum(c.haben) as Haben
				, SUM(c.AnzK) AS AnzK, SUM(c.NKNK) As NKNK, SUM(c.BKNK) AS BKNK, SUM(c.NichtNeu) AS NichtNeu
		
		from	(

				select	b.accountancyperiod, b.ProdGroup, isnull(ast.textshort, 'Ãœbrige') as GroupDesc, isnull(augn.GroupNo, 22) as GroupNo
						, b.soll as Soll, b.haben as Haben
						, b.AnzK
						, 'NKNK' = CASE WHEN pab.OpeningDate BETWEEN (Str(b.AccountancyPeriod) + '01') 
										AND DATEADD(month,1,(Str(b.AccountancyPeriod) + '01')) - 0.000001 
										AND ptb.OpeningDate BETWEEN (Str(b.AccountancyPeriod) + '01') 
										AND DATEADD(month,1,(Str(b.AccountancyPeriod) + '01')) - 0.000001 
										AND b.AnzK = 1 THEN 1 ELSE 0 END
						, 'BKNK' = CASE WHEN pab.OpeningDate BETWEEN (Str(b.AccountancyPeriod) + '01') 
										AND DATEADD(month,1,(Str(b.AccountancyPeriod) + '01')) - 0.000001 
										AND ptb.OpeningDate NOT BETWEEN (Str(b.AccountancyPeriod) + '01') 
										AND DATEADD(month,1,(Str(b.AccountancyPeriod) + '01')) - 0.000001 
										AND b.AnzK = 1 THEN 1 ELSE 0 END
						, 'NichtNeu' = CASE WHEN pab.OpeningDate NOT BETWEEN (Str(b.AccountancyPeriod) + '01') 
										AND DATEADD(month,1,(Str(b.AccountancyPeriod) + '01')) - 0.000001 AND b.AnzK = 1 THEN 1 ELSE 0 END

				from	(

						select	a.Accountancyperiod, a.privateproductno, a.valuesign, a.positionid,	a.xx
								, case	when	a.xx = 'Aktiv'		then	astsoll.textshort
										when	a.xx = 'Passiv'		then	asthaben.textshort else	'Fehler' end as ProdGroup
								, asthaben.textshort as habengruppe, astsoll.textshort as sollgruppe, a.soll, a.haben
								, a.AnzK
						from	(

								select	Ac2.Accountancyperiod, ac2.privateproductno, ac2.valuesign, pri.id as privateid, ac2.positionid as positionid
										, case	when	ac2.valuesign = 1 then	'Aktiv'
												when	ac2.valuesign = 2 then	'Passiv' else	'falsch' end as 'xx'
										, 'Soll'	= CASE WHEN ac2.ValueSign = 1 THEN ac2.ValueBasicCurrency ELSE 0 END
										, 'Haben'	= CASE WHEN ac2.ValueSign = 2 THEN ac2.ValueBasicCurrency ELSE 0 END	
										, ac2.CounterPosition
										, ac2.CounterValue AS AnzK
								from	accompression2 ac2
								join	prprivate pri on pri.productno = ac2.privateproductno
								where	ac2.amounttype = 1
								--and		Ac2.Accountancyperiod = 200912
								) as a
								left join	asgroupmember agmsoll on agmsoll.targetrowid = a.privateid and a.xx = 'Aktiv' 
												and agmsoll.grouptypeid = '{055A87C5-37DA-4446-B332-8933817D8F28}' --nur aktive
								left join	asgroupmember agmhaben on agmhaben.targetrowid = a.privateid and a.xx = 'Passiv'  
												and agmhaben.grouptypeid = '{33574409-2E6F-4754-9720-C6628E58FD75}' --nur passive
								left join	asgroup aghaben on aghaben.id = agmhaben.groupid
								left join	asgroup agsoll on agsoll.id = agmsoll.groupid
								left join	astext asthaben on asthaben.masterid = aghaben.id and asthaben.languageno = 2
								left join	astext astsoll on astsoll.masterid = agsoll.id and astsoll.languageno = 2
						) b
						join	ptposition pos on pos.id = b.positionid
						join	prreference ref on ref.id = pos.prodreferenceid
						join	ptaccountbase pab on pab.id = ref.accountid
						join	ptportfolio ppf on ppf.id = pab.portfolioid
						join	ptbase ptb on ptb.id = ppf.partnerid
						left JOIN	AsUserGroup aug ON isnull(ptb.ConsultantTeamName, 301) = aug.UserGroupName 
						left JOIN	AsUserGrouping augn ON aug.UserGroupName = augn.UserGroupNameNo 
						left JOIN	AsUserGroupingDesc augnd ON augn.GroupNo = augnd.GroupNo 
						left JOIN	AsText ast ON augnd.Id = ast.MasterId AND ast.LanguageNo = 2
						where	aug.hdversionno < 999999999
						and		augn.hdversionno < 999999999
						and		augnd.hdversionno < 999999999
				) c
					group	by	c.accountancyperiod, c.ProdGroup, c.GroupNo, c.GroupDesc
) d
group by d.accountancyperiod, d.Prodgroup, d.groupNo, d.GroupDesc

Union

select	b.accountancyperiod
		, 'Kat' = 'Budget'
		, b.ProdGroup
		, b.oe as GroupDesc
		, sum(b.WertSoll) as Soll
		, sum(b.WertHaben) as Haben
		, 'AnzK' = 0
		, 'BestehendeKonti' = 0
		, 'NeuerKundeNeuesKonto' = 0
		, 'BestehenderKundeNeuesKonto' = 0
from	(
		select	a.accountancyperiod, a.oe, 
				case	when	a.portfoliotypeno in (5003, 5004)
						then	'Va-Depot'
						when	a.portfoliotypeno in (5005)
						then	'Fondsparen-Depot'
						when	a.portfoliotypeno not in (5003, 5004, 5005)
						then	'Depot'
				end as	ProdGroup,
				a.WertSoll, a.WertHaben
		from	(
				select	ac2.accountancyperiod, ast.textshort as oe, ppf.portfoliotypeno,
						case	when	ac2.valuebasiccurrency < 0
								then	ac2.valuebasiccurrency
						end as			WertSoll,
						case	when	ac2.valuebasiccurrency > 0
								then	ac2.valuebasiccurrency
						end as			WertHaben				
				from	accompression2 ac2
				join	ptposition pos on pos.id = ac2.positionid
				join	ptportfolio ppf on ppf.id = pos.portfolioid
				join	ptbase ptb on ptb.id = ppf.partnerid
				left	join asusergrouping aug on isnull(ptb.consultantteamname, 301) = aug.usergroupnameno and aug.hdversionno between 1 and 999999998
				left	join asusergroupingdesc augd on isnull(aug.groupno, 22) = augd.groupno and augd.hdversionno between 1 and 999999998
				left	join astext ast on ast.masterid = augd.id and ast.languageno = 2
				where	ac2.portfoliotype <> '5000'
				and		ac2.portfoliotype < '5010'
				and		ac2.privateproductno is null
				and		ac2.accountancyperiod > '200912'
				and		ac2.valuebasiccurrency <> 0
				) as a
		) as b
group	by b.accountancyperiod, b.prodgroup, b.oe
) x

GROUP BY X.AccountancyPeriod, x.Kat, X.GroupDesc, X.ProdGroup 
--having	x.groupdesc is null
order	by X.AccountancyPeriod, x.Kat, X.GroupDesc, X.ProdGroup 



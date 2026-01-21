--liquibase formatted sql

--changeset system:create-alter-view-AcCompression2CourtDPView context:any labels:c-any,o-view,ot-schema,on-AcCompression2CourtDPView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcCompression2CourtDPView
CREATE OR ALTER VIEW dbo.AcCompression2CourtDPView AS
SELECT	TOP 100 PERCENT 
		x.AccountancyPeriod
		, x.ProdGrp
		, ISNULL(x.GroupNo,22) As GroupNo
		, ISNULL(x.GroupDesc,'Übrige') As GroupDesc
		, sum(x.Courtage) as Amount
from(
select	'AccountancyPeriod' = Year(A.Handelsdatum)*100 + Month(A.Handelsdatum)
	, 'ProdGrp' = 'Courtage', A.Auftragsnummer, A.Handelsdatum, sum(A.gehandelteMenge) as Quantity, A.currency as TradeCurrency, sum(A.zubezpreis) as Price, A.Forex,
	sum(A.zubezPreisCHF) as PriceCHF, A.Valor, A.Instrument, A.Kunde, A.Name, 
	A.SBCode, isnull(A.SB, 'kein Sachbearbeiter') as SB, 
	A.Courtage, A.Status, A.Geschäftsart, a.GroupNo, A.GroupDesc
from	(

select	distinct tr.orderno Auftragsnummer, tt.pricedate Abschlussdatum, ptm.tradedate Handelsdatum, tt.quantity gehandelteMenge, ptm.orderquantity Auftragsmenge, 
	ptm.paymentamount, tt.currency WHG, tt.marketvaluetrcu zubezPreis, tt.ratetrcuhocu Forex, tt.marketvaluehocu zubezPreisCHF, 
	pdv.vdfinstrumentsymbol Valor, pdv.publicdescription Instrument,
	ppf2.portfoliono Kunde, ptb2.name as Name
	, ptb2.ConsultantTeamName AS SBCode, ast5.TextShort As SB
	, asbr.branchno as BranchNo,ast3.textshort as BranchName,
	ptmc.currency, ptmc.amountchargecurrency Courtage, ptct.chargeno, ast2.textshort, 
	case 	when 	ptm.transmsgstatusno = 1
		then	'Original mit folgendem Storno'
		when	ptm.transmsgstatusno = 2
		then	'Storno'
		when	ptm.transmsgstatusno = 3
		then	'Rektifikat'
		when	ptm.transmsgstatusno is null
		then	'Original'
	end as 	Status,
	tr.transtypeno, 
	case 	when	tr.transtypeno = 601
		then	'Titelkauf'
		when	tr.transtypeno = 602
		then	'Titelverkauf'
	end as 	Geschäftsart, isnull(augg.GroupNo, 22) as GroupNo, isnull(ast7.TextShort, 'Übrige') AS GroupDesc
from	pttranstrade tt
join	ptportfolio ppf on ppf.id = tt.portfolioid
join	ptbase ptb on ptb.id = ppf.partnerid
join	pttransmessage ptm on ptm.id = tt.transmessageid
join	pttransaction tr on tr.id = ptm.transactionid
join	prpublicdescriptionview pdv on pdv.id = tr.publicid and pdv.languageno = 2
join	ptportfolio ppf2 on ppf2.id = ptm.debitportfolioid
join	ptbase ptb2 on ptb2.id = ppf2.partnerid
LEFT JOIN AsUserGroup aug ON ptb2.ConsultantTeamName = aug.UserGroupName
LEFT JOIN AsText ast5 ON aug.Id = ast5.MasterId AND ast5.LanguageNo = 2
Left JOIN AsUserGrouping augg ON isnull(ptb2.ConsultantTeamName, 301) = augg.UserGroupNameNo
Left JOIN AsUserGroupingDesc auggd ON augg.GroupNo = auggd.GroupNo
LEFT JOIN AsText ast7 ON auggd.Id = ast7.MasterId AND ast7.LanguageNo = 2
join	pttradingorder pto on pto.orderno = tr.orderno
join	PtTradingOrderMessageView ptomv on ptomv.tradingorderid = pto.id and ptomv.languageno = 2
join 	pttransmessagecharge ptmc on ptmc.transmessageid = ptm.id and ptmc.hdversionno < 999999999
join 	pttranschargetype ptct on ptct.id = ptmc.transchargetypeid
	and ptct.chargeno = 51
join 	astext ast2 on ast2.masterid = ptct.id and ast2.languageno = 2
join	asuser au on au.username = pto.ordercreator
Join	asbranch asbr on asbr.branchno = ptb2.branchno
join 	astext ast3 on ast3.masterid = asbr.id and ast3.languageno = 2
where	ptm.isstockexorder = 0
and	ptomv.isstockexorder = 0
and	ptm.tradedate > Dateadd(d, -1, Convert(datetime,'20091201',104))
and	ptm.tradedate < Dateadd(d, 1, Convert(datetime,'20111231',104))
	) as A
group 	by A.Auftragsnummer, A.Handelsdatum, A.currency, A.Forex,
	A.Valor, A.Instrument, A.Kunde,A.Name, A. SBCode, A.SB, A.Courtage, A.Status, A.Geschäftsart, 
	a.GroupNo, A.GroupDesc)
AS x
GROUP BY x.AccountancyPeriod, x.ProdGrp, x.GroupNo, x.GroupDesc
ORDER BY x.AccountancyPeriod, x.ProdGrp, x.GroupNo, x.GroupDesc 

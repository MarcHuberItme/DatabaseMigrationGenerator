--liquibase formatted sql

--changeset system:create-alter-procedure-RunToFileQiReport context:any labels:c-any,o-stored-procedure,ot-schema,on-RunToFileQiReport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunToFileQiReport
CREATE OR ALTER PROCEDURE dbo.RunToFileQiReport
-- Add the parameters for the stored procedure here
	@DateFrom DATETIME,
	@DateTo DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @DatumVJ datetime

	SET @DatumVJ = DATEADD(month,-2,@DateFrom)

	declare @TemplatesExcluded varchar(100)
	select	@TemplatesExcluded=a.Value 
	from	AsParameterView a 
	where	a.ParameterName = 'QIReportingExcluded'

-- Start select Statement
	SELECT	(SELECT LEFT(A.Instr, CHARINDEX(' ', A.Instr))) as 'ISIN', (SUBSTRING(A.Instr, CHARINDEX(' ', A.Instr), LEN(A.Instr))) AS 'NAME',
		A.Event AS 'CA-REFERENCE',
		A.Betr AS 'CA-RATIO',
		A.ExDate AS 'EX DATE',
		'' AS 'RECORD-DATE',
		A.ValueDate AS 'VALUE-DATE',
		'' AS 'IRS PAID OUT DATE',
		'' AS 'IRS PAYMENT DATE',
		A.IRSCode AS 'INCOME CODE',
		'' AS 'ACCOUNT',
		'' AS 'TAXATION CATEGORY',
		RecC3 AS 'RECIPIENT CODE C3',
		RecC4 AS 'RECIPIENT CODE C4',
		A.WHG AS 'CRNC',
		SUM(A.ausgMenge) AS 'QUANTITY',
		SUM(A.BetrBr) AS 'GROSS AMT',
		A.Satz AS 'TAX-RATE (%)',
		SUM(A.StBetr) AS 'SOURCE TAX AMT',
		'' AS 'ADL TAX AMT',
		SUM(A.BetrNtSIS) AS 'NET AMOUNT',
		'' AS 'GROSS AMT IN USD',
		'' AS 'SOURCE TAX AMT IN USD',
		'' AS 'ADDITIONAL TAX AMOUNT IN USD',
		'' AS 'NET AMOUNT IN USD',
		ExC3 AS 'EXEMPTION CODE C3',
		'' AS 'EXEMPTION CODE C4',
		'' AS 'TAX TYPE',
		'' AS 'TAX WITHHELD BY OTHER AGENT',
		'' AS 'SCO',
		'' AS 'EXCHANGE RATE',
		A.QIEIN AS 'QI REFERENCE',
		A.GIID AS 'GIIN',
		A.LOBCode AS 'FinStar QI Code',
		PartnerNo AS 'Partner Nummer'
	FROM	(SELECT	evb.eventno AS Event, evb.effectivedate AS Datum, pdv.publicdescription AS Instr, 
			CASE WHEN evdt.nodesecondtree = 'USIRS'
				THEN pub.usirsincomecode
				ELSE ''
			END AS IRSCode,
			pdv.instrumenttypeno AS InstrTyp, ast.textshort AS InstrTypTxt, ptb.partnerno AS Partner, pad.reportadrline AS PartnerInfo, 
			pfc.countrycode AS Domizil, atx.TaxProgramNo,aqi.QIStatusNo AS QIStatusNo, aqi.LOBCode AS LOBCode, pscv.portfoliono AS Pf, pab.accountno AS kto, 
			evd.debitcurrency AS WHG, evd.debitamount AS Betr, esp.executedquantity AS ausgMenge, 
			epd.mantaxregulationcode AS StCode, era.taxratedebit AS Satz, era.chargeno AS Belart, ast2.textshort AS BelartTxt, evv.exdate AS ExDate, aqp.ExternalBankId AS GIID, aqp.SenderBankId AS QIEIN, evv.ValueDate AS ValueDate,
			CASE WHEN	evd.debitamountquotetypeno = 1
			THEN	(executedquantity*evd.debitamount) 
			WHEN	evd.debitamountquotetypeno = 2
			THEN	((executedquantity*evd.debitamount)/100)
			END AS BetrBr, 
			CASE WHEN	evd.debitamountquotetypeno = 1
			THEN	(executedquantity*evd.debitamount*era.taxratedebit/100) 
			WHEN	evd.debitamountquotetypeno = 2
			THEN	(((executedquantity*evd.debitamount)/100)*(era.taxratedebit/100))
			END AS StBetr,
			CASE WHEN	evd.debitamountquotetypeno = 1
			THEN	((executedquantity*evd.debitamount)-(executedquantity*evd.debitamount*era.taxratedebit/100))
			WHEN	evd.debitamountquotetypeno = 2
			THEN	((executedquantity*evd.debitamount)/100)-((((executedquantity*evd.debitamount)/100)*(era.taxratedebit/100)))
			END AS BetrNtSIS,
			CASE WHEN aqi.LOBCode = '200-00' 
			THEN	12
			END AS RecC3,
			CASE WHEN aqi.LOBCode = '40-00' OR aqi.LOBCode = '90-00'
			THEN	48
			END AS RecC4,
			CASE WHEN aqi.LOBCode = '70-02'
			THEN	04
			END AS ExC3,
			CASE WHEN aqi.LOBCode = '200-00'
			THEN	ptb.partnerno
			END AS PartnerNo
			FROM	evbase	evb
			JOIN	prpublicdescriptionview pdv ON pdv.id = evb.publicid and pdv.languageno = 2
			LEFT	OUTER JOIN prpublic pub ON pub.id = pdv.id
			JOIN	evvariant evv ON evv.eventid = evb.id
			JOIN    evtemplate evt ON evt.id = evv.eventtemplateid
			and evt.TemplateNo not in (select * from string_split(@TemplatesExcluded,','))
			LEFT	OUTER JOIN prpublicinstrumenttype pit ON pit.instrumenttypeno = pdv.instrumenttypeno
			LEFT	OUTER JOIN astext ast ON ast.masterid = pit.id and ast.languageno = 2
			JOIN	evdetail evd ON evd.eventvariantid = evv.id
			JOIN	evdetailtax evdt ON evdt.eventdetailid = evd.id
			LEFT 	OUTER JOIN evdetailtaxrate evdtr ON evdtr.eventdetailtaxid = evdt.id
			JOIN	evselectionpos esp ON esp.eventid = evb.id and esp.posprocstatusno = 20
			JOIN	ptpositionsecclientview pscv ON pscv.id = esp.positionid and pscv.languageno = 2
			JOIN	ptportfolio ppf ON ppf.id = pscv.portfolioid
			JOIN	ptbase ptb ON ptb.id = ppf.partnerid
			JOIN	ptaddress pad ON pad.partnerid = ptb.id and pad.addresstypeno = 11
			LEFT OUTER JOIN	ptfiscalcountry pfc ON pfc.partnerid = ptb.id
			LEFT OUTER JOIN	ptaccountreferenceview parv ON parv.id = esp.accountreferenceid
			LEFT OUTER JOIN	ptaccountbase pab ON pab.id = parv.accountid
			LEFT	OUTER JOIN evposdetail epd ON epd.selectionposid = esp.id
			JOIN    evtaxregulation etr ON etr.taxregulationcode = isnull(epd.mantaxregulationcode, evdt.mantaxregulationcode)
			LEFT	OUTER JOIN evtaxperiod etp ON etp.taxregulationid = etr.id
					and (etp.validfrom is null or etp.validfrom =	(SELECT MAX(a.validfrom)
										FROM	evtaxperiod a
										JOIN	evtaxregulation b ON b.id = a.taxregulationid
										WHERE	a.validfrom <= CASE WHEN evt.PositionCalcTypeNo = 1 THEN evv.exdate
																	WHEN evt.PositionCalcTypeNo = 2 THEN evv.valuedate
																	WHEN evt.PositionCalcTypeNo = 3 THEN evb.transdate END
												and b.id = etr.id))
			LEFT	OUTER JOIN evtaxrate era ON era.taxperiodid = etp.id
			LEFT	OUTER JOIN pttranschargetype tct ON tct.chargeno = era.chargeno
			LEFT	OUTER JOIN astext ast2 ON ast2.masterid = tct.id and ast2.languageno = 2
			LEFT	OUTER JOIN AiTaxStatus atx ON atx.partnerid = ptb.id 
					and atx.TaxProgramNo = 10840
					and	atx.hdversionno < 999999999
					and	(atx.ValidFrom is null or atx.ValidFrom <= CASE WHEN evt.PositionCalcTypeNo = 1 THEN evv.exdate
																 WHEN evt.PositionCalcTypeNo = 2 THEN evv.valuedate
																 WHEN evt.PositionCalcTypeNo = 3 THEN evb.transdate END) 
					and	(atx.ValidTo is null or atx.ValidTo >= CASE WHEN evt.PositionCalcTypeNo = 1 THEN evv.exdate
																 WHEN evt.PositionCalcTypeNo = 2 THEN evv.valuedate
																 WHEN evt.PositionCalcTypeNo = 3 THEN evb.transdate END) 
			LEFT JOIN AiTaxDetailQI aqi ON atx.id = aqi.TaxStatusId
			LEFT JOIN AiTaxQIStatus aqs ON aqi.QIStatusNo = aqs.QIStatusNo
			LEFT JOIN AiTaxProgram aqp ON aqp.TaxProgramNo = 10840
			LEFT JOIN astext ON aqs.id = astext.MasterId and astext.LanguageNo = 2
			WHERE	((evb.effectivedate between @DateFrom and @DateTo OR evv.valuedate between @DateFrom and @DateTo)
						-- also accept null as exdate
						AND (evv.exdate between @DatumVJ and @DateTo OR evv.exdate is null))
			and	pub.UsIrsIncomeCode is not null
			and	esp.executedquantity > 0
			and	evb.eventstatusno = 99
			and	(era.chargeno is null or era.chargeno <> 311)
			and	pfc.hdversionno < 999999999
	) AS A
	GROUP	BY A.Instr,A.Event,A.Datum,A.IRSCode,A.InstrTyp,A.InstrTypTxt,A.Domizil,A.QIStatusNo,A.WHG,A.Betr,A.StCode,A.Satz,A.Belart,A.BelartTxt,A.ExDate,A.QIEIN,A.GIID,RecC3,RecC4,ExC3,A.ValueDate,A.LOBCode,PartnerNo

END

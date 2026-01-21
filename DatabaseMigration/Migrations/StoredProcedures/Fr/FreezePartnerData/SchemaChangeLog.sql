--liquibase formatted sql

--changeset system:create-alter-procedure-FreezePartnerData context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezePartnerData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezePartnerData
CREATE OR ALTER PROCEDURE dbo.FreezePartnerData
@ReportDate datetime

AS 

INSERT INTO AcFrozenPartner

(HdVersionNo, ReportDate, PartnerId, PartnerNo, LegalStatusNo, SexStatusNo, BusinessTypeCode, NogaCode2008, BranchNo, ReportAdrLine, FiscalDomicileCountry, ArCode)

SELECT 1, @ReportDate, Pt.Id, Pt.PartnerNo, Pt.LegalStatusNo, Pt.SexStatusNo, Pt.BusinessTypeCode, Pt.NogaCode2008, Pt.BranchNo, Adr.ReportAdrLine, Adr.CountryCode, Pt.ArCode
FROM PtBase AS Pt
INNER JOIN (
SELECT DISTINCT Id FROM (

SELECT PtBase.Id FROM PtBase
INNER JOIN PtPortfolio AS Pf ON PtBase.Id = Pf.PartnerId
INNER JOIN PtPosition  AS Pos ON Pos.PortfolioId = Pf.Id WHERE Quantity <> 0

UNION ALL

SELECT PtBase.Id FROM PtBase
INNER JOIN PtPortfolio AS Pf ON PtBase.Id = Pf.PartnerId
INNER JOIN PtAccountBase  AS Acc ON Acc.PortfolioId = Pf.Id WHERE Acc.TerminationDate IS NULL

UNION ALL

SELECT PtBase.Id FROM PtBase
INNER JOIN PrPublic AS PUB ON PtBase.Id = PUB.NamingPartnerId OR PtBase.Id = PUB.IssuerId

UNION ALL

-- Partner, welche als Sicherheitengeber figurieren
SELECT PtBase.Id FROM PtBase
INNER JOIN CoBase Cb ON PtBase.Id = cb.OwnerId
INNER JOIN CoBaseass Cba ON Cb.Id = Cba.CollateralId

) AS PtIdList ) AS PtId ON Pt.Id = PtId.Id
LEFT OUTER JOIN PtAddress AS Adr ON Pt.Id = Adr.PartnerId AND Adr.AddressTypeNo = 11

-- retrieve swiss town no for swiss domiciled partners
Update AcFrozenPartner
SET SwissTownNo = Data.SwissTownNo
FROM  (
SELECT Fp.Id, ISNULL(Min(FdMain.SwissTownNo), Min(FdSec.SwissTownNo)) AS SwissTownNo FROM AcFrozenPartner AS Fp
LEFT OUTER JOIN PtFiscalDomicile AS FdMain ON Fp.PartnerId = FdMain.PartnerId AND FdMain.IsPrimaryDomicile = 1 AND FdMain.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtFiscalDomicile AS FdSec ON Fp.PartnerId = FdSec.PartnerId AND FdSec.IsPrimaryDomicile = 0 AND FdSec.HdVersionNo BETWEEN 1 AND 999999998
WHERE Fp.FiscalDomicileCountry = 'CH'
group by Fp.Id) AS Data 
WHERE AcFrozenPartner.Id = Data.Id AND AcFrozenPartner.ReportDate = @ReportDate 

-- retrieve canton for swiss domiciled partners
Update AcFrozenPartner
SET Canton = St.CantonSymbol
FROM AsSwissTown AS St
WHERE AcFrozenPartner.SwissTownNo = St.SwissTownNo AND AcFrozenPartner.ReportDate = @ReportDate

-- retrieve nationality
Update AcFrozenPartner
SET Nationality = Data.CountryCode
FROM  (
SELECT Fp.Id, ISNULL(Min(Main.CountryCode), Min(Sec.CountryCode)) AS CountryCode FROM AcFrozenPartner AS Fp
LEFT OUTER JOIN PtNationality AS Main ON Fp.PartnerId = Main.PartnerId AND Main.CountryCode = 'CH' AND Main.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtNationality AS Sec ON Fp.PartnerId = Sec.PartnerId AND Sec.CountryCode <> 'CH' AND Sec.HdVersionNo BETWEEN 1 AND 999999998
group by Fp.Id) AS Data 
WHERE AcFrozenPartner.Id = Data.Id AND AcFrozenPartner.ReportDate = @ReportDate

-- Anzahl Angestellte ermitteln
UPDATE AcFrozenPartner
SET Employees = Result.Employees, EmployeeGroupNo = Eng.GroupNo, FireEmployeeValue = Eng.FireValue
FROM AcFrozenPartner AS Fp
INNER JOIN (
SELECT Fp.Id, BR.Counter, BR.MaxDate, MAX(BR_1.Employees) AS Employees
FROM AcFrozenPartner AS Fp
LEFT OUTER JOIN (
	SELECT PartnerId, COUNT(*) AS Counter, MAX(BR.Date) AS MaxDate 
        FROM PtBusinessRatio AS BR 
        WHERE BR.HdVersionNo BETWEEN 1 AND 999999998
        GROUP BY BR.PartnerId) AS BR ON Fp.PartnerId = BR.PartnerId
LEFT OUTER JOIN PtBusinessRatio AS BR_1 ON Fp.PartnerId = BR_1.PartnerId AND BR.Counter >= 1 AND (BR.MaxDate = BR_1.Date OR BR.MaxDate IS NULL) AND BR_1.HdVersionNo BETWEEN 1 AND 999999998
WHERE BR.Counter >= 1
GROUP BY Fp.Id, BR.Counter, BR.MaxDate) AS Result ON Fp.Id = Result.Id
LEFT OUTER JOIN AcEmployeeNoGroup AS Eng ON Result.Employees >= Eng.RangeFrom AND Result.Employees <= Eng.RangeTo
WHERE Fp.ReportDate = @ReportDate 

-- NogaKlasse / NogaGruppe / NogaAbteilung ermitteln
Update AcFrozenPartner
SET NogaAbteilung2008 = List.NogaAbteilung, NogaGruppe2008 = List.NogaGruppe, NogaKlasse2008 = List.NogaKlasse
FROM (
	SELECT 
	Pt.Id,
	CASE 
	WHEN LEN(Code.NogaCode) < 2 THEN NULL
	WHEN Code.NogaAbteilung IS NULL OR Code.NogaAbteilung = '' THEN LEFT(NogaCode,2)
	ELSE Code.NogaAbteilung
	END AS NogaAbteilung,
	CASE 
	WHEN LEN(Code.NogaCode) < 3 THEN NULL
	WHEN Code.NogaGruppe IS NULL OR Code.NogaGruppe = '' THEN LEFT (NogaCode,3)
	ELSE Code.NogaGruppe
	END AS NogaGruppe,
	CASE 
	WHEN LEN(Code.NogaCode) < 4 THEN NULL
	WHEN Code.NogaKlasse IS NULL OR Code.NogaKlasse = '' THEN LEFT (NogaCode,4)
	ELSE Code.NogaKlasse
	END AS NogaKlasse,
	Code.NogaCode
	FROM AcFrozenPartner  AS Pt
	INNER JOIN PtNoga2008 AS Code ON Pt.NogaCode2008 = Code.NogaCode
	WHERE Pt.ReportDate = @ReportDate ) AS List
WHERE List.Id = AcFrozenPartner.Id AND AcFrozenPartner.ReportDate = @ReportDate 

-- TKBN Telekurs Branchencode
UPDATE AcFrozenPartner
SET TKBNSectorCode = SectorCode
FROM (
	SELECT Pt.Id, MIN(S.SectorCode) AS SectorCode 
	FROM AcFrozenPartner AS Pt
	INNER JOIN PtBaseStructure AS BS ON Pt.PartnerId = BS.MasterId
	INNER JOIN PtBaseStructureAssign AS BSA ON BS.Id = BSA.StructureId
	INNER JOIN PtSector AS S ON BSA.ForeignKeyId = S.Id
	WHERE BS.TableName = 'PtSector' AND Scheme = 'TKBN' 
	AND BS.StructureTypeNo = 2
	AND BS.HdVersionNo BETWEEN 1 AND 999999998
	AND BSA.HdVersionNo BETWEEN 1 AND 999999998
	AND Pt.ReportDate = @ReportDate
	GROUP BY Pt.Id) AS SectorList
WHERE AcFrozenPartner.ReportDate = @ReportDate
AND AcFrozenPartner.Id = SectorList.Id



-- Counterparty Information
UPDATE AcFrozenPartner
SET ArCode = (SELECT TOP 1 cp.ArCode
              FROM AcFireCounterParty cp 
              WHERE cp.PartnerId = AcFrozenPartner.PartnerId 
                  and cp.HdVersionNo < 999999999
                  and cp.ArCode is not null
                  order by cp.HdChangeDate desc
             ) 
WHERE AcFrozenPartner.ReportDate = @ReportDate
   and AcFrozenpartner.ArCode is NULL


UPDATE AcFrozenPartner SET C510_Override = cp.C510, C026_Deri = cp.C026Deri, C026_Repo = cp.C026Repo, C026_DF = cp.C026DF
    FROM AcFrozenPartner fp
        JOIN AcFireCounterParty cp on cp.PartnerId = fp.PartnerId
WHERE fp.ReportDate = @ReportDate
   and cp.HdVersionNo < 999999999





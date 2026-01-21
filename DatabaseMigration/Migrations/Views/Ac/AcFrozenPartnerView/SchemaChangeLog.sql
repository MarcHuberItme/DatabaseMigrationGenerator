--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenPartnerView context:any labels:c-any,o-view,ot-schema,on-AcFrozenPartnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenPartnerView
CREATE OR ALTER VIEW dbo.AcFrozenPartnerView AS
SELECT TOP 100 PERCENT
Id, HdVersionNo, ReportDate, PartnerId, PartnerNo, SexStatusNo, LegalStatusNo, BranchNo, ReportAdrLine, 
SwissTownNo, Canton, FiscalDomicileCountry, Nationality, Employees, EmployeeGroupNo, FireEmployeeValue, 
NogaAbteilung2008, NogaGruppe2008, NogaKlasse2008, 
CASE 
WHEN NogaCode2008 IS NULL THEN NULL
WHEN LEN(NogaCode2008) < 2 THEN NULL
WHEN LEN(NogaCode2008) < 6 THEN NogaCode2008 + REPLICATE('0', 6 - LEN(NogaCode2008) )
ELSE NogaCode2008
END AS NogaCode2008,
CASE
-- Private personen, unabhängig vom Noga-Code:
WHEN LegalStatusNo <= 30
                                THEN 1000
-- (nichtfinanzielle Unternehmungen; 3000 = private, 9000 = öffentliche)
--******************************************************************************************************************************
-- WHEN (reportadrline like '%Postfinance AG%' or reportadrline like '%schweiz%Post%') AND SexStatusNo = 3 AND FiscalDomicileCountry = 'CH' 		THEN 9000 

WHEN NogaCode2008 = '701001'    THEN 4300        -- Firmensitzaktivitäten von Finanzgesellschaften 
WHEN NogaCode2008 = '701002'    THEN 3000        -- Firmensitzaktivitäten von anderen Gesellschaften 
WHEN NogaAbteilung2008 = '37' and LegalStatusNo  IN(48,60) Then 8400   -- Abwasserverand Gemeinde


WHEN NogaAbteilung2008 BETWEEN '01' AND '63' OR NogaAbteilung2008 BETWEEN '68' AND '82'          						THEN 3000 
WHEN NogaAbteilung2008 = '85' AND LegalStatusNo NOT IN (48,60,56,58) /*Private Schulen*/	 						THEN 3000              
WHEN NogaAbteilung2008 = '86' /* Gesundheitswesen */											THEN 3000
-- Altersheime / Psychosoz. Betreuung
WHEN NogaGruppe2008 IN ('872', '873')												THEN 3000 
-- Pflegeheime / Sonstige Heime und Sozialwesen
WHEN (NogaGruppe2008 IN('871', '879') OR NogaAbteilung2008 = '88' OR NogaKlasse2008 IN ('9101','9499')) AND LegalStatusNo NOT IN (46,48,50,60,56,58)	THEN 3000 
-- 
WHEN NogaKlasse2008 BETWEEN '9102' AND '9419' OR NogaCode2008 IN ('94')								THEN 3000 
WHEN NogaAbteilung2008 IN ('90', '95', '96')												THEN 3000
WHEN NogaAbteilung2008 In ('93')													THEN 6000
WHEN NogaAbteilung2008 IN ('99') /* internationale Organisationen */										THEN 7000
-- (National und Zentralbanken; 5100)
--******************************************************************************************************************************
WHEN NogaKlasse2008 = '6411'                                                                 									THEN 5100

-- (Finanzielle Unternehmen / Banken)
--******************************************************************************************************************************
WHEN NogaCode2008 = '641901' AND Left(ReportAdrLine,14) IN('Pfandbriefbank','Pfandbriefzent') AND FiscalDomicileCountry = 'CH' 			THEN 5140 -- Pfandbriefzentrale und Pfandbriefbank
WHEN NogaCode2008 = '641902' AND Canton NOT IN ('VD', 'BE')                                  								THEN 5110 -- Kantonalbanken mit Staatsgarantie
-- WHEN NogaCode2008 = '641911'                                                                 									THEN 5130 -- Andere Gemeinschaftseinrichtungen der Banken
WHEN NogaCode2008 = '641912'                                                                 									THEN 5250 -- Effektenhändl. und Fin.-ges., nicht Bankengesetz unterstellt
WHEN NogaCode2008 = '641914'                                                                 									THEN 5400 -- multilaterale Entwicklungsbanken
WHEN NogaCode2008 = '642001'    THEN 4300        -- Finanzholdinggesellschaften
WHEN NogaCode2008 = '642002'    THEN 3000        -- Andere Holdinggesellschaften
WHEN NogaKlasse2008 = '6411'                                                                 									THEN 5100 -- National- und Zentralbanken
WHEN NogaGruppe2008 = '641'									 				THEN 5200 -- Banken die dem Bankgesetz unterstellt sind
WHEN NogaGruppe2008 = '643'									 				THEN 4600 -- Stiftungen
WHEN NogaAbteilung2008 = '64'								 					THEN 4300 -- Finanzierungs- und Verm.verw. nicht dem Bankengesetz unterstellt

-- (Versicherungen und Pensionskassen)
--******************************************************************************************************************************
WHEN NogaGruppe2008 IN ('651','652')							 					THEN 4200 -- Versicherungen / Krankenkassen
WHEN NogaGruppe2008 IN ('653')								 					THEN 4100 -- Pensionskassen
WHEN NogaAbteilung2008 IN ('65')													THEN 4200 -- Versicherungen

-- (Mit den Kreditinstituten verbundene Tätigkeiten)
--******************************************************************************************************************************
WHEN NogaKlasse2008 = '6611'                                                                 									THEN 4400 -- Börsen und Clearinghäuser gem. ERV
WHEN NogaKlasse2008 = '6612' 								 					THEN 4000 -- Börsen und Clearing Häuser nicht gem. ERV
WHEN NogaKlasse2008 = '6619'                                                                 									THEN 4700 -- Mit den Kreditinstituten verbundene Tätigkeiten
WHEN NogaGruppe2008 = '662'									 				THEN 4250 -- Mit den Vers. verbundene Tätigkeiten
WHEN NogaGruppe2008 = '663'									 				THEN 4500 -- Kollektivanlagestiftungen gem. KAG

-- (Öffentliche Hand: Bund, Kantone, Gemeinden, öffentliche Schulen,...)
--******************************************************************************************************************************
-- Öffentliche Verwaltung
WHEN NogaGruppe2008 = 841 AND LegalStatusNo IN (48,60)    										THEN 8400 -- Gemeinden
WHEN NogaGruppe2008 = 841 AND LegalStatusNo = 58                                           								THEN 8300 -- Kantone
WHEN NogaGruppe2008 = 841 AND LegalStatusNo = 56                                           								THEN 8100 -- Bund
WHEN NogaGruppe2008 = 841									 				THEN 8400 -- Rest Gemeinden
-- Auswertige Angelegenheiten, Justiz und öffentliche Sicherheit
WHEN NogaKlasse2008  = '8421' AND LegalStatusNo NOT IN (48,60,58)									THEN 8100 -- Bund
WHEN NogaGruppe2008 = 842 AND LegalStatusNo IN (48,60)  						 				THEN 8400 -- Gemeinden
WHEN NogaGruppe2008 = 842 AND LegalStatusNo = 58							 				THEN 8300 -- Kantone
WHEN NogaGruppe2008 = 842 AND LegalStatusNo = 56							 				THEN 8100 -- Bund
WHEN NogaGruppe2008 = 842 	 								 				THEN 8400 -- Rest Gemeinden
-- Schulen
WHEN NogaAbteilung2008 = '85' AND LegalStatusNo IN (48, 60)					 					THEN 8400 -- Gemeinden
WHEN NogaAbteilung2008 = '85' AND LegalStatusNo IN (58)      			         							THEN 8300 -- Kanton
WHEN NogaAbteilung2008 = '85' AND LegalStatusNo IN (56)     			         							THEN 8100 -- Bund
-- Pflegeheime / Sonstige Heime und Sozialwesen
WHEN (NogaGruppe2008 = '871' OR NogaCode2008 BETWEEN '879000' AND '889999' OR NogaKlasse2008 IN ('9101','9499')) AND LegalStatusNo IN (48,60) 	THEN 8400 -- Gemeinden
WHEN (NogaGruppe2008 = '871' OR NogaCode2008 BETWEEN '879000' AND '889999' OR NogaKlasse2008 IN ('9101','9499')) AND LegalStatusNo IN (58)	THEN 8300 -- Kanton
WHEN (NogaGruppe2008 = '871' OR NogaCode2008 BETWEEN '879000' AND '889999' OR NogaKlasse2008 IN ('9101','9499')) AND LegalStatusNo IN (56)	THEN 8100 -- Bund
WHEN (NogaGruppe2008 = '871' OR NogaCode2008 BETWEEN '879000' AND '889999' OR NogaKlasse2008 IN ('9101','9499')) AND LegalStatusNo NOT IN (46,50) 	THEN 9000 -- Öffentliche nichtfinanzielle Unt.+Betriebe

WHEN NogaKlasse2008 = '9491' AND LegalStatusNo IN (48, 56, 58, 60)                           								THEN 8600 -- Staatskirchen
WHEN (NogaKlasse2008 = '9499' AND LegalStatusNo NOT IN (46,50)) OR NogaAbteilung2008 IN ('90','91','92','93','95','96')             			THEN 6000 -- sonstige Dienstleistungen

-- (Sozialversicherungen)
--******************************************************************************************************************************
WHEN NogaGruppe2008 = '843'									 				THEN 8500 -- Sozialversicherungen

-- (Private Haushalte)
--******************************************************************************************************************************
WHEN (NogaAbteilung2008 BETWEEN '97' AND '98' AND TKBNSectorCode IS NULL)		 						THEN 1000


-- (Private Organisationen ohne Erwerbszweck)
--******************************************************************************************************************************
WHEN NogaCode2008 BETWEEN '942' AND '949299'											THEN 2000
WHEN (NogaGruppe2008 = '871' OR NogaCode2008 BETWEEN '879000' AND '889999' OR NogaKlasse2008 IN ('9101','9499')) AND LegalStatusNo IN (46,50)	THEN 2000

-- (ohne NogaCode aber mit Telekurs Branchencode)
--******************************************************************************************************************************
WHEN TKBNSectorCode = '1'													THEN 8100 -- Bund, Zentralregierungen
WHEN TKBNSectorCode = '11'													THEN 9003 -- örk Gemeinnützig
WHEN TKBNSectorCode = '15'													THEN 7000 -- Internationale Organisationen
WHEN TKBNSectorCode = '19'													THEN 4500 -- Anlagefonds und Vorsorgestiftung
WHEN TKBNSectorCode = '2'													THEN 8300 -- Kantone
WHEN TKBNSectorCode IN 
             ('21','22','23','26','29','31','33','34','35','37','41','42','43','44','45','46','47','48','50','52','57','61','64','66','68','70','71','72','73','75','76','79','89','91','92','94','95','96')	THEN 3000 -- Private nichtfinanzielle Untern.
WHEN TKBNSectorCode = '3'													THEN 8400 -- Gemeinden 
WHEN TKBNSectorCode = '81'													THEN 5200 -- Banken
WHEN TKBNSectorCode = '82' AND FiscalDomicileCountry = 'CH'										THEN 5140 -- Pfandbriefinstitute
WHEN TKBNSectorCode = '82'													THEN 5200 -- Banken
WHEN TKBNSectorCode = '84'													THEN 5250 -- Finanzgesellschaften
WHEN TKBNSectorCode = '86'													THEN 4200 -- Versicherungen
WHEN TKBNSectorCode = '88'													THEN 8500 -- Gesundheitswesen
ELSE 0
END AS CodeC510, 
CASE 
WHEN Pt.PartnerNo = 900000 THEN NULL
WHEN Pt.ArCode IS NULL OR Pt.ArCode = 'XXXXXX' THEN CONVERT(varchar(12),ISNULL(LargeExpGroupNo,PartnerNo))
ELSE Pt.ArCode END AS LargeExpGroupNo,
HdPendingChanges, HdPendingSubChanges, HdEditStamp, HdCreator, HdChangeUser, HdProcessId, HdStatusFlag, ArCode, ISNULL(LargeExpGroupNo,PartnerNo) AS MainPartnerNo,
C510_Override,
C026_Deri,
C026_Repo,
C026_DF,
RelationshipMonths,
LongTermLoan,
AmountOfProducts
FROM AcFrozenPartner AS Pt

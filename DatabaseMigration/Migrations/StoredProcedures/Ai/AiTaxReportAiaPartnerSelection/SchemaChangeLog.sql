--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaPartnerSelection context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaPartnerSelection,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaPartnerSelection
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaPartnerSelection

@Creator varchar(20), 
@TaxReportId uniqueidentifier,
@TaxProgramNo int,
@ReportYear int,
@StatusValidFrom date,
@StatusValidTo date

As 

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

-- The part with Partner Selection for the reportable partners:

IF OBJECT_ID('tempdb..##PartnerHolder') IS NOT NULL DROP TABLE ##PartnerHolder
IF OBJECT_ID('tempdb..##PartnerMHolder') IS NOT NULL DROP TABLE ##PartnerMHolder
IF OBJECT_ID('tempdb..##AccountToReport') IS NOT NULL DROP TABLE ##AccountToReport
IF OBJECT_ID('tempdb..##PortfolioToReport') IS NOT NULL DROP TABLE ##PortfolioToReport
IF OBJECT_ID('tempdb..##PartnerAccPortToReport') IS NOT NULL DROP TABLE ##PartnerAccPortToReport

CREATE TABLE ##PartnerHolder
(
	BaseId		uniqueidentifier	NOT NULL,
	CustomerType	CHAR(3)			    NOT NULL
);

CREATE TABLE ##PartnerMHolder
(
	BaseIdHolder		uniqueidentifier	NOT NULL,
	BaseIdHolderM	uniqueidentifier	NOT NULL,
	CustomerType		CHAR(3)			    NOT NULL,
	CPType			smallint
);

CREATE TABLE ##AccountToReport
(
	AccountId		uniqueidentifier	NOT NULL,
	BaseId			uniqueidentifier	NOT NULL,
	BaseIdType		CHAR(3)			    NOT NULL,
	CPType			smallint
);

CREATE TABLE ##PortfolioToReport
(
	AccountId		uniqueidentifier	NOT NULL,
	BaseId			uniqueidentifier	NOT NULL,
	BaseIdType		CHAR(3)			    NOT NULL,
	CPType			smallint
);
CREATE TABLE ##PartnerAccPortToReport
(
	APType			CHAR(3)			    NOT NULL,
	AccountPortId	uniqueidentifier	NOT NULL,
	AccountPortNo 	BIGINT				NOT NULL,
	PartnerNo 		BIGINT				NOT NULL,
	PartnerAddress	NVARCHAR(50)		NOT NULL,
	PartnerType		CHAR(3)				NOT NULL,
	AIACountry		CHAR(2)				NOT NULL,
	Doc956Inhaber	CHAR(20),
	Doc956ReportPartner	CHAR(20),
	CPType			smallint,
	CustomerType	CHAR(3)			    NOT NULL
);

-- --------------------------------------------------------------------------------------------------
-- Case 1.1
-- --------------------------------------------------------------------------------------------------
-- Kontoinhaber ist eine natürliche Person, die eine meldepflichtige Person ist
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT
	ba.Id,
	'I'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (101, 190) -- nat. Person, meldepflichtig / nat. Person offenes Indiz	
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))	
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 1.2
-- --------------------------------------------------------------------------------------------------
-- Abweichender WiBe zu Case 1.1
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'1.2'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (100, 101, 190) -- nat. Person, meldepflichtig / nat. Person offenes Indiz
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen WiBe
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'WI',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '1.2'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 190, 206, 209)	-- Nat. Pers und Jur. Pers.																
	AND rm.RelationTypeNo = 20					-- Gemeinschaft
	AND rs.RelationRoleNo = 17					-- WiBe
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 2.1
-- --------------------------------------------------------------------------------------------------
-- Kontoinhaber ist eine natürliche Person, die eine meldepflichtige Person ist und als
-- nachrichtenlos gilt
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT
	ba.Id,
	'I'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (140) -- Narilo nat. Pers.

	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))	

	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 2.2
-- --------------------------------------------------------------------------------------------------
-- Abweichender WiBe zu Case 2.1 - nachrichtenloser Partner
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'2.2'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (140) -- nur nat. Person Narilo
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen WiBe
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'WI',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '2.2'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (140)	-- Nur nat. Pers. Narilo (siehe Doku)															
	AND rm.RelationTypeNo = 20					-- Gemeinschaft
	AND rs.RelationRoleNo = 17					-- WiBe
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 3.1
-- --------------------------------------------------------------------------------------------------
-- Kontoinhaber ist eine natürliche Person, die als "nicht dokumentiert" gilt
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT
	ba.Id,
	'I'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (150) -- nicht dokumentiert

	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))	

	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 3.2
-- --------------------------------------------------------------------------------------------------
-- Abweichender WiBe zu Case 3.1 - nicht dokumentierter Partner
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'3.2'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (150) -- nur nat. Person Narilo
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen WiBe
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'WI',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '3.2'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (150)	-- Nur nat. Pers. nicht dokumentiert (siehe Doku)															
	AND rm.RelationTypeNo = 20					-- Gemeinschaft
	AND rs.RelationRoleNo = 17					-- WiBe
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 4.1:
-- --------------------------------------------------------------------------------------------------
-- Doppelpartner, einfache Gesellschaften, Einzelfirmen mit meldepflichtigen Personen
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'4.1'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo		
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen Mitinhaber
INSERT INTO ##PartnerMHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'M',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '4.1'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 140, 150, 190, 206, 209)	-- Meldepflichtige Person / offenes Indiz nat. Person
	AND rm.RelationTypeNo = 10		 -- Gemeinschaft
	AND rs.RelationRoleNo IN (6, 63) -- Mitinhaber, Inhaber Einzelfirma
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------
	
-- --------------------------------------------------------------------------------------------------
-- Case 4.2
-- --------------------------------------------------------------------------------------------------
-- Erbengemeinschaften
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'4.2'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (106)	-- AIA-rel. CompteJoin-Partner	
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen Mitinhaber
INSERT INTO ##PartnerMHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'E',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '4.2'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 140, 150, 190, 206, 209)	-- Meldepflichtige Person
	AND rm.RelationTypeNo = 10	-- Gemeinschaft
	AND rs.RelationRoleNo = 18	-- Erben
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 4.3
-- --------------------------------------------------------------------------------------------------
-- Abweichender WiBe zu Case 4.1 - Doppelpartner, einfache Gesellschaften etc.
-- --------------------------------------------------------------------------------------------------

-- Selektieren aller betroffenen WiBe
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseIdHolder,
	rs.PartnerId,													
	'WI',
	0
	FROM ##PartnerMHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseIdHolder
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = 'M'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 140, 150, 190, 206, 209)	-- Meldepflichtige															
	AND rm.RelationTypeNo = 20					-- Gemeinschaft
	AND rs.RelationRoleNo = 17					-- WiBe
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------


-- --------------------------------------------------------------------------------------------------
-- Case 5.1:
-- --------------------------------------------------------------------------------------------------
-- Meldepflichtiger NFE (206)
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT
	ba.Id,
	'I'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo = 206		-- aktive NFE, meldepflichtig	
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))	
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 5.2:
-- --------------------------------------------------------------------------------------------------
-- Meldepflichtiger NFE mit anderem WiBe
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'5.2'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (206) -- aktive NFE
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen WiBe
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'WI',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '5.2'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 190, 206, 209)	-- Meldepflichtiger Wibe															
	AND rm.RelationTypeNo = 20					-- Gemeinschaft
	AND rs.RelationRoleNo = 17					-- WiBe
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 6:
-- --------------------------------------------------------------------------------------------------
-- Passiver (209)
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT
	ba.Id,
	'IP' -- Changed from 'I' to 'IP'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo = 209	-- Passiver NFE, meldepflichtig	
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))	
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 6.1:
-- --------------------------------------------------------------------------------------------------
-- Passiver mit meldepflichtigen beherrschenden Personen
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'6.1'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (209) -- aktive NFE
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen behrrschenden Personen
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'CP',

	CASE
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '080' THEN 1
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '117' THEN 1
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '084' THEN 2
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '082' THEN 3
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110054' THEN 4
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110053' THEN 5
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110056' THEN 6
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110055' THEN 7
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '1100' THEN 8
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19954' THEN 9
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19953' THEN 10
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19956' THEN 11
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19955' THEN 12
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '199' THEN 13
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '189' THEN 13
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '089' THEN 13	
		ELSE 99
	END 
	
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	JOIN PtProfile p ON p.PartnerId = ph.BaseId
	WHERE
	ph.CustomerType = '6.1'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 190, 140, 150)	-- Meldepflichtige - nur nat. Personen (siehe Doku)															
	AND rm.RelationTypeNo IN (70, 20, 60)		-- Kontrollinhaber, WiBe, FATCA-AIA
	AND rs.RelationRoleNo IN (80, 82, 84, 17, 89, 99, 100)	-- Diverse Rollen
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 6.2:
-- --------------------------------------------------------------------------------------------------
-- Passiver meldepflichtig, ohne meldepflichtigen beherrschenden Personen
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'IX'
	FROM AiTaxStatus ts					

	JOIN PtRelationMaster rm ON rm.PartnerId = ts.PartnerId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id			
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id			
	JOIN PtBase ba ON ba.Id = rs.PartnerId
			
	JOIN AiTaxStatus tsR ON tsR.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail adR ON ad.TaxStatusId = tsR.Id
	JOIN AiTaxAIAStatus atsR ON atsR.StatusNo = adR.AIAStatusNo			
						
	WHERE
	ad.AIAStatusNo IN (209) -- aktive NFE
	AND ts.TaxProgramNo = @TaxProgramNo																
	AND tsR.TaxProgramNo = @TaxProgramNo		
	AND atsR.PartnerTypeNo IS NULL
	AND rm.RelationTypeNo IN (70, 20, 60)		-- Kontrollinhaber, WiBe, FATCA-AIA
	AND rs.RelationRoleNo IN (80, 82, 84, 17, 89, 99, 100)	-- Diverse Rollen
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND (tsR.ValidFrom < @StatusValidFrom AND (tsR.ValidTo IS NULL OR tsR.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND tsR.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 7:
-- 7.1 - Part Inhaber
-- --------------------------------------------------------------------------------------------------
-- Passiver, nicht meldepflichtig (208)
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'IP'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId

	JOIN PtRelationMaster rm ON rm.PartnerId = ba.Id
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id

	JOIN AiTaxStatus tsCP ON tsCP.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail adCP ON adCP.TaxStatusId = tsCP.Id

	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND tsCP.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (208) -- NFE nicht meldepflichtig
	AND rm.RelationTypeNo IN (70, 20, 60)								-- Kontrollinhaber, FATCA-AIA
	AND rs.RelationRoleNo IN (80, 82, 84, 17, 89, 99, 100)				-- Diverse Rollen

	AND adCP.AIAStatusNo IN (101, 190, 140, 150) -- Meldepflichtig

	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND (tsCP.ValidFrom < @StatusValidFrom AND (tsCP.ValidTo IS NULL OR tsCP.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND tsCP.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 7:
-- 7.2 - Part Controlling Person
-- --------------------------------------------------------------------------------------------------
-- Passiver, nicht meldepflichtig (208)
-- --------------------------------------------------------------------------------------------------

-- Selektieren aller betroffenen behrrschenden Personen
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'CP',
		
	CASE
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '080' THEN 1
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '117' THEN 1
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '084' THEN 2
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '082' THEN 3
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110054' THEN 4
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110053' THEN 5
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110056' THEN 6
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '110055' THEN 7
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '1100' THEN 8
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19954' THEN 9
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19953' THEN 10
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19956' THEN 11
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) + CAST(rs.CloseRelTypeNo AS varchar) = '19955' THEN 12
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '199' THEN 13
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '189' THEN 13
		WHEN CAST(p.OffshoreStatusNo AS varchar) + CAST(rs.RelationRoleNo AS varchar) = '089' THEN 13
		ELSE 99
	END 

	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	JOIN PtProfile p ON p.PartnerId = ph.BaseId
	WHERE
	ph.CustomerType = 'IP'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 190, 140, 150)	-- Meldepflichtige - nur nat. Personen (siehe Doku)															
	AND rm.RelationTypeNo IN (70, 20, 60)		-- Kontrollinhaber, WiBe, FATCA-AIA
	AND rs.RelationRoleNo IN (80, 82, 84, 17, 89, 99, 100)	-- Diverse Rollen
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 8:
-- --------------------------------------------------------------------------------------------------
-- Nicht meldepflichtige Person, mit meldepflichtigem WiBe
-- --------------------------------------------------------------------------------------------------

INSERT INTO ##PartnerHolder
SELECT DISTINCT		-- Mehrere Stati möglich, brauchen hier aber den Partner nur 1x
	ba.Id,
	'8'
	FROM AiTaxStatus ts
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN PtBase ba ON ba.Id = ts.PartnerId
	WHERE
	ts.TaxProgramNo = @TaxProgramNo	
	AND ad.AIAStatusNo IN (100, 102, 105, 199, 205, 207, 210, 299) -- Nicht meldepflichtige Person
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- Selektieren aller betroffenen behrrschenden Personen
INSERT INTO ##PartnerMHolder
SELECT DISTINCT			-- Mehrere Stati möglich, brauchen hier aber den Partner (Kombination) nur 1x,
	ph.BaseId,
	rs.PartnerId,													
	'W',
	0
	FROM ##PartnerHolder ph
	JOIN PtRelationMaster rm ON rm.PartnerId = ph.BaseId
	JOIN PtRelationSlave rs ON rs.MasterId = rm.Id
	JOIN AiTaxStatus ts ON ts.PartnerId = rs.PartnerId
	JOIN AiTaxAIADetail ad ON ad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ats ON ats.StatusNo = ad.AIAStatusNo
	JOIN PtBase ba ON ba.Id = rs.PartnerId
	WHERE
	ph.CustomerType = '8'
	AND ts.TaxProgramNo = @TaxProgramNo
	AND ad.AIAStatusNo IN (101, 140, 150, 190, 206, 209)	-- Meldepflichtige WiBe														
	AND rm.RelationTypeNo IN (20)	-- WiBe
	AND rs.RelationRoleNo IN (17)	-- WiBe
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	AND rm.HdVersionNo BETWEEN 1 AND 999999998
	AND rs.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ad.HdVersionNo BETWEEN 1 AND 999999998
	AND ba.HdVersionNo BETWEEN 1 AND 999999998	

-- END-----------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------------------------
-- Case 9:
-- --------------------------------------------------------------------------------------------------
-- Status 200, 201, 202, 203 -> FI = keine Meldung.
-- --------------------------------------------------------------------------------------------------

-- //

-- END-----------------------------------------------------------------------------------------------


-- Konto/Portfolio-Meldeliste erstellen:

DECLARE @BlockReasonId AS UniqueIdentifier = (SELECT Value FROM AsParameter WHERE Name = 'BlockReason' AND ParamGroupId = '3082DCC8-9D99-47A6-A62F-5E42A3AF086E')

-- Inhaber: Accounts (not Portfolios)
INSERT INTO ##AccountToReport
SELECT
	acc.Id,
	ph.BaseId,
	ph.CustomerType,
	0	
	FROM ##PartnerHolder ph
	JOIN PtBase b ON b.Id = ph.BaseId
	JOIN PtPortfolio p ON p.PartnerId = ph.BaseId
	JOIN PtAccountBase acc ON acc.PortfolioId = p.Id
	JOIN PrReference ref ON ref.AccountId = acc.Id
	JOIN PrPrivate pp ON pp.ProductId = ref.ProductId
	WHERE 
	ph.CustomerType IN ('I', 'IP', 'IX')
	AND (acc.TerminationDate IS NULL OR YEAR(acc.TerminationDate) >= @ReportYear)
	AND (acc.OpeningDate IS NULL OR YEAR(acc.OpeningDate) <= @ReportYear)
	AND pp.IsAiaRelevant = 1
	AND p.HdVersionNo BETWEEN 1 AND 999999998
	AND b.HdVersionNo BETWEEN 1 AND 999999998	
	--AND acc.HdVersionNo BETWEEN 1 AND 999999998	
                AND acc.Id not in (SELECT ParentId FROM PtBlocking WHERE ParentTableName = 'PtAccountBase' and BlockReason = @BlockReasonId and ReleaseDate is null)
	ORDER BY acc.AccountNo

-- Inhaber: Portfolios (not Accounts)
INSERT INTO ##PortfolioToReport
SELECT
	p.Id,
	ph.BaseId,
	ph.CustomerType,
	0
	FROM ##PartnerHolder ph
	JOIN PtBase b ON b.Id = ph.BaseId
	JOIN PtPortfolio p ON p.PartnerId = ph.BaseId							
	join PtPortfolioType pt on p.PortfolioTypeNo = pt.PortfolioTypeNo		
	WHERE
	ph.CustomerType IN ('I', 'IP', 'IX')
	AND pt.IsAiaRelevant = 1						-- Nur IsAiaRelevant Portfolios (SKL 31.05.2018)
	AND (p.TerminationDate IS NULL OR YEAR(p.TerminationDate) >= @ReportYear)	
	AND (p.OpeningDate IS NULL OR YEAR(p.OpeningDate) <= @ReportYear)	
	--AND p.HdVersionNo BETWEEN 1 AND 999999998
	AND b.HdVersionNo BETWEEN 1 AND 999999998	
                AND p.Id not in (SELECT ParentId FROM PtBlocking WHERE ParentTableName = 'PtPortfolio' and BlockReason = @BlockReasonId and ReleaseDate is null)
	ORDER BY p.PortfolioNo
-- /

-- Mitinhaber: Accounts (not Portfolios)
INSERT INTO ##AccountToReport
SELECT
	acc.Id,
	bm.Id,
	amh.CustomerType,
	ISNULL(amh.CPType, 0)
	FROM ##PartnerMHolder amh
	JOIN PtPortfolio p ON p.PartnerId = amh.BaseIdHolder
	JOIN PtBase bm ON bm.Id = amh.BaseIdHolderM
	JOIN PtAccountBase acc ON acc.PortfolioId = p.Id
	JOIN PrReference ref ON ref.AccountId = acc.Id
	JOIN PrPrivate pp ON pp.ProductId = ref.ProductId
	WHERE 
	(acc.TerminationDate IS NULL OR YEAR(acc.TerminationDate) >= @ReportYear)
	AND (acc.OpeningDate IS NULL OR YEAR(acc.OpeningDate) <= @ReportYear)
	AND p.HdVersionNo BETWEEN 1 AND 999999998
	AND pp.IsAiaRelevant = 1
	AND bm.HdVersionNo BETWEEN 1 AND 999999998	
	--AND acc.HdVersionNo BETWEEN 1 AND 999999998	
                AND acc.Id not in (SELECT ParentId FROM PtBlocking WHERE ParentTableName = 'PtAccountBase' and BlockReason = @BlockReasonId and ReleaseDate is null)
	ORDER BY acc.AccountNo

-- Mitinhaber: Portfolios (not Accounts)
INSERT INTO ##PortfolioToReport
SELECT
	p.Id,
	bm.Id,
	amh.CustomerType,
	ISNULL(amh.CPType, 0)
	FROM ##PartnerMHolder amh
	JOIN PtPortfolio p ON p.PartnerId = amh.BaseIdHolder
                JOIN PtPortfolioType pt on p.PortfolioTypeNo = pt.PortfolioTypeNo	
	JOIN PtBase bi ON bi.Id = amh.BaseIdHolder
	JOIN PtBase bm ON bm.Id = amh.BaseIdHolderM	
	WHERE 
            	pt.IsAiaRelevant = 1 -- Just IsAiaRelevant Portfolios like in Inhaber Portfolio a few lines above! (TSH 22.10.2024)
	AND (p.TerminationDate IS NULL OR YEAR(p.TerminationDate) >= @ReportYear)
	AND (p.OpeningDate IS NULL OR YEAR(p.OpeningDate) <= @ReportYear)
                --AND p.PortfolioTypeNo > 5000		      -- Nur WS-Portfolios (TSH 22.10.2024 not longer necessary)
	--AND p.HdVersionNo BETWEEN 1 AND 999999998
	AND bi.HdVersionNo BETWEEN 1 AND 999999998	
	AND bm.HdVersionNo BETWEEN 1 AND 999999998	
                AND p.Id not in (SELECT ParentId FROM PtBlocking WHERE ParentTableName = 'PtPortfolio' and BlockReason = @BlockReasonId and ReleaseDate is null)
	ORDER BY p.PortfolioNo

-- -----------------------------------------------------------------------------------------

-- Test-Report
insert into ##PartnerAccPortToReport
SELECT
	'A'					AS APType,
	acc.Id				AS AccountPortId,
	acc.AccountNo		AS AccountPortNo,
	b.PartnerNo			AS PartnerNo,
	adr.ReportAdrLine	AS PartnerAddress,
	atr.BaseIdType		AS PartnerType,
	ts.CountryCode		AS AIACountry,
	docsi.StatusNo		AS Doc956Inhaber,
	docs.StatusNo		AS Doc956ReportPartner,
	atr.CPType			AS CPType,
	atr.BaseIdType		AS CustomerType
	FROM ##AccountToReport atr
	JOIN PtBase b ON b.Id = atr.BaseId
	JOIN PtAccountBase acc ON acc.Id = atr.AccountId
	JOIN PtAddress adr ON adr.PartnerId = atr.BaseId
	JOIN AiTaxStatus ts ON ts.PartnerId = b.Id
	JOIN AiTaxAIADetail tad ON tad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ais On ais.StatusNo = tad.AIAStatusNo

	OUTER APPLY
	(
		SELECT txt.TextShort AS StatusNo
		FROM AsDocument doc
		JOIN AsCorrItem corr ON corr.Id = doc.Type
		JOIN AsDocumentData dd ON dd.DocumentId = doc.Id
		JOIN AsDocumentStatus ds ON ds.StatusNo = dd.StatusNo
		JOIN AsText txt ON txt.MasterId = ds.Id
		WHERE
		doc.PartnerId = b.Id
		AND corr.ItemNo = 956
		AND txt.LanguageNo = 2
	) docs

	OUTER APPLY
	(
		SELECT txt.TextShort AS StatusNo
		FROM AsDocument doc
		JOIN AsCorrItem corr ON corr.Id = doc.Type
		JOIN AsDocumentData dd ON dd.DocumentId = doc.Id
		JOIN AsDocumentStatus ds ON ds.StatusNo = dd.StatusNo
		JOIN AsText txt ON txt.MasterId = ds.Id
		JOIN PtAccountBase acc ON acc.Id = atr.AccountId
		JOIN PtPortfolio port ON port.Id = acc.PortfolioId
		WHERE
		doc.PartnerId = port.PartnerId
		AND corr.ItemNo = 956
		AND txt.LanguageNo = 2
	) docsi

	WHERE
	adr.AddressTypeNo = 11
	AND adr.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.TaxProgramNo = 1
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
	--AND ais.PartnerTypeNo IS NOT NULL	
UNION
SELECT
	'P'					AS APType,
	p.Id				AS AccountPortId,
	p.PortfolioNo		AS AccountPortNo,
	b.PartnerNo			AS PartnerNo,
	adr.ReportAdrLine	AS PartnerAddress,
	ptr.BaseIdType		AS PartnerType,
	ts.CountryCode		AS AIACountry,
	docsi.StatusNo		AS Doc956Inhaber,
	docs.StatusNo		AS Doc956ReportPartner,
	ptr.CPType			AS CPType,
	ptr.BaseIdType		AS CustomerType
	FROM ##PortfolioToReport ptr
	JOIN PtBase b ON b.Id = ptr.BaseId
	JOIN PtPortfolio p ON p.Id = ptr.AccountId
	JOIN PtAddress adr ON adr.PartnerId = ptr.BaseId
	JOIN AiTaxStatus ts ON ts.PartnerId = b.Id
	JOIN AiTaxAIADetail tad ON tad.TaxStatusId = ts.Id
	JOIN AiTaxAIAStatus ais On ais.StatusNo = tad.AIAStatusNo

	OUTER APPLY
	(
		SELECT txt.TextShort AS StatusNo
		FROM AsDocument doc
		JOIN AsCorrItem corr ON corr.Id = doc.Type
		JOIN AsDocumentData dd ON dd.DocumentId = doc.Id
		JOIN AsDocumentStatus ds ON ds.StatusNo = dd.StatusNo
		JOIN AsText txt ON txt.MasterId = ds.Id
		WHERE
		doc.PartnerId = b.Id
		AND corr.ItemNo = 956
		AND txt.LanguageNo = 2
	) docs

	OUTER APPLY
	(
		SELECT txt.TextShort AS StatusNo
		FROM AsDocument doc
		JOIN AsCorrItem corr ON corr.Id = doc.Type
		JOIN AsDocumentData dd ON dd.DocumentId = doc.Id
		JOIN AsDocumentStatus ds ON ds.StatusNo = dd.StatusNo
		JOIN AsText txt ON txt.MasterId = ds.Id		
		JOIN PtPortfolio port ON port.Id = ptr.AccountId
		WHERE
		doc.PartnerId = port.PartnerId
		AND corr.ItemNo = 956
		AND txt.LanguageNo = 2
	) docsi

	WHERE
	adr.AddressTypeNo = 11
	AND adr.HdVersionNo BETWEEN 1 AND 999999998
	AND ts.HdVersionNo BETWEEN 1 AND 999999998	
	AND ts.TaxProgramNo = 1	
	AND (ts.ValidFrom < @StatusValidFrom AND (ts.ValidTo IS NULL OR ts.ValidTo > @StatusValidTo))
-- Partner Selection Query


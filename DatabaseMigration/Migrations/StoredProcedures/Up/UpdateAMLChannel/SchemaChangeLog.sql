--liquibase formatted sql

--changeset system:create-alter-procedure-UpdateAMLChannel context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdateAMLChannel,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdateAMLChannel
CREATE OR ALTER PROCEDURE dbo.UpdateAMLChannel
AS

;WITH A AS
(
    SELECT
        CASE
            WHEN ptBase.DateOfBirth > DATEADD(year, -18, CONVERT(date, GETDATE()))
                THEN CAST(0 AS bit)         -- under 18
            ELSE CAST(1 AS bit)             -- 18+ or NULL DOB
        END AS IsOver18,
        PtProfile.MoneyLaunderSuspect AS Gmer, 
        COALESCE(CO.CustomerTypeNoManualOverride, CO.CustomerTypeNoCalculated) AS CustomerTypeNo,
        COALESCE(CO.TemplateNoManualOverride, CO.TemplateNoCalculated)        AS TemplateNo,
        CORD.SpecialConsultantChannelNo,
        CORD.hasVSBPendingBlocking,
        CASE WHEN CORD.hasDigitalBanking = 1
              AND CORD.DBLastLoginDate > DATEADD(DAY, -180, GETDATE())
             THEN 1 ELSE 0 END AS ChannelDigitalBanking,
        CASE WHEN CORD.BaaSChannelNo IS NOT NULL
             THEN CORD.BaaSChannelNo ELSE NULL END AS ChannelBaaS,
        CORD.isIdentificationNeeded,
        0 AS IsAndRelationship,
        CO.Id AS OverviewId,
        CO.OverallCheckTypeNo
    FROM PtMlPeriodicCheckOverview CO
    LEFT JOIN PtMLCheckOverviewRelData CORD
        ON CORD.PeriodicCheckOverviewId = CO.Id
    INNER JOIN PtProfile
        ON PtProfile.PartnerId = CO.PartnerId
    INNER JOIN PtBase
        ON PtBase.Id = CO.PartnerId
    WHERE CO.HdVersionNo BETWEEN 1 AND 999999998
)
UPDATE CO
SET ChannelNoCalculated =
 CASE
	WHEN A.TemplateNo = 91
	THEN 60
	WHEN A.OverallCheckTypeNo = 30
	THEN 60
	WHEN((A.Gmer = 1 OR A.Gmer = 2) AND A.CustomerTypeNo NOT IN (-1, 50, 91) AND A.TemplateNo NOT IN (11, 16, 22, 31, 41, 45, 47, 61, 72, 73, 74, 75, 77, 78, 81))
	THEN 10 --KANAL Kundenberater
	WHEN(CustomerTypeNo IN (-1, 50) OR TemplateNo = 50) 
	THEN 50
	WHEN A.CustomerTypeNo IN (-1, 91) 
	THEN 60 --KANAL outOfScope
	WHEN(A.CustomerTypeNo IN (10, 30, 31, 32) AND A.ChannelDigitalBanking = 1 AND A.ChannelBaaS IS NULL AND A.CustomerTypeNo NOT IN (-1, 91) AND A.hasVSBPendingBlocking = 0 AND (A.SpecialConsultantChannelNo IS NULL OR A.SpecialConsultantChannelNo = 0) AND A.TemplateNo NOT IN (11, 16, 22, 31, 41, 45, 47, 61, 72, 73, 74, 75, 77, 78, 81))
	THEN 20 --KANAL EBanking
	WHEN(A.CustomerTypeNo IN (10, 30, 31, 32) AND A.ChannelBaaS IS NOT NULL AND A.hasVSBPendingBlocking = 0 AND (A.SpecialConsultantChannelNo IS NULL OR A.SpecialConsultantChannelNo = 0) AND A.TemplateNo NOT IN (11, 16, 22, 31, 41, 45, 47, 61, 72, 73, 74, 75, 77, 78, 81))
	THEN A.ChannelBaaS --Kanal gemäss BaaS Einstellung, normalerweise = 30 (Fintech)
	WHEN(A.IsAndRelationship = 1 AND A.TemplateNo NOT IN (11, 16, 22, 31, 41, 45, 47, 61, 72, 73, 74, 75, 77, 78, 81)  AND A.CustomerTypeNo NOT IN (-1, 91) )
	THEN 10 --KANAL Kundenberater
	WHEN A.TemplateNo = 15
	THEN 10 --KANAL Kundenberater
	WHEN(A.TemplateNo IN (11, 16, 22, 31, 41, 45, 47, 61, 72, 73, 74, 75, 77, 78, 81)  AND A.CustomerTypeNo NOT IN (-1, 91) )
	THEN 40 --KANAL Korrespondenz
	WHEN(A.CustomerTypeNo IN (10, 30, 31, 32) AND A.ChannelDigitalBanking = 0 AND A.ChannelBaaS IS NULL AND A.CustomerTypeNo NOT IN (-1, 91) AND A.hasVSBPendingBlocking = 0 AND (A.SpecialConsultantChannelNo IS NULL OR A.SpecialConsultantChannelNo = 0))
	THEN 40 --KANAL Korrespondenz
	WHEN((A.SpecialConsultantChannelNo IS NOT NULL OR A.SpecialConsultantChannelNo = 1)  AND A.CustomerTypeNo NOT IN (-1, 91) )
	THEN 10 --KANAL gemäss Einstellungen SpecialConsultantChannelNo (normalerweise 10 = Kundenberater, muss aber nicht)
	WHEN((A.Gmer = 1 OR A.Gmer = 2) AND A.CustomerTypeNo NOT IN (-1, 50, 91))
	THEN 10 --KANAL Kundenberater
	ELSE 10
END
FROM PtMlPeriodicCheckOverview CO
JOIN A ON A.OverviewId = CO.Id;


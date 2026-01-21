--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportTkSectorCode context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportTkSectorCode,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportTkSectorCode
CREATE OR ALTER PROCEDURE dbo.GetReportTkSectorCode
@PartnerId UniqueIdentifier

AS

SELECT  STR.SectorCode, PBSA.Amount 
FROM      PtBaseStructure PBS 
                JOIN  PtBaseStructureAssign PBSA ON PBSA.StructureId = PBS.Id AND PBSA.HdVersionNo < 999999999 
                JOIN  PtSector STR ON PBSA.ForeignKeyId = STR.Id 
WHERE   PBS.TableName = 'PtSector'
AND         STR.SectorSchemeCode = 'TKBN' 
AND         PBS.MasterId =  @PartnerId 
ORDER BY PBSA.Amount DESC


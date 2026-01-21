--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportNoga2008 context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportNoga2008,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportNoga2008
CREATE OR ALTER PROCEDURE dbo.GetReportNoga2008
@strNogaCode varchar(6)

AS

SELECT       NogaAbteilung, NogaGruppe, NogaKlasse, NogaCode, SnbWeBeKolCH, SnbWeBeKolAusland
FROM          PtNoga2008
WHERE       NogaCode = @strNogaCode 


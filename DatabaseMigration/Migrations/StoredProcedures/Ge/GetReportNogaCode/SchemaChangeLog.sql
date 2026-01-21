--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportNogaCode context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportNogaCode,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportNogaCode
CREATE OR ALTER PROCEDURE dbo.GetReportNogaCode
@strBusinessTypeCode varchar(6)

AS

SELECT       NogaAbteilung, NogaGruppe, NogaKlasse, NogaCode, SnbWeBeKolCH, SnbWeBeKolAusland
FROM          PtBusinessType 
WHERE       NogaCode = @strBusinessTypeCode 



--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_GetRM context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_GetRM,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_GetRM
CREATE OR ALTER PROCEDURE dbo.DataExport_GetRM
    @ConsultantTeamName varchar(32),
    @LanguageNo int As
Declare @Referenz nvarchar(20)
Declare @Name nvarchar(50)
Declare @Vorname nvarchar(50)
Declare @TextShort nvarChar(50)
Declare @SpacePos int

SELECT @Referenz = g.Description, @TextShort = t.TextShort 
FROM AsUserGroup g
   LEFT OUTER JOIN AsText t on t.MasterId = g.id and t.LanguageNo = @LanguageNo
WHERE g.UserGroupName = @ConsultantTeamName
   AND g.IsStandardConsTeam = 1
   AND g.HdVersionNo BETWEEN 1 AND 999999998

SET @SpacePos = CharIndex(' ',@TextShort)
IF @SpacePos > 0 
BEGIN
    SET @Vorname = Left(@TextShort, @SpacePos - 1)
    SET @Name = Substring(@TextShort, @SpacePos + 1, Len(@TextShort) - @SpacePos)
END
ELSE
BEGIN
    SET @Vorname = ''
    SET @Name = ISNULL(@TextShort,'')
END

SELECT @Referenz As Referenz, @Name As Name,  @Vorname As Vorname




--liquibase formatted sql

--changeset system:create-alter-procedure-AsTemplate_GetTemplateInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-AsTemplate_GetTemplateInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsTemplate_GetTemplateInfo
CREATE OR ALTER PROCEDURE dbo.AsTemplate_GetTemplateInfo
	@RecordId UNIQUEIDENTIFIER,
	@EditStamp UNIQUEIDENTIFIER AS

DECLARE @DbEditStamp UNIQUEIDENTIFIER

SELECT Top 1 @RecordId = Id, @DbEditStamp = HdEditStamp  
FROM AsTemplate 
WHERE Id = @RecordId AND Disabled = 0 
               AND (HdVersionNo BETWEEN 1 AND 999999998)
               AND Date <= GETDATE()

IF @DbEditStamp <> @EditStamp
    SELECT * FROM AsTemplate 
    WHERE Id = @RecordId AND Disabled = 0 
    AND (HdVersionNo BETWEEN 1 AND 999999998)
    AND Date <= GETDATE()
ELSE
    SELECT @DbEditStamp As HdEditStamp

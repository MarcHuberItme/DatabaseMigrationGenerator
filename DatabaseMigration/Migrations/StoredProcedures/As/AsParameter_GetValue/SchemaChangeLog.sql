--liquibase formatted sql

--changeset system:create-alter-procedure-AsParameter_GetValue context:any labels:c-any,o-stored-procedure,ot-schema,on-AsParameter_GetValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsParameter_GetValue
CREATE OR ALTER PROCEDURE dbo.AsParameter_GetValue
    @GroupName VarChar(30), 
    @ParameterName VarChar(30),
    @ParamValue nVarChar(50) OUTPUT  AS
DECLARE @GroupId uniqueidentifier

SELECT @GroupId = ID FROM AsParameterGroup 
    WHERE GroupName = @GroupName
        AND (HdVersionNo BETWEEN 1 AND 999999998)
IF @GroupId IS NOT NULL 
    SELECT @ParamValue = Value FROM AsParameter 
        WHERE Name = @ParameterName
            AND ParamGroupId = @GroupId
            AND (HdVersionNo BETWEEN 1 AND 999999998)

IF @ParamValue IS NULL
    SET @ParamValue = ''

RETURN

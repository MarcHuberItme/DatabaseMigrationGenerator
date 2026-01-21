--liquibase formatted sql

--changeset system:create-alter-procedure-GetConfirmationMapName context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConfirmationMapName,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConfirmationMapName
CREATE OR ALTER PROCEDURE dbo.GetConfirmationMapName
    @TableName VarChar(30),
    @WorkflowMap VarChar(32) OUTPUT  AS
SELECT @WorkflowMap = WorkflowMap FROM AsConfirmationMap
    WHERE TableName = @TableName 
        AND (HdVersionNo BETWEEN 1 AND 999999998)
IF @WorkflowMap IS NULL 
     SET @WorkflowMap = ''

RETURN

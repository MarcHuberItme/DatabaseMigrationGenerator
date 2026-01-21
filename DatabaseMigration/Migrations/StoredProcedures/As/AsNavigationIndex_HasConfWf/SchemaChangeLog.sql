--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_HasConfWf context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_HasConfWf,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_HasConfWf
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_HasConfWf
    @RootTableId uniqueidentifier AS
DECLARE @HasConfWorkflow As Bit
IF (SELECT COUNT(*) FROM AsNavigationIndex 
        WHERE RootTableId = @RootTableId
            AND Status < 5) > 0
    SET @HasConfWorkflow = 1
ELSE
    SET @HasConfWorkflow = 0
SELECT @HasConfWorkflow AS HasConfWorkflow

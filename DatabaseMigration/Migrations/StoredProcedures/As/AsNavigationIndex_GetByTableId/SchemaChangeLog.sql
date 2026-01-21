--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_GetByTableId context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_GetByTableId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_GetByTableId
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_GetByTableId
    @CurrentTableId uniqueidentifier
AS
    SELECT * FROM AsNavigationIndex 
    WHERE TableId = @CurrentTableId


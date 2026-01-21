--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_GetByIndexId context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_GetByIndexId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_GetByIndexId
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_GetByIndexId
@CurrentIndexId uniqueidentifier
AS
    SELECT * FROM AsNavigationIndex 
    WHERE Id = @CurrentIndexId

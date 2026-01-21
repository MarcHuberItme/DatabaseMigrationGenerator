--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_GetIndex context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_GetIndex,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_GetIndex
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_GetIndex
@CurrentIndexId uniqueidentifier
AS
    SELECT * FROM AsNavigationIndex 
    WHERE TableId = @CurrentIndexId

--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_GetByRoot context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_GetByRoot,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_GetByRoot
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_GetByRoot
@RootId uniqueidentifier
AS
    SELECT * FROM AsNavigationIndex 
    WHERE RootTableId = @RootId 
   

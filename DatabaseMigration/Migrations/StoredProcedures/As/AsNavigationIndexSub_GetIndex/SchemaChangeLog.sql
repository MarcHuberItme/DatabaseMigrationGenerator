--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndexSub_GetIndex context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndexSub_GetIndex,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndexSub_GetIndex
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndexSub_GetIndex
@CurrentSubId uniqueidentifier
AS
    SELECT * FROM AsNavigationIndexSub
    WHERE Id = @CurrentSubId

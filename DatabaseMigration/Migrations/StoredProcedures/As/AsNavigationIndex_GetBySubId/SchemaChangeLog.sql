--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_GetBySubId context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_GetBySubId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_GetBySubId
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_GetBySubId
@CurrentSubId uniqueidentifier
AS
    SELECT I.* FROM AsNavigationIndex I
        JOIN AsNavigationIndexSub S ON I.Id = S.NavigationIndexId
    WHERE S.Id = @CurrentSubId

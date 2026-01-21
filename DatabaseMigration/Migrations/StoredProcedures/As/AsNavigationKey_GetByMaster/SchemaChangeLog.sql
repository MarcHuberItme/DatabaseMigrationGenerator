--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationKey_GetByMaster context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationKey_GetByMaster,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationKey_GetByMaster
CREATE OR ALTER PROCEDURE dbo.AsNavigationKey_GetByMaster
@MasterId  UNIQUEIDENTIFIER
AS
SELECT K.Id, 
       K.NavigationStructureRowId, 
       K.FormName, 
       K.FunctionList, 
       K.ApplicationKey, 
       K.Type, 
       K.ParentConditionKey 
    FROM AsNavigationStructureKey As K 
        JOIN AsNavigationStructure AS N ON K.NavigationStructureRowId = N.Id 
    WHERE N.NavigationStructureId = @MasterId

--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationIndex_GetByParent context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationIndex_GetByParent,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationIndex_GetByParent
CREATE OR ALTER PROCEDURE dbo.AsNavigationIndex_GetByParent
@ParentId uniqueidentifier,
@TableName varchar(30)
AS
    SELECT * FROM AsNavigationIndex 
    WHERE ParentTableId = @ParentId
        AND TableName = @TableName


--liquibase formatted sql

--changeset system:create-alter-procedure-GetNodeConfStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-GetNodeConfStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetNodeConfStatus
CREATE OR ALTER PROCEDURE dbo.GetNodeConfStatus
@NavigationIndexId Uniqueidentifier,
@ExcludeSubId Uniqueidentifier,
@MinStatus Tinyint Output AS

SET @MinStatus = (Select Min(ConfStatus) FROM AsNavigationIndexSub 
    WHERE NavigationIndexId = @NavigationIndexId
       AND Id <> @ExcludeSubId)
If @MinStatus Is Null 
    SET @MinStatus = 0

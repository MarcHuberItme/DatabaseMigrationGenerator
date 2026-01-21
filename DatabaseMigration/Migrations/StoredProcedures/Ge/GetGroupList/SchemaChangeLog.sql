--liquibase formatted sql

--changeset system:create-alter-procedure-GetGroupList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetGroupList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetGroupList
CREATE OR ALTER PROCEDURE dbo.GetGroupList
    @GroupTypeId UniqueIdentifier,
    @TargetRowId UniqueIdentifier

AS 
    SELECT GroupId from AsGroupMember
           WHERE GroupTypeId = @GroupTypeId
             AND TargetRowId = @TargetRowId



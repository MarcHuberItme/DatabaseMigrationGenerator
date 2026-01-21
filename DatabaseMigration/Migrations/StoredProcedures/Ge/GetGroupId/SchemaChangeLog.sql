--liquibase formatted sql

--changeset system:create-alter-procedure-GetGroupId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetGroupId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetGroupId
CREATE OR ALTER PROCEDURE dbo.GetGroupId
    @GroupTypeId UniqueIdentifier,
    @TargetRowId UniqueIdentifier,
    @GroupId UniqueIdentifier OUTPUT

AS 

SET @GroupId = (SELECT GroupId from AsGroupMember
                             WHERE GroupTypeId = @GroupTypeId
                             AND TargetRowId = @TargetRowId)

IF @GroupId IS NULL
     BEGIN
     SET @GroupId = (SELECT Id from AsGroup
                                  WHERE GroupTypeId = @GroupTypeId
                                  AND IsDefault = 1)
    END

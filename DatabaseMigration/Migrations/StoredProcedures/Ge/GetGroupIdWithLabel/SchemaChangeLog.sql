--liquibase formatted sql

--changeset system:create-alter-procedure-GetGroupIdWithLabel context:any labels:c-any,o-stored-procedure,ot-schema,on-GetGroupIdWithLabel,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetGroupIdWithLabel
CREATE OR ALTER PROCEDURE dbo.GetGroupIdWithLabel
    @GroupTypeLabel NVarChar(32),
    @TargetRowId UniqueIdentifier,
    @GroupId UniqueIdentifier OUTPUT

AS 

SET @GroupId = (SELECT GroupId from AsGroupMember
                             JOIN AsGroupTypeLabel ON AsGroupTypeLabel.GroupTypeId = AsGroupMember.GroupTypeId
                             WHERE AsGroupTypeLabel.Name = @GroupTypeLabel
                             AND TargetRowId = @TargetRowId)

IF @GroupId IS NULL
     BEGIN
     SET @GroupId = (SELECT AsGroup.Id from AsGroup
                                  JOIN AsGroupTypeLabel ON AsGroupTypeLabel.GroupTypeId = AsGroup.GroupTypeId
                                  WHERE AsGroupTypeLabel.Name = @GroupTypeLabel
                                  AND IsDefault = 1)
    END



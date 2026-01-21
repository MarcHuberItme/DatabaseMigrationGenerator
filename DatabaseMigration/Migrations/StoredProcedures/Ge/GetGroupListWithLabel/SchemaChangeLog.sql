--liquibase formatted sql

--changeset system:create-alter-procedure-GetGroupListWithLabel context:any labels:c-any,o-stored-procedure,ot-schema,on-GetGroupListWithLabel,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetGroupListWithLabel
CREATE OR ALTER PROCEDURE dbo.GetGroupListWithLabel
    @GroupTypeLabel NVarChar(32),
    @TargetRowId UniqueIdentifier

AS 
    SELECT GroupId from AsGroupMember
           JOIN  AsGroupTypeLabel ON AsGroupTypeLabel.GroupTypeId = AsGroupMember.GroupTypeId
           WHERE AsGroupTypeLabel.Name = @GroupTypeLabel
           AND TargetRowId = @TargetRowId



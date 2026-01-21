--liquibase formatted sql

--changeset system:create-alter-procedure-IsInGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-IsInGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsInGroup
CREATE OR ALTER PROCEDURE dbo.IsInGroup
    @TargetRowId UniqueIdentifier,
    @GroupId UniqueIdentifier,
    @Result TINYINT OUTPUT

AS 

SET @Result = 0

DECLARE @GroupTypeId UniqueIdentifier
SELECT @GroupTypeId = GroupTypeId
    FROM AsGroup
    WHERE Id = @GroupId

IF  (SELECT IsDefault FROM AsGroup
       WHERE Id = @GroupId) = 1
    BEGIN
    IF NOT EXISTS (SELECT * from AsGroupMember
          WHERE GroupTypeId = @GroupTypeId
            AND TargetRowId = @TargetRowId)
        BEGIN
        set @Result = 1
        END    
    END

ELSE
    IF EXISTS (SELECT * from AsGroupMember
          WHERE TargetRowId = @TargetRowId
            AND GroupId     = @GroupId)
        BEGIN
        set @Result = 1
        END

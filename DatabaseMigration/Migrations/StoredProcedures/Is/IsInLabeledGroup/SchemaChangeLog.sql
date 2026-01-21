--liquibase formatted sql

--changeset system:create-alter-procedure-IsInLabeledGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-IsInLabeledGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsInLabeledGroup
CREATE OR ALTER PROCEDURE dbo.IsInLabeledGroup
    @TargetRowId UniqueIdentifier,
    @GroupLabel NVarChar(32),
    @Result TINYINT OUTPUT
AS 

SET @Result = 0

DECLARE @GroupTypeId UniqueIdentifier
DECLARE @GroupId UniqueIdentifier
DECLARE @IsDefault Tinyint

SELECT @GroupTypeId = AsGroup.GroupTypeId,
	      @GroupId = AsGroup.Id,
	      @IsDefault  = AsGroup.IsDefault
    FROM AsGroup JOIN
              AsGroupLabel ON AsGroupLabel.GroupId = AsGroup.Id
    WHERE AsGroupLabel.Name = @GroupLabel

IF  @IsDefault = 1
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

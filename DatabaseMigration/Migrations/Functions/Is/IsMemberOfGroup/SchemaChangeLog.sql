--liquibase formatted sql

--changeset system:create-alter-function-IsMemberOfGroup context:any labels:c-any,o-function,ot-schema,on-IsMemberOfGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function IsMemberOfGroup
CREATE OR ALTER FUNCTION dbo.IsMemberOfGroup
(@TargetRowId UniqueIdentifier, @GroupId UniqueIdentifier) RETURNS    Bit

BEGIN
	DECLARE @Result as Bit
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
	
	RETURN @Result

End

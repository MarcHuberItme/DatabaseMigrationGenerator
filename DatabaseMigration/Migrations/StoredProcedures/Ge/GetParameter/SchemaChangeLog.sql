--liquibase formatted sql

--changeset system:create-alter-procedure-GetParameter context:any labels:c-any,o-stored-procedure,ot-schema,on-GetParameter,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetParameter
CREATE OR ALTER PROCEDURE dbo.GetParameter
@ParameterName varchar(40),
@ParamGroupName varchar(40),
@ParameterValue varchar(500) OUTPUT

AS
-- Declare and initialize a variable to hold @@ERROR.
DECLARE @ErrorCode INT
SET @ErrorCode = 0

Select @ParameterValue=P.Value
From AsParameter P Join AsParameterGroup G On P.ParamGroupID=G.ID
Where P.HdVersionNo<999999999 And G.HdVersionNo<999999999
	And G.GroupName=@ParamGroupName
	And P.Name=@ParameterName

-- Save any nonzero @@ERROR value.
IF (@@ERROR <> 0)
   SET @ErrorCode = @@ERROR

-- Returns 0 if neither SELECT statement had
-- an error; otherwise, returns the last error.
RETURN @ErrorCode

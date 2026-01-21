--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_LimitsAccepted context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_LimitsAccepted,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_LimitsAccepted
CREATE OR ALTER PROCEDURE dbo.GetBalance_LimitsAccepted
@PositionId  uniqueidentifier,    
@LimitsAccepted money OUTPUT    
AS  
  
DECLARE @AccountId uniqueidentifier  
  
SELECT @AccountId=AccountId 
from PtPositionView 
Where id = @PositionId  
  
if NOT(@AccountId is NULL)  
begin
    Select @LimitsAccepted = ISNULL(sum(Value),0)  
    from PtAccountCompValuesValidView 
    where accountbaseid = @AccountId
end


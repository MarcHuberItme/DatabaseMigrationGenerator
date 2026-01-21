--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountClsPeriodExecuted context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountClsPeriodExecuted,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountClsPeriodExecuted
CREATE OR ALTER PROCEDURE dbo.GetAccountClsPeriodExecuted
@PositionId UniqueIdentifier,  
@ClosingPeriodType as smallint
 
AS

Declare @MaxPeriodNo AS int  
Declare @MaxClosingRepeatCounter AS int  
  
--Get Max PeriodNo  
SELECT @MaxPeriodNo = IsNull(MAX(PeriodNo),0)  
from   
 PtAccountClosingPeriod   
WHERE  
 PeriodType = @ClosingPeriodType and  
 PositionId = @PositionId and
 ExecutedDate is not null
  
SELECT @MaxClosingRepeatCounter = IsNull(MAX(ClosingRepeatCounter) ,0)  
from   
 PtAccountClosingPeriod   
WHERE   
 PeriodType = @ClosingPeriodType and  
 PositionId = @PositionId and  
 PeriodNo = @MaxPeriodNo and
 ExecutedDate is not null
  
SELECT * from PtAccountClosingPeriod  
Where  
 PeriodType = @ClosingPeriodType and  
 PositionId = @PositionId and  
 PeriodNo = @MaxPeriodNo and  
 ClosingRepeatCounter = @MaxClosingRepeatCounter


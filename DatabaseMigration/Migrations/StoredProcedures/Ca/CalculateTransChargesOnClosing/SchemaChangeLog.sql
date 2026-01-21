--liquibase formatted sql

--changeset system:create-alter-procedure-CalculateTransChargesOnClosing context:any labels:c-any,o-stored-procedure,ot-schema,on-CalculateTransChargesOnClosing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CalculateTransChargesOnClosing
CREATE OR ALTER PROCEDURE dbo.CalculateTransChargesOnClosing
@PositionId uniqueidentifier,    
@TransDateBegin datetime,    
@TransDateEnd datetime,    
@intMode as int    
As
If(@intMode=1)    
 -- Calculation Mode    
	Select PtTransChargeType.ChargeNo,  IsNull(sum(IsNull(PtTransMessageCharge.Amount,0)),0) as ChargeAmount 
	from PtTransMessageCharge    
	Inner Join PtTransChargeType On PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id    
	
	Where PtTransMessageCharge.ImmediateCharge = 0 and PtTransMessageCharge.Positionid = @PositionId 
	/* and TransItemId is null*/
	 and PtTransMessageCharge.TransDate > @TransDateBegin    
	 and PtTransMessageCharge.TransDate <= @TransDateEnd  
	 and PtTransMessageCharge.HdVersionNo Between 1 and 999999998  
	 Group by PtTransChargeType.ChargeNo
else    
	 -- Execute Mode   
	 -- This is used when charges are levied upon customer.   
	 Select PtTransChargeType.AccountParameterName, PtTransChargeType.IsGrouped,  
	 IsNull(sum(PtTransMessageCharge.Amount),0) As ChargeAmount  
	 from PtTransMessageCharge    
	 Inner Join PtTransChargeType On PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id    
	 where PtTransMessageCharge.ImmediateCharge = 0 and PtTransMessageCharge.Positionid = @PositionId   
	/* and PtTransMessageCharge.TransItemId is null  */  
	 and PtTransMessageCharge.TransDate > @TransDateBegin    
	 and PtTransMessageCharge.TransDate <= @TransDateEnd    
	 and PtTransMessageCharge.HdVersionNo Between 1 and 999999998  
	 group by PtTransChargeType.AccountParameterName, PtTransChargeType.IsGrouped  

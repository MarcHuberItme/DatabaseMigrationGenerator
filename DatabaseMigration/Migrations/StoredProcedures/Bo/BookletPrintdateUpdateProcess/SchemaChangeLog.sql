--liquibase formatted sql

--changeset system:create-alter-procedure-BookletPrintdateUpdateProcess context:any labels:c-any,o-stored-procedure,ot-schema,on-BookletPrintdateUpdateProcess,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure BookletPrintdateUpdateProcess
CREATE OR ALTER PROCEDURE dbo.BookletPrintdateUpdateProcess
/*Author : Abdul Nasir Khan*/  
@InitialLoad smallint = 0,  -- 0=Normal Process, 1=FirstTime Loading  
@VerboseOn smallint = 0  -- 0=normal, 1=display selects      
AS    
declare @AccountNo as decimal(11,0)
declare @AccountNoText as varchar(13)
declare @LastBookletPrintDate as datetime
declare @PositionId as uniqueidentifier

declare AccountListing CURSOR For
	Select Mgbookletprintdate.AccountNo, PtPosition.id, Mgbookletprintdate.LastBookletPrintDate , AccountNoText
	From PtPosition 
	Inner Join PrReference On PtPosition.ProdReferenceId = PrReference.Id    
	Inner Join PtAccountBase On PrReference.AccountId = PtAccountBase.Id    
	Inner Join MgbookletPrintdate on MgbookletPrintdate.AccountNo = PtAccountBase.AccountNo
	where mgbookletprintdate.UpdateDate is Null

declare @cErr int       
declare @cRow int       
declare @statusCnt integer  -- Total no of records      

if @VerboseOn > 0 select getdate() '00: Started'      
if @VerboseOn = 0 set nocount on       

OPEN AccountListing
FETCH NEXT FROM AccountListing INTO @AccountNo,@PositionId,@LastBookletPrintDate,@AccountNoText

While (@@FETCH_STATUS = 0)
BEGIN
		 
BEGIN TRANSACTION
	if(@InitialLoad = 1)  
	begin  		 
		/*Step 0 : Update PtTransItem's booklet printdate = NULL for future transaction*/    
		Update PtTransitem set PtTransitem.bookletprintdate = NULL
		from PtTransitem
		Where PtTransitem.PositionId = @PositionId and PtTransitem.TransDate > @LastBookletPrintDate
                                and PtTransitem.HdVersionNo between 1 and 999999998

		/*Error Handling*/    
		select @cErr = @@ERROR , @cRow = @@rowcount IF @cErr <> 0 begin ROLLBACK TRANSACTION RAISERROR( '10: Update PtTransitem failed.' , 16 , -1 ) RETURN @cErr end 
		
		/*Verbose Mode - Debug Trace*/    
		if @VerboseOn > 0 select @cRow '10: Update PtTransitem done '  
	end  
	
	/*Step 1 : Update PtTransItem's booklet printdate*/    
	Update PtTransitem set PtTransitem.bookletprintdate = @LastBookletPrintDate
	from  PtTransitem
	Where PtTransitem.TransDate <= @LastBookletPrintDate
	and PtTransitem.PositionId = @PositionId    
	and PtTransitem.bookletprintdate is null  
                and PtTransitem.HdVersionNo between 1 and 999999998
	
	/*Step 1 : Error Handling*/    
	select @cErr = @@ERROR , @cRow = @@rowcount IF @cErr <> 0 begin ROLLBACK TRANSACTION RAISERROR( '20: Update PtTransitem failed.' , 16 , -1 ) RETURN @cErr end    
	
	
	/*Step 1 : Verbose Mode - Debug Trace*/    
	if @VerboseOn > 0 select @cRow '10: Update PtTransitem done '    
	
	
	/*Step 2 : Update PtPosition's booklet printdate*/    
	Update PtPosition set PtPosition.Bookletprintdate = @LastBookletPrintDate
	from  PtPosition
	Where IsNull(PtPosition.Bookletprintdate,'19000101') < @LastBookletPrintDate    
	and   PtPosition.Id = @PositionId
	
	/*Step 2 : Error Handling*/      
	Select @cErr = @@ERROR , @cRow = @@rowcount IF @cErr <> 0 begin ROLLBACK TRANSACTION RAISERROR( '30: Update PtPosition failed.', 16 , -1 ) RETURN @cErr end    
	
	/*Step 2 : Verbose Mode - Debug Trace*/    
	if @VerboseOn > 0 select @cRow '10: Update PtPosition done '         
	
	
	/*Step 3 : Now Set the booklet printdate*/    
	Update mgbookletprintdate set mgbookletprintdate.UpdateDate = getdate()    
	where mgbookletprintdate.UpdateDate is Null   
	and AccountNo =  @AccountNo
	
	/*Step 3 : Error Handling*/    
	Select @cErr = @@ERROR , @cRow = @@rowcount IF @cErr <> 0 begin ROLLBACK TRANSACTION RAISERROR( '40: Update MgBookletprintdate failed' , 16 , -1 ) RETURN @cErr end    
	
	/*Step 3 : Verbose Mode - Debug Trace*/    
	if @VerboseOn > 0 select @cRow '50: Update MgBookletprintdate done', getdate()        
	
	FETCH NEXT FROM AccountListing INTO @AccountNo,@PositionId,@LastBookletPrintDate,@AccountNoText
COMMIT TRANSACTION
END

close AccountListing
deallocate AccountListing





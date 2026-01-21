--liquibase formatted sql

--changeset system:create-alter-procedure-GroupTransItems context:any labels:c-any,o-stored-procedure,ot-schema,on-GroupTransItems,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GroupTransItems
CREATE OR ALTER PROCEDURE dbo.GroupTransItems
@TransDate DateTime,
    @ValueDate DateTime,
    @PositionId uniqueidentifier,
    @GroupKey varchar(30)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @MasterBookingId uniqueidentifier
	DECLARE @MasterBookingEditStamp uniqueidentifier
	DECLARE @MasterBookingDetailCounter int
	DECLARE @RecordCount int
	DECLARE @BookingCount int
	
	DECLARE @SumDebitQuantity money
	DECLARE @SumCreditQuantity money
	DECLARE @SumDebitAmount money
	DECLARE @SumCreditAmount money
	
	DECLARE @NewDebitQuantity money
	DECLARE @NewCreditQuantity money
	DECLARE @NewDebitAmount money
	DECLARE @NewCreditAmount money
	
	DECLARE @NewTransText nvarchar(150)
	
	DECLARE @ProductToCheck varchar(20)
	DECLARE @Errormessage varchar(1000)
	DECLARE @ErrorSeverity int
	DECLARE @TransMesaageId uniqueidentifier
	

	BEGIN TRY

		-- Build a temporary table with the affected bookings
		SELECT *,
		LTRIM(RTRIM(
		   CASE WHEN CHARINDEX(CHAR(13),TransText) > 0 THEN LEFT(TransText,CHARINDEX(CHAR(13),TransText)-1) 
                                           ELSE TransText END
			)) AS TransTextFirstLine 
		INTO #bookings 
		FROM PtTransItem   
		WHERE TransDate = @TransDate
			AND ValueDate = @ValueDate
			AND PositionId = @PositionId
			AND GroupKey = @GroupKey 
			AND DetailCounter >= 1	
                                                AND HdVersionNo between 1 and 999999998		
	
		-- If no booking found for grouping then something went worng, maybe process started twice	
		IF @@Rowcount <= 1 
            RAISERROR('No booking found for grouping,something went worng. Maybe process started twice',16,1)
		
    
		-- Determin the booking which remains in PtTransItem
		SELECT TOP 1 @MasterBookingId = Id, 
					 @MasterBookingEditStamp = HdEditStamp, 
					 @MasterBookingDetailCounter = DetailCounter 
		FROM #bookings 
		ORDER BY DetailCounter desc, HdCreateDate asc, SourceKey asc
    


		-- Analyze the remaining items
		SELECT @RecordCount = count(*), 
			   @BookingCount = sum(DetailCounter), 
			   @SumDebitQuantity = sum(DebitQuantity),
			   @SumCreditQuantity = sum(CreditQuantity),
			   @SumDebitAmount = sum(DebitAmount),
			   @SumCreditAmount = sum(CreditAmount)
		FROM #bookings
	
		-- Check if all non-master bookings have a DetailCounter of 1. Otherwise someting was wrong with then previous groupings
		IF @RecordCount - 1 + @MasterBookingDetailCounter <> @BookingCount
		    RAISERROR('More than one booking of the group has a DetailCounter > 1',16,1)
		
		SET @NewDebitQuantity = @SumDebitQuantity
		SET @NewCreditQuantity = @SumCreditQuantity

	    IF @SumDebitQuantity <> 0 AND @SumCreditQuantity <> 0
		BEGIN
			IF @SumDebitQuantity > @SumCreditQuantity 
			BEGIN
				SET @NewDebitQuantity = @SumDebitQuantity - @SumCreditQuantity
				SET @NewCreditQuantity = 0
			END
			ELSE
			BEGIN
				SET @NewDebitQuantity = 0
				SET @NewCreditQuantity = @SumCreditQuantity - @SumDebitQuantity
			END
		END
		
			  
        SET @NewDebitAmount = @SumDebitAmount
		SET @NewCreditAmount = @SumCreditAmount

	    IF @SumDebitAmount <> 0 AND @SumCreditAmount <> 0
		BEGIN
			IF @SumDebitAmount > @SumCreditAmount 
			BEGIN
				SET @NewDebitAmount = @SumDebitAmount - @SumCreditAmount
				SET @NewCreditAmount = 0
			END
			ELSE
			BEGIN
				SET @NewDebitAmount = 0
				SET @NewCreditAmount = @SumCreditAmount - @SumDebitAmount
			END
		END

	   

		-- Check if MessageText can be merged
		SELECT distinct @NewTransText = Transtext from #bookings 
		IF @@RowCount > 1 
		BEGIN
		   SELECT distinct @NewTransText = TransTextFirstLine from #bookings 
		   IF @@RowCount > 1 
		   BEGIN
			  
			   SELECT distinct @TransMesaageId = MessageId from #bookings 
			   IF @@RowCount >  1 
			   BEGIN
					SET @NewTransText = null
			   END

		   END 
		   
		END
		
		IF @NewTransText IN ('Herr','Frau','Herr und Frau','Familie','Firma')
		    SET @NewTransText = null
	
		-- Check equality of specfic cost valuation fields
		SELECT DISTINCT TradeDate, RateAcCuPfCu, RateSourceAcCuPfCu, CounterParty, MainTransText, IsDueRelevant from #bookings
		IF @@RowCount > 1
		BEGIN
			-- If there are differences, get the product of the position 
			SET @ProductToCheck = CAST((SELECT pri.ProductNo 
										FROM PtPosition pos 
										   JOIN PrReference ref on ref.Id = pos.ProdReferenceId
										   JOIN PrPrivate pri on pri.ProductId  = ref.productId
										WHERE pos.Id = @PositionId
										) As varchar(10))

	   
			-- See if this product is defined as an acceptable exeption
			SELECT * from AsParameterGroup gr
				JOIN AsParameter par on gr.Id = par.ParamGroupId
			WHERE gr.Groupname = 'BatchProcessBehaviour' 
				AND par.name = 'IgnoreCvReorgError'
				AND gr.HdVersionNo < 999999999
				AND par.HdVersionNo < 999999999
				AND CHARINDEX(LTRIM(RTRIM(@ProductToCheck)), par.Value) > 0
			IF @@Rowcount = 0
			    -- Not defined as allowed exception, cancel grouping
				RAISERROR('Differences in special Fields, which is not allowed for  product %s' ,16,1,@ProductToCheck)
  
		END
    
    
		-- Everything ok, start the modification 
	
	    BEGIN TRAN    
        INSERT INTO PtTransItemDetail (Id,
                                       HdVersionNo,
                                       HdCreator,
                                       HdChangeUser,
                                       TransItemId,
                                       TransactionId,
                                       MessageId,
                                       TransMsgStatusNo,
                                       RealDate,
                                       DebitQuantity,
                                       DebitAmount,
                                       CreditQuantity, 
                                       CreditAmount,
                                       SourceCvAmountTypeNo,
                                       TextNo,
                                       ServiceCenterNo,
                                       Project,
                                       PeriodFrom,
                                       PeriodTo,
                                       BudgetValue,
                                       VatCode,
                                       TransText,
                                       CompletionDate,
                                       IsClosingItem,
                                       TransItemCreationTime,
                                       CardNo,
                                       ClearingNo,
                                       SourceKey,
                                       SourcePositionId,
                                       AmountCvAcCu,
                                       SourceAmountCvAcCu,
                                       CvAmountTypeNo,
                                       CvBookStatusNo,
                                       SourceCvBookStatusNo,
                                       SourcePosIsCvRelevant)
                                           
                                       
    
        SELECT ID,
               1,
               HdCreator,
               HdChangeUser,
               @MasterBookingId,
               TransId,
               MessageId,
               TransMsgStatusNo,
               RealDate,
               DebitQuantity,
               DebitAmount,
               CreditQuantity,
               CreditAmount,
               SourceCvAmountTypeNo,
               TextNo,
               ServiceCenterNo,
               Project,
               PeriodFrom,
               PeriodTo,
               BudgetValue,
               VatCode,
               TransText,
               '99991231',
               IsClosingItem,
               HdCreateDate,
               CardNo,
               ClearingNo,
               SourceKey,
               SourcePositionId,
               AmountCvAcCu,
               SourceAmountCvAcCu,
               CvAmountTypeNo,
               CvBookStatusNo,
               SourceCvBookStatusNo,
               SourcePosIsCvRelevant
               
        FROM #bookings
        WHERE DetailCounter = 1
        
        
        UPDATE PtTransItem SET 
              DetailCounter = @BookingCount,
              TransId = null,
              CardNo = null,
              ClearingNo = null,
              SourcePositionId = null,
              Transtext = @NewTransText,
              DebitQuantity = @NewDebitQuantity,
              CreditQuantity = @NewCreditQuantity,
              DebitAmount = @NewDebitAmount,
              CreditAmount = @NewCreditAmount,
              CompletionDate = '99991231',
              HdVersionNo = HdVersionNo + 1,
              HdChangeDate = GetDate(),
              HdChangeUser = original_login(),
              HdEditStamp = NewId()
        WHERE Id = @MasterBookingId
            AND HdEditStamp = @MasterBookingEditStamp
            
        IF @@RowCount = 0 
            RAISERROR ('CollectorTransItem was altered',  16, 1)
            
        UPDATE PtTransItem SET
              HdVersionNo = 999999999,
              IsInactive = 1,
              DebitQuantity = 0,
              CreditQuantity = 0,
              DebitAmount = 0,
              CreditAmount = 0,
              SourceAmountCvAcCu = 0,
              AmountCvAcCu = 0,
              HdEditStamp = NewId()
        FROM PtTransItem ti
            JOIN #bookings on ti.Id = #bookings.Id and ti.HdEditStamp = #bookings.HdEditStamp
        WHERE #bookings.Id <> @MasterBookingId   
        
        IF @@RowCount <> @RecordCount - 1 
            RAISERROR ('TransItem to mark as deleted was altered',  16, 1)      
              
	    COMMIT

		IF OBJECT_ID('tempdb..#bookings') IS NOT NULL     
            DROP TABLE #bookings       
	END TRY
	

	BEGIN CATCH
	    SET @ErrorMessage = ERROR_MESSAGE()
	    SET @ErrorSeverity = ERROR_SEVERITY()
		
	    IF @@TRANCOUNT > 0
	        ROLLBACK

        IF OBJECT_ID('tempdb..#bookings') IS NOT NULL     
            DROP TABLE #bookings       
   
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1) 
	END CATCH 

END

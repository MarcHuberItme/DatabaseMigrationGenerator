--liquibase formatted sql

--changeset system:create-alter-function-PtDerivTransQty context:any labels:c-any,o-function,ot-schema,on-PtDerivTransQty,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function PtDerivTransQty
CREATE OR ALTER FUNCTION dbo.PtDerivTransQty
(
@TransTypeNo INT,
@TransMsgStatusNo INT,
@Quantity Money
)
RETURNS MONEY
AS BEGIN
DECLARE @QuantityPos Money;
if @TransTypeNo = 601
    SET @QuantityPos =   
        CASE   
            -- Check for employee  
            WHEN isnull(@TransMsgStatusNo,0) = 0
                THEN @Quantity 
            WHEN @TransMsgStatusNo = 1
			    THEN 0
            WHEN @TransMsgStatusNo = 2
			    THEN 0
            WHEN @TransMsgStatusNo = 3
			    THEN @Quantity
        END;
if @TransTypeNo = 602
    SET @QuantityPos =   
        CASE   
            -- Check for employee  
            WHEN isnull(@TransMsgStatusNo,0) = 0
                THEN - @Quantity 
            WHEN @TransMsgStatusNo = 1
			    THEN 0
            WHEN @TransMsgStatusNo = 2
			    THEN 0
            WHEN @TransMsgStatusNo = 3
			    THEN - @Quantity
        END;
RETURN @QuantityPos
END


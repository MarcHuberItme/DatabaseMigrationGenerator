--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeAccountFormalWithdraw context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeAccountFormalWithdraw,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeAccountFormalWithdraw
CREATE OR ALTER PROCEDURE dbo.FreezeAccountFormalWithdraw
@ReportDate datetime

AS

-- initialization, set everything to maximum Outflow:
UPDATE AcFrozenAccount SET MaxWithdrawAmountHoCu = 10000000000.00 WHERE ReportDate = @ReportDate



DECLARE @PositionId uniqueidentifier
DECLARE @MaxWithdrawAmountHoCu money
DECLARE @NoticeAmountPrCu money


DECLARE GetWithdrawCursor CURSOR  FORWARD_ONLY FOR 

SELECT  fac.PositionId
FROM	AcFrozenAccount fac
	JOIN PrReference RE ON fac.PrReferenceId = RE.Id
	JOIN PrPrivate P ON RE.ProductId = P.ProductId
    JOIN PrPrivateWithdrawRules PWR ON P.ProductNo = PWR.ProductNo 
	   AND PWR.Id =	(SELECT TOP 1 Id FROM PrPrivateWithdrawRules R
		             WHERE R.ProductNo = P.ProductNo
                        AND   R.HdVersionNo < 999999999
		                AND   R.ValidFrom <= @ReportDate
		             ORDER BY R.ValidFrom DESC
                    )
WHERE fac.InitValuePrCu <> 0
    AND fac.FreezeStatus = 5
    AND fac.ReportDate = @ReportDate 

FOR UPDATE OF fac.MaxWithdrawAmountHoCu, fac.NoticeAmountPrCu, fac.FreezeStatus
	
OPEN GetWithdrawCursor

FETCH NEXT FROM GetWithdrawCursor INTO @PositionId

WHILE @@FETCH_STATUS = 0
BEGIN
    EXEC GetWithdrawalAmount  @PositionId = @PositionId, 
                              @SelDate = @ReportDate,
                              @GetRsOutput = 0,
                              @WithdrawAmount = @MaxWithdrawAmountHoCu OUTPUT, 
                              @NoticeAmount = @NoticeAmountPrCu OUTPUT
       
    
    UPDATE AcFrozenAccount Set MaxWithdrawAmountHoCu = @MaxWithdrawAmountHoCu, NoticeAmountPrCu = @NoticeAmountPrCu, FreezeStatus = 6
        WHERE CURRENT OF GetWithdrawCursor
    
    FETCH NEXT FROM GetWithdrawCursor INTO @PositionId
END 

CLOSE GetWithdrawCursor 
DEALLOCATE GetWithdrawCursor

UPDATE AcFrozenAccount Set FreezeStatus = 6 WHERE FreezeStatus = 5 AND ReportDate = @ReportDate

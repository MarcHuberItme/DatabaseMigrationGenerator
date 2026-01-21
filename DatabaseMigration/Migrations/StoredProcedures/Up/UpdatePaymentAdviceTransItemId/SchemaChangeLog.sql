--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePaymentAdviceTransItemId context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePaymentAdviceTransItemId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePaymentAdviceTransItemId
CREATE OR ALTER PROCEDURE dbo.UpdatePaymentAdviceTransItemId

@PaDayId uniqueidentifier

AS

BEGIN TRANSACTION

UPDATE PtPaymentAdvice
SET TransItemId = TI.Id, ProcessStatusNo = 3
FROM PtPaymentAdvice AS PA
INNER JOIN (
	SELECT PA.Id, PaDay.TransDate, TI.GroupKey
	FROM PtPaymentAdvice AS PA
	INNER JOIN PtPrintPaymentAdviceDay AS PaDay ON PA.PrintPaymentAdviceDayId = PaDay.Id
	INNER JOIN PtTransItem AS TI ON PA.PositionId = TI.PositionId AND PA.GroupKey = TI.GroupKey AND PA.ValueDate = TI.ValueDate AND TI.TransDate = PaDay.TransDate AND TI.HdVersionNo between 1 and 999999998
	WHERE PA.PrintPaymentAdviceDayId = @PaDayId AND PA.ProcessStatusNo = 2
	GROUP BY Pa.Id, PaDay.TransDate, TI.GroupKey
	HAVING count(*) = 1 
	) AS PaWithOneTi ON PA.Id = PaWithOneTi.Id
INNER JOIN PtTransItem AS TI ON PA.PositionId = TI.PositionId AND PA.GroupKey = TI.GroupKey AND PA.ValueDate = TI.ValueDate AND TI.TransDate = PaWithOneTi.TransDate AND TI.HdVersionNo between 1 and 999999998
WHERE PA.PrintPaymentAdviceDayId = @PaDayId AND ProcessStatusNo = 2

IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION 
	END
ELSE
	BEGIN 
		COMMIT
	END


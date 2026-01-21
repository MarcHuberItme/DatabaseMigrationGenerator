--liquibase formatted sql

--changeset system:create-alter-procedure-IsTransactionTransformationToReadOptimisedEntryFinished context:any labels:c-any,o-stored-procedure,ot-schema,on-IsTransactionTransformationToReadOptimisedEntryFinished,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsTransactionTransformationToReadOptimisedEntryFinished
CREATE OR ALTER PROCEDURE dbo.IsTransactionTransformationToReadOptimisedEntryFinished
@AccountId uniqueidentifier,
@SelectUnprocessedTransactions bit = 0,
@IsFinished bit output AS
DECLARE @DeletedVersionNo int = 999999999
DECLARE @BUFFER int = 100
DECLARE @UnprocessedTransactionCount INT = 0
SET @accountId = (SELECT TOP(1) PtAccountBase.Id FROM PtAccountBase WHERE Id = @accountId AND HdVersionNo != @deletedVersionNo AND HdVersionNo != 0 )
IF(@accountId IS NULL) 
	THROW 51000,'Account record does not exist.',1;
IF object_id( N'tempdb..#OriginalTransactionsForAccount_Ordered' ) IS NOT NULL 
	BEGIN 
		DROP TABLE #OriginalTransactionsForAccount_Ordered
	END

SELECT TOP (@buffer) Transactions.TransDateTime AS TransDate,
		CASE 
			WHEN TransId IS NULL THEN Det.TransactionId
			ELSE TransId
		END AS TransactionId
INTO 
#OriginalTransactionsForAccount_Ordered  
FROM PtTransItem Transactions
		INNER JOIN 
		PtPosition P
		ON P.Id = Transactions.PositionId
			INNER JOIN 
			PrReference R
			ON R.Id = P.ProdReferenceId
				INNER JOIN 
				PtAccountBase Ab
				ON Ab.Id = R.AccountId
					left OUTER JOIN 
					PtTransItemDetail Det
					ON Det.TransItemId = Transactions.Id
			WHERE Ab.Id = @accountId
                                                      AND Transactions.HdVersionNo between 1 and 999999998
			ORDER BY Transactions.TransDateTime DESC
SET @unprocessedTransactionCount = ( SELECT TOP(@buffer) count(*) FROM #OriginalTransactionsForAccount_Ordered left JOIN RoTransItemDetail ReadOptimizedTransactions ON ReadOptimizedTransactions.TransactionId = #OriginalTransactionsForAccount_Ordered.TransactionId WHERE ReadOptimizedTransactions.Id IS NULL)

IF(@unprocessedTransactionCount = 0) 
	SET @isFinished = 1
ELSE 
	SET @isFinished = 0
SELECT @isFinished AS IsFinished

IF(@selectUnprocessedTransactions = 1) 
	SELECT TOP(@buffer) #OriginalTransactionsForAccount_Ordered.TransactionId AS UnprocessedTransactionId,
		#OriginalTransactionsForAccount_Ordered.TransDate AS TransactionDateTime
	FROM #OriginalTransactionsForAccount_Ordered
			left JOIN 
			RoTransItemDetail ReadOptimizedTransactions
			ON ReadOptimizedTransactions.TransactionId = #OriginalTransactionsForAccount_Ordered.TransactionId
	WHERE ReadOptimizedTransactions.Id IS NULL






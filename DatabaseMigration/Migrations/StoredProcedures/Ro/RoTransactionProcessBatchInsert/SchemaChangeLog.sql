--liquibase formatted sql

--changeset system:create-alter-procedure-RoTransactionProcessBatchInsert context:any labels:c-any,o-stored-procedure,ot-schema,on-RoTransactionProcessBatchInsert,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RoTransactionProcessBatchInsert
CREATE OR ALTER PROCEDURE dbo.RoTransactionProcessBatchInsert
	@TransactionId UNIQUEIDENTIFIER,
	@BatchSize INT
AS
BEGIN
	CREATE TABLE #TempBatches (
		TransMessageId UNIQUEIDENTIFIER,
		BatchNo INT
		);

	CREATE TABLE #InsertedBatches (
		Id UNIQUEIDENTIFIER,
		BatchNo INT
		);

	INSERT INTO #TempBatches (
		TransMessageId,
		BatchNo
		)
	SELECT [PtTransMessage].[Id] AS [TransMessageId],
		CEILING(ROW_NUMBER() OVER (
				ORDER BY [PtTransMessage].[Id]
				) / 10.0) AS BatchNo
	FROM [PtTransaction]
	INNER JOIN [PtTransMessage] ON ([PtTransMessage].[TransactionId] = [PtTransaction].[Id])
	INNER JOIN [PtTransType] ON ([PtTransType].[TransTypeNo] = [PtTransaction].[TransTypeNo])
	WHERE [PtTransaction].[Id] IN (@TransactionId)

	INSERT INTO RoTransactionProcessBatch (
		TransactionId,
		BatchNo,
		STATUS
		)
	OUTPUT INSERTED.Id,
		INSERTED.BatchNo
	INTO #InsertedBatches
	SELECT DISTINCT @TransactionId AS TransactionId,
		BatchNo,
		0
	FROM #TempBatches;

	INSERT INTO RoTransactionProcessBatchDtl (
		TransactionBatchProcessId,
		TransMessageId
		)
	SELECT IB.Id,
		T.TransMessageId
	FROM #TempBatches T
	JOIN #InsertedBatches IB ON T.BatchNo = IB.BatchNo;

	DROP TABLE #TempBatches;

	DROP TABLE #InsertedBatches;
END

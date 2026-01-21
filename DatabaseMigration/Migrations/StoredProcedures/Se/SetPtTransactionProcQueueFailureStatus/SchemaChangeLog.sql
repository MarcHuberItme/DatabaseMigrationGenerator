--liquibase formatted sql

--changeset system:create-alter-procedure-SetPtTransactionProcQueueFailureStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-SetPtTransactionProcQueueFailureStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure SetPtTransactionProcQueueFailureStatus
CREATE OR ALTER PROCEDURE dbo.SetPtTransactionProcQueueFailureStatus

AS

DECLARE @MaxDate datetime

SET @MaxDate = '9999-12-31'

BEGIN TRANSACTION
    BEGIN
        Update PtTransactionProcQueueFailure
            Set Status = 1

            FROM PtTransactionProcQueueFailure
            INNER JOIN PtTransaction
            ON PtTransaction.Id = PtTransactionProcQueueFailure.TransactionId

            WHERE Status <> 1
            AND PtTransaction.ProcessStatus = 1
            AND PtTransaction.UpdateStatus = 1
            AND PtTransaction.CompletionDate >= @MaxDate

            IF @@ERROR <> 0 BEGIN ROLLBACK TRANSACTION END
    END

COMMIT TRANSACTION


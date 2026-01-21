--liquibase formatted sql

--changeset system:create-alter-procedure-UpdateMortgageAdvicePrintStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdateMortgageAdvicePrintStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdateMortgageAdvicePrintStatus
CREATE OR ALTER PROCEDURE dbo.UpdateMortgageAdvicePrintStatus

@AccountNo decimal(11),
@ScheduledDate datetime

AS 


UPDATE PtTransMessage
SET DebitPrintStatus = 1, CreditPrintStatus = 1
WHERE Id IN
(SELECT M.Id FROM PtTransaction AS T
 INNER JOIN PtTransMessage AS M ON T.Id = M.TransactionId
 WHERE CreditMessageType in ('AMORT','TREUHANDAMORT')
 AND TransDate = @ScheduledDate
 AND (M.CreditAccountNo = @AccountNo OR M.DebitAccountNo=@AccountNo))

--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateTransMessageInMCStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateTransMessageInMCStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateTransMessageInMCStatus
CREATE OR ALTER PROCEDURE dbo.PtUpdateTransMessageInMCStatus
@fileImportProcessId uniqueidentifier
AS


UPDATE PtTransMessageInMasterCard SET status = 10, HdChangeDate = getDate()
WHERE FileImportProcessID = @fileImportProcessId
AND id IN
(
	SELECT PtTransMessageInId 
	FROM  PtPaymentMasterCard
	WHERE FileImportProcessID = @fileImportProcessID

)


UPDATE PtTransMessageInMasterCard SET status = 10, HdChangeDate = getDate()
WHERE FileImportProcessID = @fileImportProcessID
AND SUBSTRING(Message, 1, 2) IN ('FH', 'FT')


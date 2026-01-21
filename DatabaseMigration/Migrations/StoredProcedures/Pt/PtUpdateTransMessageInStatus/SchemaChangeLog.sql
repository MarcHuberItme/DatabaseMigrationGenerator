--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateTransMessageInStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateTransMessageInStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateTransMessageInStatus
CREATE OR ALTER PROCEDURE dbo.PtUpdateTransMessageInStatus
@fileImportProcessId uniqueidentifier
AS


UPDATE PtTransMessageIn SET status = 10, HdChangeDate = getDate()
WHERE FileImportProcessID = @fileImportProcessId
AND id IN
(
	SELECT PtTransMessageInId 
	FROM  PtPaymentMasterCard
	WHERE FileImportProcessID = @fileImportProcessID

)


UPDATE PtTransMessageIn SET status = 10, HdChangeDate = getDate()
WHERE FileImportProcessID = @fileImportProcessID
AND SUBSTRING(Message, 1, 2) IN ('FH', 'FT')


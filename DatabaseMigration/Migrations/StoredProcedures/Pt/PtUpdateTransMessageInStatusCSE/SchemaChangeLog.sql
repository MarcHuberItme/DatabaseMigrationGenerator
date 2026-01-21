--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateTransMessageInStatusCSE context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateTransMessageInStatusCSE,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateTransMessageInStatusCSE
CREATE OR ALTER PROCEDURE dbo.PtUpdateTransMessageInStatusCSE
@fileImportProcessId uniqueidentifier
AS


UPDATE PtTransMessageIn SET status = 10, HdChangeDate = getDate()
WHERE FileImportProcessID = @fileImportProcessId
AND id IN
(
	SELECT TransMessageInID 
	FROM  PtPaymentMasterCardCSE
	WHERE FileImportProcessID = @fileImportProcessID

)


UPDATE PtTransMessageIn SET status = 10, HdChangeDate = getDate()
WHERE FileImportProcessID = @fileImportProcessID
AND SUBSTRING(Message, 1, 2) IN ('FH', 'FT')


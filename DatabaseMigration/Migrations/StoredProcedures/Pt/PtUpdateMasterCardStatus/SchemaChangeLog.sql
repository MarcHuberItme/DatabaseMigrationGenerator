--liquibase formatted sql

--changeset system:create-alter-procedure-PtUpdateMasterCardStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-PtUpdateMasterCardStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtUpdateMasterCardStatus
CREATE OR ALTER PROCEDURE dbo.PtUpdateMasterCardStatus
@fileImportProcessId uniqueidentifier
AS 


UPDATE PtPaymentMasterCard 
SET status = 1, HdChangeDate = getDate()
WHERE 
(
	id IN
	(
		SELECT id 
		FROM  PtPaymentMasterCard MC 
		WHERE PtTransMessageInId IN
		(
			SELECT TransMessageInId 
			FROM PtPaymentKTB 
			WHERE FileImportProcessId = @fileImportProcessID
		)
	)
	OR
	Id IN
	(
		SELECT ptPaymentMasterCardId 
		FROM PtPaymentMCMiscellaneousFees
		WHERE CMSMiscellaneousFeeDetails IS NULL
	)
)
AND FileImportProcessID = @fileImportProcessId

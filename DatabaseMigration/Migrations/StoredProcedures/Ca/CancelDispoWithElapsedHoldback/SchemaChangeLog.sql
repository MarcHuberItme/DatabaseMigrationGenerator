--liquibase formatted sql

--changeset system:create-alter-procedure-CancelDispoWithElapsedHoldback context:any labels:c-any,o-stored-procedure,ot-schema,on-CancelDispoWithElapsedHoldback,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CancelDispoWithElapsedHoldback
CREATE OR ALTER PROCEDURE dbo.CancelDispoWithElapsedHoldback
AS
UPDATE PtDispoBooking
SET Status = 4, HdChangeUser=USER_NAME(), HdChangeDate=GETDATE(), HdVersionNo = HdVersionNo + 1
WHERE Status < 2
AND HoldbackDate IS NOT NULL
AND ((HoldbackDate = CAST(TransactionDate AS date) AND HoldbackDate + 2 < GETDATE()) -- This Case is for Tankomat
OR (HoldbackDate <> CAST(TransactionDate AS date) AND HoldbackDate < GETDATE())) -- This is the regular Case
AND HdVersionNo BETWEEN 1 AND 999999998

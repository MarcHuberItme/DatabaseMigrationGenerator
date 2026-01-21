--liquibase formatted sql

--changeset system:create-alter-procedure-GetPaymentScanList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPaymentScanList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPaymentScanList
CREATE OR ALTER PROCEDURE dbo.GetPaymentScanList

@Status tinyint

AS 

SELECT TOP 5 Id, HdEditStamp FROM PtPaymentScan
WHERE Status = @Status 
AND HdVersionNo BETWEEN 1 AND 999999998

--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPendingMigTransDays context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPendingMigTransDays,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPendingMigTransDays
CREATE OR ALTER PROCEDURE dbo.GetPMSPendingMigTransDays
@TransferTypeCodeTransaction tinyint , @RefDateInit DateTime
As

Select TransDate, Count(*) as CountTransaction from PtTransaction
Where TransDate > @RefDateInit 
and TransDate not in (Select TransDate from PtPMSTransferProcess Where TransferTypeCode = @TransferTypeCodeTransaction and EndTime is not null)
Group by TransDate
Order by TransDate

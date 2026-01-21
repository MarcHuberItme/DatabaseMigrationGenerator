--liquibase formatted sql

--changeset system:create-alter-procedure-PMSCheckAndClearOldTransData context:any labels:c-any,o-stored-procedure,ot-schema,on-PMSCheckAndClearOldTransData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PMSCheckAndClearOldTransData
CREATE OR ALTER PROCEDURE dbo.PMSCheckAndClearOldTransData
@CurrentRefDate DateTime
As

if exists(
Select top 1 * from PtPMSTransactionTransfer
inner join PtPMSTransferProcess on PtPMSTransactionTransfer.LastTransferProcessId = PtPMSTransferProcess.Id and PtPMSTransferProcess.TransDate <> @CurrentRefDate) 
Truncate table PtPMSTransactionTransfer

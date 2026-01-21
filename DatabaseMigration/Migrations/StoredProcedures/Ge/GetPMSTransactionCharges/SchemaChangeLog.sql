--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSTransactionCharges context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSTransactionCharges,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSTransactionCharges
CREATE OR ALTER PROCEDURE dbo.GetPMSTransactionCharges
@Transactionid UniqueIdentifier
As
Select ChargeNo, PtTransMessageCharge.* from PtTransMessage
inner join PtPMSPortfolioTransfer on (PtTransMessage.DebitPortfolioId = PtPMSPortfolioTransfer.PortfolioId )
inner join PtTransMessageCharge on PtTransMessage.Id = PtTransMessageCharge.TransMessageId and PtTransmessageCharge.HdVersionNo between 1 and 999999998
inner join PtTransChargeType  on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id
Where TransactionId = @Transactionid 

--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSOwnBondPaybackCharge context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSOwnBondPaybackCharge,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSOwnBondPaybackCharge
CREATE OR ALTER PROCEDURE dbo.GetPMSOwnBondPaybackCharge
@TransactionId UniqueIdentifier, @ChargeTypeNo int
As

Select ChargeNo,PtTransMessageCharge.* from PtTransMessage
inner join PtTransMessageCharge on PtTransMessage.Id = PtTransMessageCharge.TransMessageId
inner join PtTransChargeType on PtTransMessageCharge.transChargeTypeId = PtTransChargeType.Id and ChargeNo = @ChargeTypeNo
Where TransactionId = @TransactionId

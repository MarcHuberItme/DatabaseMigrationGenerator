--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSTransMessageCharges context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSTransMessageCharges,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSTransMessageCharges
CREATE OR ALTER PROCEDURE dbo.GetPMSTransMessageCharges
@TransMessageId  UniqueIdentifier
As
Select ChargeNo, PtTransmessageCharge.* from PtTransmessageCharge
inner join PtTransChargeType  on PtTransMessageCharge.TransChargeTypeId = PtTransChargeType.Id
Where TransMessageID = @TransMessageId 
and PtTransmessageCharge.HdVersionNo between 1 and 999999998

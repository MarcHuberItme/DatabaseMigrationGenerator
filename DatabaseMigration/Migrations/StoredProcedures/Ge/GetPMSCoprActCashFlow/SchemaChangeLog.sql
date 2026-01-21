--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSCoprActCashFlow context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSCoprActCashFlow,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSCoprActCashFlow
CREATE OR ALTER PROCEDURE dbo.GetPMSCoprActCashFlow
@TransactionID UniqueIdentifier
As
Select PrPublicCF.* from EvSelectionPos
inner join EvSelection on EvSelectionPos.EventSelectionId = EvSelection.Id
inner join EvBase on EvSelection.EventId = EvBase.Id
inner join PrPublicCF on EvBase.PublicCfId = PrPublicCF.Id
Where TransactionId = @TransactionID

--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrimaryCorrItemInfoAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrimaryCorrItemInfoAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrimaryCorrItemInfoAccount
CREATE OR ALTER PROCEDURE dbo.GetPrimaryCorrItemInfoAccount

@AccountId UniqueIdentifier,
@CorrItemId UniqueIdentifier 

AS

SELECT TOP 1 AccountId, AddressId, AttentionOf, CarrierTypeNo, DeliveryRuleNo, DetourGroup 
FROM PtCorrAccountView
WHERE AccountId = @AccountId
AND CorrItemId = @CorrItemId
ORDER BY IsPrimaryCorrAddress DESC, CarrierTypeNo ASC, DetourGroup ASC, AddressId ASC


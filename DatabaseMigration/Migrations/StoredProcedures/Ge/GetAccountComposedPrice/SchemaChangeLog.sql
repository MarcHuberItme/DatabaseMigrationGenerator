--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountComposedPrice context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountComposedPrice,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountComposedPrice
CREATE OR ALTER PROCEDURE dbo.GetAccountComposedPrice
@AccountId UniqueIdentifier,
@ActualDate datetime

AS

SELECT AC.DurationTypeId,  AC.PrivateCompCharacteristicNo,  ACP.HdVersionNo,
       ACP.AccountComponentId, ACP.PrivateComponentNo, ACP.IsDebit,
       PRC.CompTypeNo, PRC.PriorityOfLegalReporting, PRC.SequenceNo, ACP.Priority, AC.PriorityOfLegalReporting,
       AC.PriorityOfLegalReporting + ACP.Priority AS OrderField,
       ACP.ValidFrom,  ACP.ValidTo,  ACP.InterestRate, ACP.CommissionRate, ACP.ProvisionRate, ACP.Value, 
       PRC.IsFixedDuration
FROM   PtAccountComposedPrice ACP 
       JOIN PtAccountComponent AC ON ACP.AccountComponentId = AC.Id AND (ACP.ValidTo >= @ActualDate OR ACP.ValidTo IS NULL)
       JOIN PrPrivateCompType PRC  ON AC.PrivateCompTypeId = PRC.Id 
WHERE  AC.AccountBaseId = @AccountId
AND   (AC.HdVersionNo   BETWEEN 1 AND 999999998) 
ORDER BY OrderField, ACP.AccountComponentId, ACP.ValidFrom DESC

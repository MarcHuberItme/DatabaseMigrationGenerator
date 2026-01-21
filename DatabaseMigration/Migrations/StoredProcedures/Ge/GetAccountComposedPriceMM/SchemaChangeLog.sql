--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountComposedPriceMM context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountComposedPriceMM,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountComposedPriceMM
CREATE OR ALTER PROCEDURE dbo.GetAccountComposedPriceMM
@AccountId UniqueIdentifier,
@ActualDate datetime

AS

SELECT AC.DurationTypeId,  AC.PrivateCompCharacteristicNo,  ACP.HdVersionNo,
       ACP.AccountComponentId, ACP.PrivateComponentNo, ACP.IsDebit,
       PRC.CompTypeNo, PRC.PriorityOfLegalReporting, PRC.SequenceNo, ACP.Priority, AC.PriorityOfLegalReporting,
       AC.PriorityOfLegalReporting + ACP.Priority AS OrderField,
       ACP.ValidFrom,  ACP.ValidTo,  ACP.InterestRate, ACP.CommissionRate, ACP.ProvisionRate, ACP.Value, 
       PRC.IsFixedDuration,  APD.ReasonType, PDT.IsGenerated
FROM   PtAccountComposedPrice ACP 
       JOIN PtAccountComponent AC ON ACP.AccountComponentId = AC.Id AND (ACP.ValidTo >= @ActualDate OR ACP.ValidTo IS NULL)
       JOIN PrPrivateCompType PRC  ON AC.PrivateCompTypeId = PRC.Id 
       LEFT OUTER JOIN PtAccountPriceDeviation APD ON AC.AccountBaseId = APD.AccountbaseId
                 AND   (APD.HdVersionNo BETWEEN 1 AND 999999998)
       LEFT OUTER JOIN PtAccountPriceDevType PDT ON APD.ReasonType = PDT.DeviationReasonType
                 AND   (PDT.HdVersionNo BETWEEN 1 AND 999999998)
WHERE  AC.AccountBaseId = @AccountId
AND   (AC.HdVersionNo   BETWEEN 1 AND 999999998) 
GROUP BY AC.DurationTypeId,AC.PrivateCompCharacteristicNo,ACP.HdVersionNo,
          ACP.AccountComponentId,ACP.PrivateComponentNo,ACP.IsDebit,
          PRC.CompTypeNo,PRC.PriorityOfLegalReporting,PRC.SequenceNo,ACP.Priority,AC.PriorityOfLegalReporting,
          AC.PriorityOfLegalReporting + ACP.Priority,ACP.ValidFrom,ACP.ValidTo,ACP.InterestRate,ACP.CommissionRate,
          ACP.ProvisionRate,ACP.Value,PRC.IsFixedDuration,APD.ReasonType,PDT.IsGenerated
ORDER BY OrderField, ACP.AccountComponentId, ACP.ValidFrom DESC

--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountCompValue context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountCompValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountCompValue
CREATE OR ALTER PROCEDURE dbo.GetAccountCompValue
@AccountId UniqueIdentifier

AS

SELECT AC.HdVersionNo, AC.Id AS AccountComponentId,
              PC.PrivateComponentNo, PCT.IsDebit,
              AC.PriorityOfLegalReporting AS Priority,
              AC.Duration,   DT.DurationType,
              ACV.ValidFrom, ACV.ValidFrom AS MaturityDate,
              ACV.Value,     ACV.IsDurationRecord
FROM   PtAccountComponent AC LEFT OUTER JOIN PtAccountCompValue ACV
       ON AC.Id = ACV.AccountComponentId   JOIN PrPrivateComponent PC
       ON AC.PrivateComponentId = PC.Id    JOIN PrPrivateCompType PCT
       ON AC.PrivateCompTypeId  = PCT.Id   LEFT OUTER JOIN PrDurationType DT
       ON AC.DurationTypeId     = DT.Id
WHERE  AC.AccountBaseId = @AccountId
AND        AC.IsOldComponent = 0
AND       (AC.HdVersionNo  BETWEEN 1 AND 999999998)
AND       (ACV.HdVersionNo BETWEEN 1 AND 999999998 OR ACV.HdVersionNo IS NULL)
AND       (PC.HdVersionNo  BETWEEN 1 AND 999999998)
AND       (PCT.HdVersionNo BETWEEN 1 AND 999999998)
ORDER BY Priority, PC.PrivateComponentNo, ACV.ValidFrom 

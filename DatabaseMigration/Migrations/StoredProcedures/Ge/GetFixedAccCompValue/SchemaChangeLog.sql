--liquibase formatted sql

--changeset system:create-alter-procedure-GetFixedAccCompValue context:any labels:c-any,o-stored-procedure,ot-schema,on-GetFixedAccCompValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetFixedAccCompValue
CREATE OR ALTER PROCEDURE dbo.GetFixedAccCompValue

@AccountComponentId uniqueidentifier

AS

SELECT Top 1 Id, IsDurationRecord, HdPendingChanges 
FROM PtAccountCompValue
WHERE AccountComponentId = @AccountComponentId 
AND HdVersionNo <= 999999998
ORDER By ValidFrom DESC


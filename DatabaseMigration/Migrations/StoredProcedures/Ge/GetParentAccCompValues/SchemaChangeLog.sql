--liquibase formatted sql

--changeset system:create-alter-procedure-GetParentAccCompValues context:any labels:c-any,o-stored-procedure,ot-schema,on-GetParentAccCompValues,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetParentAccCompValues
CREATE OR ALTER PROCEDURE dbo.GetParentAccCompValues

@AccountComponentId uniqueidentifier,
@AccountCompValueId uniqueidentifier,
@ValidFrom datetime

AS

SELECT V.*, U.MutField FROM PtAccountCompValue AS V
LEFT OUTER JOIN AsUnconfirmed AS U ON V.Id = U.Id 
	AND V.HdPendingChanges > 0 AND U.TableName = 'PtAccountCompValue'
WHERE AccountComponentId = @AccountComponentId
AND V.Id <> @AccountCompValueId
AND (ValidFrom = @ValidFrom OR HdPendingChanges <> 0)

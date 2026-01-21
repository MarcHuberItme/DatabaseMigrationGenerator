--liquibase formatted sql

--changeset system:create-alter-procedure-GetIcmAcCompValueList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetIcmAcCompValueList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetIcmAcCompValueList
CREATE OR ALTER PROCEDURE dbo.GetIcmAcCompValueList

@AccountId AS UniqueIdentifier

AS

SELECT V.Id,V.HdPendingChanges, V.HdVersionNo, V.AccountComponentId,V.Value,V.ValidFrom 
FROM PtAccountBase AS A
	INNER JOIN PtAccountComponent AS C ON A.Id = C.AccountBaseId
	INNER JOIN PtAccountCompValue AS V ON C.Id = V.AccountComponentId 
WHERE A.Id = @AccountId
	AND V.HdVersionNo < 999999999 
	AND A.HdVersionNo < 999999999
	AND C.HdVersionNo < 999999999

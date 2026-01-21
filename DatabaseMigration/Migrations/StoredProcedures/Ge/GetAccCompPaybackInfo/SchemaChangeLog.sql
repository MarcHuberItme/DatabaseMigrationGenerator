--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccCompPaybackInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccCompPaybackInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccCompPaybackInfo
CREATE OR ALTER PROCEDURE dbo.GetAccCompPaybackInfo

@AccountId uniqueidentifier

AS

SELECT 	C.Id AS AccountCompId, C.PriorityOfPayback, C.MgLimite, 
	V.Id as AccountCompValueId, V.ValidFrom, V.Value	

FROM	PtAccountComponent as C

INNER JOIN PtAccountCompValue as V 
	ON C.Id = V.AccountComponentId AND V.HdVersionNo BETWEEN 1 AND 999999998
INNER JOIN PrPrivateCompType AS T 
	ON T.Id = C.PrivateCompTypeId AND T.IsFixed = 0

WHERE 	AccountBaseId = @AccountId
	AND T.IsDebit = 1 
	AND T.IsLimitRelevant= 1 
	AND C.IsOldComponent = 0
	AND Duration Is NULL 
	AND C.HdVersionNo BETWEEN 1 AND 999999998

ORDER BY 
	C.PriorityOfPayback, 
	C.HdCreateDate, 
	C.Id, 
	V.ValidFrom

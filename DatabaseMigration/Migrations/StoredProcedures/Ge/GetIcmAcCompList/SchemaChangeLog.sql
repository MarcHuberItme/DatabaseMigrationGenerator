--liquibase formatted sql

--changeset system:create-alter-procedure-GetIcmAcCompList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetIcmAcCompList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetIcmAcCompList
CREATE OR ALTER PROCEDURE dbo.GetIcmAcCompList

@AccountId AS UniqueIdentifier

AS

SELECT C.Id, C.HdPendingChanges, C.HdVersionNo, C.AccountBaseId, C.PrivateComponentId,
C.PriorityOfInterestCalculation, V.RoundingType, V.RoundingRule
FROM PtAccountBase AS A
	INNER JOIN PtAccountComponent  AS C ON C.AccountBaseId = A.Id
	INNER JOIN PrPrivateComponent  AS P ON P.Id = C.PrivateComponentId
	INNER JOIN PrPrivateCurrRegion AS R ON R.Id = P.PrivateCurrRegionId
	INNER JOIN PrPrivate AS V ON V.ProductNo = R.ProductNo
WHERE A.Id = @AccountId
	AND A.HdVersionNo < 999999999
	AND R.HdVersionNo < 999999999 
	AND P.HdVersionNo < 999999999 
	AND C.HdVersionNo < 999999999
	AND EXISTS (SELECT * FROM PtAccountCompValue WHERE AccountComponentId = C.Id AND HdVersionNo < 999999999)

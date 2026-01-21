--liquibase formatted sql

--changeset system:create-alter-procedure-GetIcmPrCompList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetIcmPrCompList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetIcmPrCompList
CREATE OR ALTER PROCEDURE dbo.GetIcmPrCompList

@AccountId AS UniqueIdentifier

AS

SELECT P.Id, P.HdPendingChanges, P.HdVersionNo, R.ProductNo, P.PrivateComponentNo, C.Id as PrivateComponentId, P.ValidFrom, P.ValidTo, P.IsDebit, P.InterestRate, P.CommissionRate,P.ProvisionRate
FROM PtAccountBase AS A
	INNER JOIN PtAccountComponent  AS Ac ON A.Id = Ac.AccountBaseId
	INNER JOIN PrPrivateComponent  AS C  ON C.Id = Ac.PrivateComponentId
	INNER JOIN PrComposedPrice     AS P  ON P.PrivateComponentId = C.Id
	INNER JOIN PrPrivateCurrRegion AS R  ON R.Id = C.PrivateCurrRegionId
WHERE A.Id = @AccountId
	AND A.HdVersionNo < 999999999
	AND C.HdVersionNo < 999999999
	AND R.HdVersionNo < 999999999
	AND P.State = 2

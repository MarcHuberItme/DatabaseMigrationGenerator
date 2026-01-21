--liquibase formatted sql

--changeset system:create-alter-procedure-GetIcmAcPriceDeviationList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetIcmAcPriceDeviationList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetIcmAcPriceDeviationList
CREATE OR ALTER PROCEDURE dbo.GetIcmAcPriceDeviationList

@AccountId AS UniqueIdentifier

AS

SELECT D.Id,D.HdPendingChanges, D.HdVersionNo, D.AccountComponentId,
               D.AccountBaseId,D.CreditDeviation, D.ValidFrom, IsNull(D.ValidTo,'99991231') As ValidTo, D.InterestRate,
               D.CommissionRate,D.ProvisionRate,D.IsAbsolute, D.MinimumRate, D.MaximumRate
FROM PtAccountBase AS A
	INNER JOIN PtAccountPriceDeviation AS D ON D.AccountBaseId = A.Id
WHERE A.Id = @AccountId
	AND D.HdVersionNo <> 999999999
    	AND D.AccountComponentId IS NULL

UNION ALL 

SELECT D.Id,D.HdPendingChanges, D.HdVersionNo, D.AccountComponentId, 
	D.AccountBaseId,D.CreditDeviation, D.ValidFrom, IsNull(D.ValidTo,'99991231') As ValidTo, D.InterestRate,
	D.CommissionRate,D.ProvisionRate,D.IsAbsolute, D.MinimumRate, D.MaximumRate
FROM PtAccountBase AS A
	INNER JOIN PtAccountPriceDeviation AS D ON D.AccountBaseId = A.Id
	INNER JOIN PtAccountComponent AS C ON C.Id = D.AccountComponentId
WHERE A.Id = @AccountId
	AND D.HdVersionNo <> 999999999
	AND C.HdVersionNo <> 999999999
	AND EXISTS (SELECT * FROM PtAccountCompValue WHERE AccountComponentId = C.Id AND HdVersionNo < 999999999)



--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPledgeForAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPledgeForAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPledgeForAccount
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPledgeForAccount

@AccountId uniqueidentifier,
@ValuationDate datetime

AS

declare @SubKtnr tinyint
declare @VaRunId uniqueidentifier

set @SubKtnr = 0

Select Top 1 @VaRunId = ID
From  VaRun 
Where  RunTypeNo in (0 ,1, 2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    ValuationDate <= @ValuationDate
Order  by ValuationDate DESC

SELECT Pledged.Value AS PledgedValue, Pledged.AccountBaseId, Va.MarketValueCHF, RatePrCuCHF
FROM (
SELECT Ac.AccountBaseId, SUM(Acp.Value) AS Value
FROM PtAccountBase AS A
INNER JOIN PtAccountComponent AS Ac ON A.AccountNo = Ac.MgVBNR AND Ac.MgVBSUBKTNR = @SubKtnr
INNER JOIN PtAccountComposedPrice AS Acp ON Ac.Id = Acp.AccountComponentId AND Acp.ValidFrom < @ValuationDate AND (Acp.ValidTo >= @ValuationDate OR Acp.ValidTo IS NULL)
WHERE A.Id = @AccountId 
AND A.TerminationDate IS NULL
AND Acp.IsDebit = 1
GROUP BY Ac.AccountBaseId) AS Pledged
INNER JOIN PrReference AS Ref ON Pledged.AccountBaseId = Ref.AccountId
INNER JOIN VaPrivateView AS Va ON Ref.Id = Va.ProdReferenceId AND Va.VaRunId = @VaRunId

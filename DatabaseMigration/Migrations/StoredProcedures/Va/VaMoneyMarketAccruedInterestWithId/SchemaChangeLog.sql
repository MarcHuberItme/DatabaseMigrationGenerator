--liquibase formatted sql

--changeset system:create-alter-procedure-VaMoneyMarketAccruedInterestWithId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaMoneyMarketAccruedInterestWithId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaMoneyMarketAccruedInterestWithId
CREATE OR ALTER PROCEDURE dbo.VaMoneyMarketAccruedInterestWithId
--StoreProcedure: VaMoneyMarketAccruedInterestWithId
@RunId Uniqueidentifier
AS

/*
Declare @RunId  AS Uniqueidentifier
Set @RunID = 'A656CA32-E4DC-46A8-8AC7-21B18D637CB4'
*/

Select PQ.ID, PQ.PositionId, PQ.AccruedInterestPrCu, PQ.Quantity
from VaPosQuant PQ
--inner join ptPosition pos on pos.id = Pq.positionId
--Inner Join prReference REF on REF.ID = POS.ProdReferenceId
--Inner Join ptAccountBase AB on AB.ID = REF.AccountId
Where PQ.VaRunId = @RunId
AND PQ.PrivateId in (Select ID From prPrivate P Where P.IsMoneyMarket = 1 AND P.AssetReportRuleNo <> 2 )
AND PQ.Quantity <> 0

--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosFuturesWithRunId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosFuturesWithRunId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosFuturesWithRunId
CREATE OR ALTER PROCEDURE dbo.VaPosFuturesWithRunId
--StoreProcedure: VaPosFuturesWithRunId
@RunId uniqueidentifier AS

/*
Declare @RunId Uniqueidentifier
Set @RunId = '36212CCF-8E6B-4660-8F8E-F9A58A94B127'
*/

Delete VaPosFutures
From VaPosFutures PF
Left Outer Join VaPosQuant PQ on PQ.ID = PF.PosQuantId
Where PQ.VaRunId = @RunId OR PQ.Id is NULL

Insert into VaPosFutures
(PosQuantId, DifferenceValueAcCu)
SELECT	PQ.Id,
	PV.MarketValuePrCu 
	- SUM(ISNULL(PTM.DebitAmount, 0)) 
	+ SUM(ISNULL(PTM.CreditAmount,0)) AS DifferenceAmount 
FROM	   PtPosition POS
Inner Join PrReference REF ON REF.Id = POS.ProdReferenceId 
Inner Join PrPublic PUB ON PUB.ProductId = REF.ProductId
Inner Join VaPublicView PV ON POS.Id = PV.PositionId
Inner Join VaRun R ON R.Id = PV.VaRunId
Inner Join VaPosQuant PQ on PQ.PositionID = POS.ID AND PQ.VARunId = R.ID
Inner Join PtTransMessageFutures TMF ON POS.Id = TMF.PositionId
Inner Join PtTransMessage PTM ON PTM.Id = TMF.TransMessageIdCustomer
Inner Join PtTransaction PTS ON PTS.Id = PTM.TransactionId
WHERE	POS.HdVersionNo < 999999999
AND	
Case R.synchronizeTypeNo 
	When 0 Then
		PTM.DebitValueDate
	When 1 Then
		PTS.TransDate 
	When 2 Then
		PTM.TradeDate 
end  <= R.ValuationDate


AND R.Id = @RunId
AND	((PUB.SecurityType = 'P' AND PV.Quantity <> 0)
OR 	 (POS.Id IN (SELECT PositionId FROM PtTransMessageFutures WHERE FuturesStatusNo = 1)))
AND	TMF.FuturesStatusNo = 1
GROUP BY POS.Id, PQ.ID, R.Id, PV.MarketValuePrCu




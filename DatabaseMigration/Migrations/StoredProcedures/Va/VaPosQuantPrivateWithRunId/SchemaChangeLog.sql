--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantPrivateWithRunId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantPrivateWithRunId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantPrivateWithRunId
CREATE OR ALTER PROCEDURE dbo.VaPosQuantPrivateWithRunId
--Store Procedure: VaPosQuantPrivateWithRunId
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId = 'A7FBF897-55BA-4EF5-971D-774EF48ED2EF'
*/

--6. Hinzufügen von neuen Kontis
Print 'Insert into VaPosQuant (Kontis)'
Insert into VaPosQuant
(ValPortfolioId, PositionId, AccountCurrency, PortfolioId, VaRunId, ProdReferenceId, PublicId, PrivateId)
Select POR.ID, PO.ID, REF.Currency, POR.PortfolioId, R.Id, REF.ID, NULL, PRI.ID
From  VaPortfolio POR
Inner Join ptPosition PO on POR.PortfolioId = PO.PortfolioId		
Inner Join prReference REF on PO.ProdReferenceId = REF.ID
Inner Join ptAccountBase AB on AB.Id = REF.AccountId
Inner Join prPrivate PRI on PRI.ProductId  = REF.ProductId
--Inner Join prOperationType OT on OT.ID = PRI.OperationTypeId
Inner Join VaRun R on R.Id = POR.ValRunId
Left Outer Join VaPosQuant POS on POS.PositionId = PO.ID AND POS.VaRunID = R.Id
Where R.Id = @RunId
AND ( AB.TerminationDate > R.ValuationDate OR AB.TerminationDate is null)
AND	  AB.OpeningDate <= R.ValuationDate
AND POS.Id Is NULL;

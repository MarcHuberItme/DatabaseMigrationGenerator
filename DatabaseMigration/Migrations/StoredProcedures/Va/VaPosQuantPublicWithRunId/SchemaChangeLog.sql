--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantPublicWithRunId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantPublicWithRunId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantPublicWithRunId
CREATE OR ALTER PROCEDURE dbo.VaPosQuantPublicWithRunId
--Store Procedure: VaPosQuantPublicWithRunId
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId =  'A7FBF897-55BA-4EF5-971D-774EF48ED2EF'
*/

--7. Hinzufügen von Instrumenten
Print 'Insert into VaPosQuant (Instrumente)'

Insert into VaPosQuant
(ValPortfolioId, PositionId, AccountCurrency, PortfolioId, VaRunId, ProdReferenceId, PublicId, PrivateId)
Select POR.ID, PO.ID, PUB.NominalCurrency, POR.PortfolioId, R.Id, REF.ID, PUB.Id, NULL
From  VaPortfolio POR
Inner Join ptPosition PO on POR.PortfolioId = PO.PortfolioId		
Inner Join prReference REF on PO.ProdReferenceId = REF.ID
Inner Join prPublic PUB on PUB.ProductId  = REF.ProductId
Inner Join VaRun R on R.Id = POR.ValRunId
Left Outer Join VaPosQuant POS on POS.PositionId = PO.ID AND POS.VaRunID = R.Id
Where R.Id = @RunId
AND ((PUB.DeletionDate > R.ValuationDate OR PUB.DeletionDate is null) OR PO.Quantity <> 0)
AND	  PUB.OpeningDate <= R.ValuationDate
AND POS.Id Is NULL 

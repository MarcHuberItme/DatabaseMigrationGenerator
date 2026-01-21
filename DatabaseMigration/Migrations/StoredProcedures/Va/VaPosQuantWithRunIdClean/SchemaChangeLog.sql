--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantWithRunIdClean context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantWithRunIdClean,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantWithRunIdClean
CREATE OR ALTER PROCEDURE dbo.VaPosQuantWithRunIdClean
--Store Procedure: VaPosQuantWithRunIdClean
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId ='A7FBF897-55BA-4EF5-971D-774EF48ED2EF'
*/

--9. Instrumente mit Quantity 0/NULL löschen
Print 'Delete VaPosQuant Where Instrument Quantity = NULL/0 '
Delete VaPosQuant
--Select Count(*)
From  VaPosQuant PQ
Where PQ.VaRunId =  @RunId
AND (PQ.Quantity = 0 Or PQ.Quantity is null)
AND PQ.PublicID is not Null

--10. Kontos welche saldiert oder in der Zukunft eröffnet sind löschen
Print 'Delete VaPosQuant Where Account not Open '
Delete VaPosQuant
--Select Count(*)
From  VaPosQuant PQ
Inner Join prReference REF on REF.ID = PQ.ProdReferenceId
Inner Join PtAccountBase AB on AB.ID = REF.AccountId
Inner Join VaRun R on R.Id = PQ.VaRunId
Where R.Id = @RunId
AND (AB.TerminationDate < R.ValuationDate
OR   Dateadd(day,-1,AB.OpeningDate) > R.ValuationDate);


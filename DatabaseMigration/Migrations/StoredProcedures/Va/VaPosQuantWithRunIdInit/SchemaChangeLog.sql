--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantWithRunIdInit context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantWithRunIdInit,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantWithRunIdInit
CREATE OR ALTER PROCEDURE dbo.VaPosQuantWithRunIdInit
--Store Procedure: VaPosQuantWithRunIdInit
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId ='A7FBF897-55BA-4EF5-971D-774EF48ED2EF'
*/

--5. Löschen überflüssiger PosQuant Einträge Wenn Portfolio nicht gültig
Print 'Delete VaPosQuant per Date'
Delete VaPosQuant
From VaPosQuant PQ
Left Outer Join PtPosition P on P.Id = PQ.PositionId
Left Outer Join ptPortfolio PP on PP.Id = PQ.PortfolioId
Inner Join VaRun R on R.Id = PQ.VaRunId
Where R.Id = @RunId
AND ( PP.TerminationDate < R.ValuationDate
OR	  PP.OpeningDate > R.ValuationDate);

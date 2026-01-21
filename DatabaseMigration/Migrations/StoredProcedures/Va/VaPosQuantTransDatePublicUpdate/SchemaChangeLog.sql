--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantTransDatePublicUpdate context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantTransDatePublicUpdate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantTransDatePublicUpdate
CREATE OR ALTER PROCEDURE dbo.VaPosQuantTransDatePublicUpdate
--Store Procedure: VaPosQuantTransDatePublicUpdate
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId = 'A7FBF897-55BA-4EF5-971D-774EF48ED2EF'
*/

If (Select SynchronizeTypeNo From  VaRun Where Id = @RunId) = 1
	Begin
--10. Aktualisieren von Instrumenten Positionen via ptTransItem fÃƒÂ¼r Erstellungsdatum;
	Print 'Update VaPosQuant With (Instrumente)';
		begin tran
			CREATE TABLE #temptable1 (POSQuantity float, PosId uniqueidentifier);

			INSERT INTO #temptable1
			(POSQuantity, PosId )

		Select ISNULL(SUM(PTI.CreditQuantity), 0) -  ISNULL(SUM(PTI.DebitQuantity),0), PQ.Id
			FROM		VaPosQuant  PQ with (UpdLock)
			Inner Join	VaPortfolio POR with (UpdLock) on POR.PortfolioId = PQ.PortfolioId AND POR.ValRunId = PQ.VaRunId
			Inner Join	VaRun R on R.Id = POR.ValRunId AND R.SynchronizeTypeNo = 1
			LEFT OUTER JOIN	PtTransItem PTI ON PTI.PositionId = PQ.PositionId AND PTI.HdVersionNo Between 1 AND 999999998
			Where R.Id = @RunId
			And PUblicId is not Null
     		AND PTI.TransDate <= R.ValuationDate
			GROUP BY 	PQ.Id, Por.Id, PQ.PositionId
			Option (MaxDop 2);

			CREATE INDEX Temptable1_Index
			ON dbo.#temptable1
			(PosId)

		Update VaPosQuant
			Set Quantity = POSQuantity							
		From VaposQuant
		Inner Join #temptable1 on VaPosQuant.Id = #temptable1.PosID
		Option (MaxDop 2);
		DROP TABLE #temptable1;
		Commit;
	End

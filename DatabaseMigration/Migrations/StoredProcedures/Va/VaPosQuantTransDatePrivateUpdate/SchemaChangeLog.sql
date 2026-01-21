--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantTransDatePrivateUpdate context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantTransDatePrivateUpdate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantTransDatePrivateUpdate
CREATE OR ALTER PROCEDURE dbo.VaPosQuantTransDatePrivateUpdate
--Store Procedure: VaPosQuantTransDatePrivateUpdate
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId = 'A7FBF897-55BA-4EF5-971D-774EF48ED2EF'
*/

If (Select SynchronizeTypeNo From  VaRun Where Id = @RunId) = 1
	Begin

		if (Select IncludedPositionsNo From VaRun Where Id = @RunId) in (0,1)
		--8. Aktualisiere Kontos und Instrumente profisorisch via ptPosition
			Begin;
				--9. Aktualisieren von Konto Positionen via ptTransItem und ptPosition fÃ¼r Erstellungsdatum;
				Print 'Update VaPosQuant With (Kontis)';
				--begin tran
				CREATE TABLE #temptable (POSQuantity float, PosId uniqueidentifier);

				INSERT INTO #temptable
				(POSQuantity, PosId )

					Select (isnull(POS.ValueProductCurrency,0) + ISNULL(SUM(PTI.DebitAmount),0) - ISNULL(SUM(PTI.CreditAmount), 0) 
								)-- - ISNULL(SUM(PTI_2.DebitAmount),0) + ISNULL(SUM(PTI_2.CreditAmount), 0))
					, PQ.Id
					FROM		VaPosQuant  PQ /*with (UpdLock)*/
					Inner Join	VaPortfolio POR /*with (UpdLock)*/ on POR.PortfolioId = PQ.PortfolioId AND POR.ValRunId = PQ.VaRunId 
					Inner Join	PtPosition POS /*(UpdLock)*/ on PQ.PositionId = POS.ID
					Inner Join	VaRun R on R.ID = PQ.VaRunId AND R.SynchronizeTypeNo = 1
					LEFT OUTER JOIN	PtTransItem PTI ON PTI.PositionId = PQ.PositionId AND PTI.TransDate > R.ValuationDate AND PTI.DetailCounter >= 1 AND PTI.HdVersionNo Between 1 AND 999999998
					--LEFT OUTER JOIN	PtTransItem PTI_2 ON PTI_2.PositionId = PQ.PositionId AND PTI_2.TransDate <= R.ValuationDate AND PTI_2.DetailCounter = 0 AND PTI_2.HdVersionNo Between 1 AND 999999998
					Where PQ.VaRunId = @RunId
					And PrivateID is not null
					AND POS.latestTransdate >= R.ValuationDate		
					GROUP BY 	PQ.Id, Por.Id, PQ.PositionId, POS.ValueProductCurrency
					Option (MaxDop 2);

					CREATE INDEX Temptable_Index
					ON dbo.#temptable
					(PosId)

				Update VaPosQuant
					Set Quantity = POSQuantity						
				From VaposQuant
				Inner Join #temptable on VaPosQuant.Id = #temptable.PosID
				Where  Quantity <> POSQuantity	
				Option (MaxDop 2);
				DROP TABLE #temptable;
			--Commit;
		End
	END

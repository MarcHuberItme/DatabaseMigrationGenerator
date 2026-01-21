--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantValueDatePrivate context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantValueDatePrivate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantValueDatePrivate
CREATE OR ALTER PROCEDURE dbo.VaPosQuantValueDatePrivate
--Store Procedure: VaPosQuantValueDatePrivate
@RunId uniqueidentifier AS
/*
Declare @RunId AS uniqueidentifier
Set @RunId = '9ECD1419-EE06-42A4-939E-478ECCAFE0C8'
*/

if (Select IncludedPositionsNo From VaRun Where Id = @RunId) in(0,1) AND (Select SynchronizeTypeNo From  VaRun Where Id = @RunId) = 0
--9. Aktualisieren von Konto Positionen via ptTransItem und ptPosition für Valutadatum;
Begin
	begin tran
		CREATE TABLE #temptable (POSQuantity float, PosId uniqueidentifier);

		INSERT INTO #temptable
		(POSQuantity, PosId )
			Select  (isnull(POS.ValueProductCurrency,0) + ISNULL(SUM(PTI.DebitAmount),0) - ISNULL(SUM(PTI.CreditAmount), 0) 
							- ISNULL(SUM(PTI_2.DebitAmount),0) + ISNULL(SUM(PTI_2.CreditAmount), 0)), PQ.Id
			FROM		VaPosQuant  PQ
			Inner Join	VaPortfolio POR on POR.PortfolioId = PQ.PortfolioId AND POR.ValRunId = PQ.VaRunId
			Inner Join	PtPosition POS (UpdLock) on PQ.PositionId = POS.ID
			Inner Join VaRun R on R.ID = POR.ValRunId AND R.SynchronizeTypeNo = 0				
			LEFT OUTER JOIN	PtTransItem PTI ON PTI.PositionId = POS.Id AND PTI.ValueDate > R.ValuationDate AND PTI.DetailCounter >= 1 AND PTI.HdVersionNo Between 1 AND 999999998
			LEFT OUTER JOIN	PtTransItem PTI_2 ON PTI_2.PositionId = POS.Id AND PTI_2.ValueDate <= R.ValuationDate AND PTI_2.DetailCounter = 0 AND PTI_2.HdVersionNo Between 1 AND 999999998
			Where R.Id = @RunId
			AND POS.ID = PQ.PositionId
			AND PQ.Privateid is not null

			GROUP BY 	PQ.Id, Por.Id, PQ.PositionId, POS.ValueProductCurrency
			Option (MaxDop 2);
		Update VaPosQuant
			Set Quantity = POSQuantity						
		From VaposQuant
		Inner Join #temptable on VaPosQuant.Id = #temptable.PosID
		Option (MaxDop 2);

	DROP TABLE #temptable;
	Commit;
	End;

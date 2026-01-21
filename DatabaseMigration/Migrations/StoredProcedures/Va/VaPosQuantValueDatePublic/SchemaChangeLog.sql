--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantValueDatePublic context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantValueDatePublic,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantValueDatePublic
CREATE OR ALTER PROCEDURE dbo.VaPosQuantValueDatePublic
--Store Procedure: VaPosQuantValueDatePublic
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId = '9ECD1419-EE06-42A4-939E-478ECCAFE0C8'
*/

If (Select SynchronizeTypeNo From  VaRun Where Id = @RunId) = 0
	Begin
	--10. Aktualisieren von Instrumenten Positionen via ptTransItem für Valutadatum;
	Print 'Update VaPosQuant With (Instrumente)';
		begin tran
			CREATE TABLE #temptable1 (POSQuantity float, PosId uniqueidentifier);

			INSERT INTO #temptable1
			(POSQuantity, PosId )
			Select  ISNULL(SUM(PTI.CreditQuantity), 0) -ISNULL(SUM(PTI.DebitQuantity),0), PQ.Id
			FROM		VaPosQuant  PQ
			Inner Join	VaRun R on R.Id = PQ.VaRunId AND R.SynchronizeTypeNo = 0
			LEFT OUTER JOIN	PtTransItem PTI ON PTI.PositionId = PQ.PositionId AND PTI.hdVersionNo Between 1 AND 999999998
			Where PQ.VaRunId = @RunId
			AND PTI.ValueDate <= R.ValuationDate
			AND PQ.Publicid is not null
			GROUP BY 	PQ.Id
			Option (MaxDop 2);
			
			Update VaPosQuant
			Set Quantity = POSQuantity						
			From VaposQuant
			Inner Join #temptable1 on VaPosQuant.Id = #temptable1.PosID
			Option (MaxDop 2);

		DROP TABLE #temptable1;
		Commit;
	End

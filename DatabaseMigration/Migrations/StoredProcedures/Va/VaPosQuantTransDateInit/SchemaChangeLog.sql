--liquibase formatted sql

--changeset system:create-alter-procedure-VaPosQuantTransDateInit context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPosQuantTransDateInit,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPosQuantTransDateInit
CREATE OR ALTER PROCEDURE dbo.VaPosQuantTransDateInit
--Store Procedure: VaPosQuantTransDatePrivateInit
@RunId uniqueidentifier AS

/*
Declare @RunId AS uniqueidentifier
Set @RunId = '{B8C4D0BA-8B35-46D0-8FB6-AAA64B77156B}'
*/
if (Select IncludedPositionsNo From VaRun Where Id = @RunId) in (0,1) AND (Select SynchronizeTypeNo From  VaRun Where Id = @RunId) = 1
--8. Aktualisiere Kontos und Instrumente profisorisch via ptPosition
	Begin;
		Print 'Update VaPosQuant ALL'
		Update VaPosQuant
		Set Quantity = PO.Quantity + PO.ValueProductCurrency
		From VaPosQuant PQ
		Inner Join ptPosition PO on PQ.PositionID = PO.Id
		Inner Join VaRun R on PQ.VaRunId = R.ID
		Where R.ID = @RunId
	End



--liquibase formatted sql

--changeset system:create-alter-procedure-VaGetNextStepNo context:any labels:c-any,o-stored-procedure,ot-schema,on-VaGetNextStepNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaGetNextStepNo
CREATE OR ALTER PROCEDURE dbo.VaGetNextStepNo
--Storeprocedure: VaGetNextStepNo
@StepNo integer,
@BatchModus bit
AS

/*
Declare @StepNo integer
Set @StepNo = 0
Declare @BatchModus bit
Set @BatchModus = 1
*/

Select TOP 1 ValuationStatusNo 
From VaValuationStatus
Where ValuationStatusNo > @StepNo
AND Case  @BatchModus 
	When 0 Then
		BatchModusOnly
	else
		0
	end = 0
Order by ValuationStatusNo ASC

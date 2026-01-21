--liquibase formatted sql

--changeset system:create-alter-procedure-VaRefValInitWithRunId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRefValInitWithRunId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRefValInitWithRunId
CREATE OR ALTER PROCEDURE dbo.VaRefValInitWithRunId
--Store Procedure: VaRefValInitWithRunId
@RunId uniqueidentifier
AS
/*
Declare @RunId AS uniqueidentifier
Set @RunId = '9ECD1419-EE06-42A4-939E-478ECCAFE0C8'--'{52355EBD-58A2-41AA-BCC8-8141A434C787}'
*/

--RefVal aufbauen, 
--1. Insert der nicht vorhandenen Einträge

Insert Into VaRefVal 
(ValRunId, ProdReferenceId, NotActual, AcCurrency)

Select Distinct @RunId, PQ.ProdReferenceId, 1, REF.Currency
From VaRun RUN 
Inner Join VaPosQuant PQ on PQ.VaRunId = @RunId 
Inner Join prReference REF on REF.ID = PQ.ProdReferenceId
Left Outer Join VaRefVal RV on RV.VALRunId = @RunId AND RV.ProdReferenceId = PQ.ProdReferenceId 

Where RV.Id is Null
AND RUN.ID = @RunId
AND PublicId is not null
Group by PQ.ProdReferenceId, REF.Currency
Option (MaxDop 2);
--2. Positionen auf nicht aktuell setzten
Update VaRefVal
Set NotActual = 1
Where NotActual = 0 AND ValRunId  = @RunId
Option (MaxDop 2);

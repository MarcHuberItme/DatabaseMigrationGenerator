--liquibase formatted sql

--changeset system:create-alter-procedure-VaRunWithValuationDate context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRunWithValuationDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRunWithValuationDate
CREATE OR ALTER PROCEDURE dbo.VaRunWithValuationDate
--StoreProcedure: VaRunWithValuationDate

@ValuationDate Datetime,
@RunID uniqueidentifier OUTPUT
AS
Select TOP 1 @RunId = ID 
From VaRun 
Where ValuationDate <= @ValuationDate
AND   SynchronizeTypeNo = 1
AND   ValuationStatusNo = 99
AND   ValuationTypeNo = 0
AND   RunTypeNo in (0 ,1,2)
Order  by ValuationDate DESC

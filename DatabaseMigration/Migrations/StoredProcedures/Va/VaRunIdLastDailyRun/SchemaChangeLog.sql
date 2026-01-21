--liquibase formatted sql

--changeset system:create-alter-procedure-VaRunIdLastDailyRun context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRunIdLastDailyRun,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRunIdLastDailyRun
CREATE OR ALTER PROCEDURE dbo.VaRunIdLastDailyRun
--Store Procedure: VaRunIdLastDailyRun

@ID Uniqueidentifier OUTPUT

AS

Select  @ID = ID 
From  VaRun 
Where  RunTypeNo in (0 ,1,2)
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
AND    PartnerId is Null
AND    PortfolioId is Null
Order  by ValuationDate ASC

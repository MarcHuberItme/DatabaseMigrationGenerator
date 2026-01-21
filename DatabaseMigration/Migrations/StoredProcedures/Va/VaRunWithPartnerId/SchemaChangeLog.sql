--liquibase formatted sql

--changeset system:create-alter-procedure-VaRunWithPartnerId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRunWithPartnerId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRunWithPartnerId
CREATE OR ALTER PROCEDURE dbo.VaRunWithPartnerId
--VaRunWithPartnerId

@PartnerId uniqueidentifier
AS
/*
Declare @PartnerId as uniqueidentifier
Set @PartnerId = 'C97113D5-FFDF-4321-907D-735E810801AD'
*/
Select * 
From	VaRun 
Where   SynchronizeTypeNo in (0,1,2)
AND     ValuationStatusNo = 99
AND     ValuationTypeNo = 0

AND     ((RunTypeNo in (0,1,2,99) AND PartnerId Is Null) 
		OR 
		(RunTypeNo = 99	AND	PartnerId = @PartnerId)) 
AND PortfolioId is NULL
Order  by ValuationDate DESC

--liquibase formatted sql

--changeset system:create-alter-procedure-VaRunWithPortfolioId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRunWithPortfolioId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRunWithPortfolioId
CREATE OR ALTER PROCEDURE dbo.VaRunWithPortfolioId
--VaRunWithPortfolioId

@PortfolioId uniqueidentifier
AS
/*
Declare @PortfolioId as uniqueidentifier
Set @PortfolioId = '603D84FA-E24E-4625-B820-3686451F403C'
*/
Select R.* 
From	VaRun R
Where   SynchronizeTypeNo in (0,1,2)
AND     ValuationStatusNo = 99
AND     ValuationTypeNo = 0
AND     ((RunTypeNo in (0,1,2,99) AND R.PortfolioId Is Null 
	AND (R.PartnerID = (Select POR.PartnerId From ptPortfolio POR Where POR.ID = @PortfolioId) or R.PartnerId is null)) 
	OR  (RunTypeNo = 99	AND	R.PortfolioId = @PortfolioId)) 
Order  by ValuationDate DESC


--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPosSummary context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPosSummary,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPosSummary
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPosSummary

@ConsCreditMonitorId uniqueidentifier

AS

SELECT ConsCreditMonitorId, SeqNo, BalanceDate, SUM(BalanceHoCu) AS BalanceHoCu, SUM(MarketValueHoCu) AS MarketValueHoCu, SUM(PledgedValueHoCu) AS PledgedValueHoCu 
FROM (
	select ConsCreditMonitorId, SeqNo, BalanceDate, BalanceHoCu, MarketValueHoCu, PledgedValueHoCu
	from PtConsCreditAccountDetail
	where ConsCreditMonitorId = @ConsCreditMonitorId 

	union all
	select ConsCreditMonitorId, SeqNo, BalanceDate, BalanceHoCu, MarketValueHoCu, PledgedValueHoCu
	from PtConsCreditSecurities
	where ConsCreditMonitorId = @ConsCreditMonitorId 

	) AS Balance

Group By ConsCreditMonitorId, SeqNo, BalanceDate
Order By ConsCreditMonitorId, SeqNo DESC, BalanceDate DESC

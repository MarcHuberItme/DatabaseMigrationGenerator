--liquibase formatted sql

--changeset system:create-alter-procedure-GetSecurityCostValue_OnATradeDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSecurityCostValue_OnATradeDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSecurityCostValue_OnATradeDate
CREATE OR ALTER PROCEDURE dbo.GetSecurityCostValue_OnATradeDate

@PositionId  uniqueidentifier,
@InputDate datetime

AS

SELECT	PositionId, Quantity,
	AvgValueAcCu as CostValueAcCU, AvgValuePfCu as CostValuePfCu,
	BuyChargesAcCu, BuyChargesPfCu
FROM	PtPosCvHistory
WHERE	PositionId = @PositionId
AND	TradeDate <= @InputDate
AND	NextTradeDate > @InputDate


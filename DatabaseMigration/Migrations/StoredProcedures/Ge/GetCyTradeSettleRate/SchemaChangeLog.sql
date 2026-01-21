--liquibase formatted sql

--changeset system:create-alter-procedure-GetCyTradeSettleRate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCyTradeSettleRate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCyTradeSettleRate
CREATE OR ALTER PROCEDURE dbo.GetCyTradeSettleRate
@TransMessageId UniqueIdentifier, @SettlementCurrency char(3)
AS
Select MarketRateSettlement from CyTrade
where PtTransMessageId = @TransMessageId 
and Status = 3
and SettlementCurrency = @SettlementCurrency

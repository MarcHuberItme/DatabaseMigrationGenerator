--liquibase formatted sql

--changeset system:create-alter-procedure-GetCyTradeSettleRateCustomer context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCyTradeSettleRateCustomer,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCyTradeSettleRateCustomer
CREATE OR ALTER PROCEDURE dbo.GetCyTradeSettleRateCustomer
@TransMessageId UniqueIdentifier, @SettlementCurrency char(3)
AS
Select MarketRateSettlementCustomer from CyTrade
where PtTransMessageId = @TransMessageId 
and Status = 3
and SettlementCurrency = @SettlementCurrency

--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSVaFxRates context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSVaFxRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSVaFxRates
CREATE OR ALTER PROCEDURE dbo.GetPMSVaFxRates
@VaRunId as UniqueIdentifier, @RC int
As
Select top (@RC) AccountCurrency,RatePrCuVaCu,CyBase.TelekursNo,VaCurrencyRate.Id as FxRateValId,PtPMSFxRateTransfer.* from VaCurrencyRate 
inner join CyBase on AccountCurrency = CyBase.Symbol
left outer join PtPMSFxRateTransfer on VaCurrencyRate.ID = PtPMSFxRateTransfer.VaCurrencyRateId
Where ValRunId = @VaRunId
and ValuationCurrency = 'CHF'
and AccountCurrency <> 'CHF'
and RatePrCuVaCu <> 0
and PtPMSFxRateTransfer.VaCurrencyRateId is null
order by AccountCurrency

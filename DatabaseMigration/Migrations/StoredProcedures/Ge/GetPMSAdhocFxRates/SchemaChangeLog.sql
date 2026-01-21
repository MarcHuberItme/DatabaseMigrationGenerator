--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAdhocFxRates context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAdhocFxRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAdhocFxRates
CREATE OR ALTER PROCEDURE dbo.GetPMSAdhocFxRates
@ReferenceDate DateTime
As
Select CySymbolOriginate, CyBase.TelekursNo,  Rate, @ReferenceDate as ReferenceDate from CyRateRecent
inner join CyBase on CySymbolOriginate = CyBase.Symbol
Where @ReferenceDate between ValidFrom and ValidTo
and CyRateRecent.HdVersionNo between 1 and 999999998
and RateType = 203
and CySymbolTarget = 'CHF'
order by CySymbolOriginate

--liquibase formatted sql

--changeset system:create-alter-view-EvDetailChargeView context:any labels:c-any,o-view,ot-schema,on-EvDetailChargeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvDetailChargeView
CREATE OR ALTER VIEW dbo.EvDetailChargeView AS
SELECT TOP 100 PERCENT
    		EDC.Id, 
    		EDC.HdPendingChanges,
    		EDC.HdPendingSubChanges, 
    		EDC.HdVersionNo,
    		EDC.EventDetailId, 
		EDC.ChargeAmountTypeNo,
    		EDC.EventTariffNo, 
    		EDC.ChargeNo, 
    		EDC.ChargeNoForeignDomicile,
    		EDC.Currency, 
		EDC.Amount,
    		EDC.MinAmount,
		EDC.ChargePercentage 
FROM  		EvDetailCharge EDC 
WHERE		EDC.EventTariffNo IS NULL
UNION
SELECT TOP 100 PERCENT
    		EDC.Id, 
    		EDC.HdPendingChanges,
    		EDC.HdPendingSubChanges, 
    		EDC.HdVersionNo,
    		EDC.EventDetailId, 
		2 AS ChargeAmountTypeNo, 
    		EDC.EventTariffNo, 
    		ECE.ChargeNo, 
    		ECE.ChargeNoForeignDomicile,
    		ECE.Currency, 
		NULL AS Amount,
    		ECE.MinAmount,
		ECE.ChargePercentage 
FROM  		EvDetailCharge EDC 
LEFT OUTER JOIN	EvChargeTariff ECE ON ECE.EventTariffNo = EDC.EventTariffNo AND ECE.HdVersionNo < 999999999
WHERE		EDC.EventTariffNo IS NOT NULL


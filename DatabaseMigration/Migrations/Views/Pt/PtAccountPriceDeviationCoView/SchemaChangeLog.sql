--liquibase formatted sql

--changeset system:create-alter-view-PtAccountPriceDeviationCoView context:any labels:c-any,o-view,ot-schema,on-PtAccountPriceDeviationCoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountPriceDeviationCoView
CREATE OR ALTER VIEW dbo.PtAccountPriceDeviationCoView AS
select 
a1.Id,
a1.HdCreateDate, 
a1.HdEditStamp,
a1.HdStatusFlag, 
a1.HdPendingChanges, 
a1.HdPendingSubChanges, 
a1.HdVersionNo,
a1.HdProcessId,
k1.collclean,
a1.AccountBaseId, 
a1.AccountComponentId, 
a1.CreditDeviation, 
a1.ValidFrom, 
a1.ValidTo, 
a1.InterestRate, 
a1.CommissionRate, 
a1.ProvisionRate, 
a1.ReasonType, 
a1.ReasonText, 
a1.IsFixedInterestRate, 
a1.IsStandardPriceDeviation, 
a1.IsAbsolute, 
a1.MinimumRate, 
a1.MaximumRate
from PtAccountPriceDeviation a1,PtAccountbase k1 where 
k1.collclean = 0 and
a1.accountbaseid = k1.id
union all
select 
a2.Id,
a2.HdCreateDate, 
a2.HdEditStamp,
a2.HdStatusFlag, 
a2.HdPendingChanges, 
a2.HdPendingSubChanges, 
a2.HdVersionNo,
a2.HdProcessId,
k2.collclean,
a2.AccountBaseId, 
a2.AccountComponentId, 
a2.CreditDeviation, 
a2.ValidFrom, 
a2.ValidTo, 
a2.InterestRate, 
a2.CommissionRate, 
a2.ProvisionRate, 
a2.ReasonType, 
a2.ReasonText, 
a2.IsFixedInterestRate, 
a2.IsStandardPriceDeviation, 
a2.IsAbsolute, 
a2.MinimumRate, 
a2.MaximumRate
 from CoPtAccountPriceDeviation a2,PtAccountbase k2 where 
k2.collclean = 1 and
a2.accountbaseid = k2.id


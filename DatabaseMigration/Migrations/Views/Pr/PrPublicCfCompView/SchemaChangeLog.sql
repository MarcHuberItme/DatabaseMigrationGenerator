--liquibase formatted sql

--changeset system:create-alter-view-PrPublicCfCompView context:any labels:c-any,o-view,ot-schema,on-PrPublicCfCompView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicCfCompView
CREATE OR ALTER VIEW dbo.PrPublicCfCompView AS
SELECT TOP 100 PERCENT
   CMP.Id,
   CMP.HdCreateDate,
   CMP.HdCreator,
   CMP.HdChangeDate,
   CMP.HdChangeUser,
   CMP.HdEditStamp,
   CMP.HdVersionNo,
   CMP.HdProcessId,
   CMP.HdStatusFlag,
   CMP.HdNoUpdateFlag,
   CMP.HdPendingChanges,
   CMP.HdPendingSubChanges,
   CMP.HdTriggerControl,
   CMP.DefaultCf,
   CST.VdfIdentification,
   CST.CompositionTypeNo,
   CST.SelPeriodStart,
   CST.SelPeriodEnd,
   CST.EntitledPartyNo,
   PCF.Id AS CfId,
   PCF.VdfIdentification AS CfVdfIdentification,
   PCF.PaymentFuncNo,
   PCF.DueDate,
   PCF.NumberUnderlying,
   PCF.CfUnderlTypeNo,
   PCF.PublicUnderlyingId,
   PCF.CfAmountTypeNo,
   PCF.DistributedPublicId,
   PCF.Currency,
   PCF.Amount, 
   PCF.CashFlowStatusNo
FROM PrPublicCfComp CMP LEFT OUTER JOIN
           PrPublicCfSet CST ON CMP.PublicCfSetId = CST.ID LEFT OUTER JOIN
           PrPublicCf PCF ON CMP.PublicCfId = PCF.ID 
UNION
SELECT TOP 100 PERCENT
   RST.Id,
   RST.HdCreateDate,
   RST.HdCreator,
   RST.HdChangeDate,
   RST.HdChangeUser,
   RST.HdEditStamp,
   RST.HdVersionNo,
   RST.HdProcessId,
   RST.HdStatusFlag,
   RST.HdNoUpdateFlag,
   RST.HdPendingChanges,
   RST.HdPendingSubChanges,
   RST.HdTriggerControl,
   NULL AS DefaultCf,
   RST.VdfIdentification,
   RST.CompositionTypeNo,
   RST.SelPeriodStart,
   RST.SelPeriodEnd,
   RST.EntitledPartyNo,
   NULL AS CfId,
   NULL AS CfVdfIdentification,
   NULL AS PaymentFuncNo,
   NULL AS DueDate,
   NULL AS NumberUnderlying,
   NULL AS CfUnderlTypeNo,
   NULL AS PublicUnderlyingId,
   NULL AS CfAmountTypeNo,
   NULL AS DistributedPublicId,
   NULL AS Currency,
   NULL AS Amount,
   NULL AS CashFlowStatusNo
FROM PrPublicCfSet RST 
WHERE RST.ID NOT IN (SELECT PublicCfSetId FROM PrPublicCfComp WHERE PublicCfSetId IS NOT NULL)

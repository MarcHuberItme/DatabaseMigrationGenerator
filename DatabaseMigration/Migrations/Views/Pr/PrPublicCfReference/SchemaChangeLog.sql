--liquibase formatted sql

--changeset system:create-alter-view-PrPublicCfReference context:any labels:c-any,o-view,ot-schema,on-PrPublicCfReference,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicCfReference
CREATE OR ALTER VIEW dbo.PrPublicCfReference AS
SELECT TOP 100 PERCENT
    PCF.Id, 
    PCF.HdPendingChanges,
    PCF.HdPendingSubChanges, 
    PCF.HdVersionNo,
    PCF.PublicId,
    PCF.DueDate,
    PCF.CashFlowFuncNo,
    PCF.PaymentFuncNo,
    PCF.Currency,
    PCF.Amount,
    PCF.CashFlowStatusNo,
    PCF.VdfIdentification,
    REF.MaturityDate,
    REF.InterestRate,
    REF.SpecialKey
FROM  PrPublicCf PCF JOIN
            PrReference REF ON REF.Id  = PCF.ProdReferenceId


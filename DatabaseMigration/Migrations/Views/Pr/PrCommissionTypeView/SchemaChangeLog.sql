--liquibase formatted sql

--changeset system:create-alter-view-PrCommissionTypeView context:any labels:c-any,o-view,ot-schema,on-PrCommissionTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrCommissionTypeView
CREATE OR ALTER VIEW dbo.PrCommissionTypeView AS
SELECT     TOP 100 PERCENT
PrCommissionType.Id,
PrCommissionType.HdCreateDate,
PrCommissionType.HdCreator,
PrCommissionType.HdChangeDate,
PrCommissionType.HdChangeUser,
PrCommissionType.HdEditStamp,
PrCommissionType.HdVersionNo,
PrCommissionType.HdProcessId, 
PrCommissionType.HdStatusFlag,
PrCommissionType.HdNoUpdateFlag,
PrCommissionType.HdPendingChanges,
PrCommissionType.HdPendingSubChanges,
PrCommissionType.HdTriggerControl,
PrCommissionType.CommissionTypeNo,
AsText.TextShort AS Short
FROM         PrCommissionType INNER JOIN
                   AsText ON PrCommissionType.Id = AsText.MasterId
WHERE     (PrCommissionType.IsExpense = 0) AND (AsText.LanguageNo = 2)

--liquibase formatted sql

--changeset system:create-alter-view-MpMarginAdminSelectionView context:any labels:c-any,o-view,ot-schema,on-MpMarginAdminSelectionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MpMarginAdminSelectionView
CREATE OR ALTER VIEW dbo.MpMarginAdminSelectionView AS
Select Id
,HdCreateDate
,HdCreator
,HdChangeDate
,HdChangeUser
,HdEditStamp
,HdVersionNo
,HdProcessId
,HdStatusFlag
,HdNoUpdateFlag
,HdPendingChanges
,HdPendingSubChanges
,HdTriggerControl
,PortfolioId
,PortfolioTypeNo
,StaffRebate
,Symbol
from MpMargin


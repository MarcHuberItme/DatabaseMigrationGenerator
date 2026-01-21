--liquibase formatted sql

--changeset system:create-alter-view-PtTransactionView context:any labels:c-any,o-view,ot-schema,on-PtTransactionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransactionView
CREATE OR ALTER VIEW dbo.PtTransactionView AS

Select TOP 100 PERCENT
PT.Id, 
PT.HdCreateDate, 
PT.HdCreator, 
PT.HdChangeDate, 
PT.HdChangeUser, 
PT.HdEditStamp, 
PT.HdVersionNo, 
PT.HdProcessId, 
PT.HdStatusFlag, 
PT.HdNoUpdateFlag, 
PT.HdPendingChanges, 
PT.HdPendingSubChanges, 
PT.HdTriggerControl, 
PT.TransNo, 
PT.TransTypeNo, 
PT.OrderMediaNo, 
PT.TransDate, 
PT.TransDateTime,
PT.ProcessStatus,
PT.ValueCheck,
PT.RealDate,
PTT.IsEditable
from PtTransaction PT
left outer join PtTransType PTT on PT.TransTypeNo = PTT.TransTypeNo
And PTT.HdVersionNo Between 1 AND 999999998
Order By TransDate Desc

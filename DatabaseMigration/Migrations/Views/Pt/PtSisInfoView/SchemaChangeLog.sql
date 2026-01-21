--liquibase formatted sql

--changeset system:create-alter-view-PtSisInfoView context:any labels:c-any,o-view,ot-schema,on-PtSisInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSisInfoView
CREATE OR ALTER VIEW dbo.PtSisInfoView AS
SELECT 
	PtSISInfo.Id, 
	PtSISInfo.HdPendingChanges, 
	PtSISInfo.HdPendingSubChanges, 
	PtSISInfo.HdVersionNo, 
	PtSISInfo.HdProcessId, 
	PtSISInfo.HdChangeDate, 
	PtSISInfo.HdCreator, 
	PtSISInfo.HdEditStamp, 
	PtSISInfo.HdChangeUser, 
	PtSISInfo.HdCreateDate,
	PtSISInfo.HdCreateDate AS ArrivalDate, 
	PtSISInfo.MessageStdIn, 
	PtSISInfo.MessageTypeIn, 
	PtSISInfo.SubMessageType, 
	PtSISInfo.TransactionRefNumber, 
	PtSISInfo.SecuritiesISIN,
	PtSISInfo.MessageCategory,
	PtSISInfo.TransMessageInId,
	TrMessageType.id As TrMessageTypeId
FROM  
dbo.PtSISInfo,TrMessageType
Where 
dbo.PtSISInfo.MessageTypeIn = TrMessageType.Code And PtSisInfo.SubMessageType = TrMessageType.SubMessageTypeCode

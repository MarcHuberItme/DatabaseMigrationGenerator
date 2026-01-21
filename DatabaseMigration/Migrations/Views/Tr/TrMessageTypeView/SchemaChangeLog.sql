--liquibase formatted sql

--changeset system:create-alter-view-TrMessageTypeView context:any labels:c-any,o-view,ot-schema,on-TrMessageTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TrMessageTypeView
CREATE OR ALTER VIEW dbo.TrMessageTypeView AS
SELECT PtSISInfo.Id, PtSISInfo.HdPendingChanges, PtSISInfo.HdPendingSubChanges, PtSISInfo.HdVersionNo, PtSISInfo.HdProcessId, 
               PtSISInfo.HdChangeDate, PtSISInfo.HdCreator, PtSISInfo.HdEditStamp, PtSISInfo.HdChangeUser, PtSISInfo.HdCreateDate, 
               PtSISInfo.HdCreateDate AS ArrivalDate, PtSISInfo.MessageStdIn, PtSISInfo.MessageTypeIn, PtSISInfo.SubMessageType, 
               PtSISInfo.TransactionRefNumber, PtSISInfo.SecuritiesISIN, PtSISInfo.MessageCategory, PtSISInfo.TransMessageInId, 
               TrMessageType.Id AS TrMessageTypeId,Code, SubMessageTypeCode
FROM  PtSISInfo LEFT OUTER JOIN
               TrMessageType ON PtSISInfo.MessageTypeIn = TrMessageType.Code AND PtSISInfo.SubMessageType = TrMessageType.SubMessageTypeCode

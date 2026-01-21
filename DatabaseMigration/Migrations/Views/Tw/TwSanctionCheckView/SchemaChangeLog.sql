--liquibase formatted sql

--changeset system:create-alter-view-TwSanctionCheckView context:any labels:c-any,o-view,ot-schema,on-TwSanctionCheckView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TwSanctionCheckView
CREATE OR ALTER VIEW dbo.TwSanctionCheckView AS
SELECT 
TOP 100 Percent 
ResponseMsg.ID, 
ResponseMsg.HdCreateDate,
ResponseMsg.HdCreator,
ResponseMsg.HdChangeDate,
ResponseMsg.HdChangeUser,
ResponseMsg.HdEditStamp,
ResponseMsg.HdVersionNo,
ResponseMsg.HdProcessId,
ResponseMsg.HdNoUpdateFlag,
ResponseMsg.HdPendingChanges, Msg.HdPendingSubChanges, Msg.HdStatusFlag, Msg.HdTriggerControl,
ResponseMsg.AuthorizationStatusType, ResponseMsg.KYCCheckResult, TransDetail.PeerName, 
ptBase.Name as PartnerName, ptBase.FirstName as PartnerFirstName, Msg.RequestedAmount, Msg.CustomerInformationText, Msg.Iban
, ResponseMsg.Comment, Msg.AuthorizationTimeStamp
FROM TwReqAuthResponseMessage ResponseMsg

INNER JOIN TwReqAuthMessage Msg on ResponseMsg.AuthorizationId = msg.AuthorizationId

INNER JOIN TwReqAuthP2PTransDetailMessage TransDetail on Msg.id = TransDetail.ReqAuthMessageId

INNER JOIN TwContract on TwContract.PrivateCustomerId = Msg.PrivateCustomerId

INNER JOIN PtBase on PtBase.id = TwContract.PartnerId





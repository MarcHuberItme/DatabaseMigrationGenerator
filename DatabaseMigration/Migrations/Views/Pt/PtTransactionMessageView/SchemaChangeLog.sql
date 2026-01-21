--liquibase formatted sql

--changeset system:create-alter-view-PtTransactionMessageView context:any labels:c-any,o-view,ot-schema,on-PtTransactionMessageView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransactionMessageView
CREATE OR ALTER VIEW dbo.PtTransactionMessageView AS
SELECT 	TMS.Id, 
	TMS.HdPendingChanges,
	TMS.HdPendingSubChanges, 
	TMS.HdVersionNo,
	TSA.TransNo, 
	TMS.MsgSequenceNumber,
	CAST(TSA.TransNo AS VARCHAR) + 
	IsNull(', ' + CAST(TMS.MsgSequenceNumber AS VARCHAR), '')
		AS TransMsgDescription
FROM	PtTransaction TSA
JOIN	PtTransMessage TMS ON TMS.TransactionID = TSA.Id

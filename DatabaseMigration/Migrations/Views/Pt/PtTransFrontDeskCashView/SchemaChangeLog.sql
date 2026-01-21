--liquibase formatted sql

--changeset system:create-alter-view-PtTransFrontDeskCashView context:any labels:c-any,o-view,ot-schema,on-PtTransFrontDeskCashView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransFrontDeskCashView
CREATE OR ALTER VIEW dbo.PtTransFrontDeskCashView AS
SELECT TOP 1
	Id,
	HdCreateDate,
	HdCreator,
	HdChangeDate,
	HdChangeUser,
	HdEditStamp,
	HdVersionNo,
	HdProcessId,
	HdStatusFlag,
	HdNoUpdateFlag,
	HdPendingChanges,
	HdPendingSubChanges,
	HdTriggerControl,
	TransactionId,
	DebitPrReferenceId,
	CreditPrReferenceId,
	DebitValueDate,
	CreditValueDate,
	PaymentAmount,
	PaymentCurrency,
	CardBaseId,
	TransText,
	TransRemark,
                DebitTextNo,
                CreditTextNo,
                ProxyThirdPerson,
                IsDueRelevant,
                MatchingCode
From 
	PtTransMessage

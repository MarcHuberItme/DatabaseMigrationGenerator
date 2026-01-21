--liquibase formatted sql

--changeset system:create-alter-view-PtTransFrontDeskChangeView context:any labels:c-any,o-view,ot-schema,on-PtTransFrontDeskChangeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransFrontDeskChangeView
CREATE OR ALTER VIEW dbo.PtTransFrontDeskChangeView AS
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
--	CreditPrReferenceId,
--	DebitPrReferenceId,
	ISNULL(DebitValueDate, CreditValueDate) as ValueDate,
--	DebitAmount,
--	DebitAccountCurrency,
--	CreditAmount,
--	CreditAccountCurrency,
	PaymentAmount,
	PaymentCurrency,
	ISNULL(DebitAmount,CreditAmount) As ChangeAmount,
	ISNULL(DebitAccountCurrency,CreditAccountCurrency) As ChangeCurrency,
	TransText,
	TransRemark
From 
	PtTransMessage

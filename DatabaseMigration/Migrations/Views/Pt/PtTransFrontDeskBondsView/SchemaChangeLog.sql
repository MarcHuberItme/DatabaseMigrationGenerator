--liquibase formatted sql

--changeset system:create-alter-view-PtTransFrontDeskBondsView context:any labels:c-any,o-view,ot-schema,on-PtTransFrontDeskBondsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransFrontDeskBondsView
CREATE OR ALTER VIEW dbo.PtTransFrontDeskBondsView AS
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
	PaymentDate as TransDate,
	DebitPrReferenceId,
	CreditPortfolioId,
	ISNULL(DebitValueDate,CreditValueDate) As ValueDate,
	PaymentAmount,
	PaymentCurrency,
	DebitAmount,
	CreditAmount,
	TransText,
	TransRemark
From 
	PtTransMessage

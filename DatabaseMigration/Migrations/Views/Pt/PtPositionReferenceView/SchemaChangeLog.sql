--liquibase formatted sql

--changeset system:create-alter-view-PtPositionReferenceView context:any labels:c-any,o-view,ot-schema,on-PtPositionReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionReferenceView
CREATE OR ALTER VIEW dbo.PtPositionReferenceView AS
SELECT
	dbo.PtPosition.Id, 
	dbo.PtPosition.HdProcessId,
	dbo.PtPosition.HdVersionNo, 
	dbo.PtPosition.HdCreateDate,
	dbo.PtPosition.HdPendingChanges, 
	dbo.PtPosition.HdPendingSubChanges, 
	dbo.PtPosition.HdEditStamp, 
	dbo.PtPosition.PortfolioId, 
	dbo.PtPosition.ProdReferenceId, 
	dbo.PtPosition.ProdLocGroupId, 
	dbo.PtPosition.Quantity, 
	dbo.PtPosition.ValueProductCurrency, 
	dbo.PtPosition.ValueCustomerCurrency, 
	dbo.PtPosition.ValueBasicCurrency, 
	dbo.PtPosition.ValueBasicCurrencyCollateral, 
	dbo.PtPosition.NostroTypeId, 
	dbo.PtPosition.BookletPrintDate, 
	dbo.PtPosition.BookletPage, 
	dbo.PtPosition.BookletLine, 
	dbo.PtPosition.BookletBalance, 
	dbo.PtPosition.Agent, 
	dbo.PtAccountReferenceView.AdviceAdrLine,
	dbo.PtAccountReferenceView.DateOfBirth,
	dbo.PtAccountReferenceView.AccountNo
FROM
	dbo.PtPosition LEFT OUTER JOIN
	dbo.PtAccountReferenceView ON dbo.PtPosition.ProdReferenceId = dbo.PtAccountReferenceView.Id

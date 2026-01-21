--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemEbView context:any labels:c-any,o-view,ot-schema,on-PtTransItemEbView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemEbView
CREATE OR ALTER VIEW dbo.PtTransItemEbView AS
SELECT  I.Id,
 	I.HdCreateDate,
	I.HdVersionNo, 
	I.HdPendingSubChanges, 
	I.HdPendingChanges, 
	I.TransId, 
	I.PositionId, 
	I.SourcePositionId, 
	I.GroupKey, 
	I.DetailCounter, 
	I.TransDate, 
	I.ValueDate, 
	I.DebitQuantity,
	I.DebitAmount, 
	I.CreditQuantity,
	I.CreditAmount, 
	I.TextNo, 
	I.MessageId, 
	I.ServiceCenterNo, 
	I.TransText, 
	I.AdvicePrinted, 
	I.CompletionDate, 
	I.BookletPrintDate, 
	I.BookletPageNo, 
	I.BookletLineNo, 
	R.AccountId, 
	R.Currency, 
	P.ProdReferenceId,
	A.AccountNo,
	A.CustomerReference,
	P.PortfolioId,
	X.TextShort,
	X.TextLong,
	X.LanguageNo
FROM
	PtTransItem I
	INNER JOIN PtPosition P ON I.PositionId = P.Id 
	INNER JOIN PrReference R ON P.ProdReferenceId = R.Id
	INNER JOIN PtAccountBase B ON R.AccountId = B.Id
	LEFT OUTER JOIN PtAccountBase A ON R.AccountId = A.Id
	LEFT OUTER JOIN PtTransItemText T ON I.TextNo = T.TextNo
	LEFT OUTER JOIN AsText X ON T.Id = X.MasterId
WHERE
	X.MasterTableName = 'PtTransItemText'
      AND I.HdVersionNo between 1 and 999999998

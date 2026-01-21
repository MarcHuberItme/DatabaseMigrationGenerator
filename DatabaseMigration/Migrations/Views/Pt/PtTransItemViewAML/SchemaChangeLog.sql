--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemViewAML context:any labels:c-any,o-view,ot-schema,on-PtTransItemViewAML,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemViewAML
CREATE OR ALTER VIEW dbo.PtTransItemViewAML AS

Select
              PtTransItemFull.Id, 
	PtTransItemFull.HdCreateDate, 
	PtTransItemFull.HdCreator, 
	PtTransItemFull.HdChangeDate, 
	PtTransItemFull.HdChangeUser, 
	PtTransItemFull.HdEditStamp, 
	PtTransItemFull.HdVersionNo, 
	PtTransItemFull.HdProcessId, 
	PtTransItemFull.HdStatusFlag, 
	PtTransItemFull.HdNoUpdateFlag, 
	PtTransItemFull.HdPendingChanges, 
	PtTransItemFull.HdPendingSubChanges, 
	PtTransItemFull.HdTriggerControl, 
	PtTransItemFull.TransDate, 
	PtTransItemFull.ValueDate, 
	PtTransItemFull.DebitQuantity,
	PtTransItemFull.DebitAmount, 
	PtTransItemFull.CreditQuantity,
	PtTransItemFull.CreditAmount, 
	PtTransItemFull.TextNo, 
	PtTransItemFull.TransText, 
	PrReference.Currency, 
	PtAccountBase.CustomerReference,
	PtPortfolioView.Name,
	PtPortfolioView.PartnerNoEdited,
        PtPortfolioView.FirstName,
	PtAccountBase.AccountNoEdited,
	PtPortfolioView.PortfolioNoEdited,
                CAST(PtTransItemFull.TransDate AS nvarchar(12)) + ' /  ' + 
                CAST(PtTransItemFull.CreditAmount + PtTransItemFull.DebitAmount AS nvarchar(14)) + ' / ' + 
                PtAccountBase.AccountNoEdited + '  ' + ISNULL(PtTransItemFull.TransText + ' ', '') AS ItemDescription
FROM
	PtTransItemFull 
INNER JOIN PtPosition ON PtTransItemFull.PositionId = PtPosition.Id 
INNER JOIN PrReference ON PtPosition.ProdReferenceId = PrReference.Id
inner  JOIN PtPortfolioView ON PtPosition.PortfolioId = PtPortfolioView.Id
LEFT OUTER JOIN PtAccountBase ON PrReference.AccountId = PtAccountBase.Id


--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAdjustmentPostingView context:any labels:c-any,o-view,ot-schema,on-PtAccountAdjustmentPostingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAdjustmentPostingView
CREATE OR ALTER VIEW dbo.PtAccountAdjustmentPostingView AS

SELECT TOP 100 PERCENT
Aap.Id, Aap.HdCreator, Aap.HdChangeUser, Aap.HdCreateDate, Aap.HdChangeDate, Aap.HdEditStamp, Aap.HdPendingChanges, Aap.HdPendingSubChanges, Aap.HdProcessId, Aap.HdVersionNo,
Aap.PostingDate, Acc.AccountNoEdited, Pt.PtDescription, Aap.InterestAmountHoCu, Aap.LoanChargeAmountHoCu, Aap.ExpenseAmountHoCu, Aap.AccountId, Acc.AccountNo
FROM PtAccountAdjustmentPosting AS Aap
INNER JOIN PtAccountBase AS Acc ON Aap.AccountId = Acc.Id
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PtDescriptionView AS Pt ON Pf.PartnerId = Pt.Id

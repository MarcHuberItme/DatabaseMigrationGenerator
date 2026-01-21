--liquibase formatted sql

--changeset system:create-alter-view-PtAccountInterestRecoveryView context:any labels:c-any,o-view,ot-schema,on-PtAccountInterestRecoveryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountInterestRecoveryView
CREATE OR ALTER VIEW dbo.PtAccountInterestRecoveryView AS

SELECT TOP 100 PERCENT
Aap.Id, Aap.HdCreator, Aap.HdChangeUser, Aap.HdCreateDate, Aap.HdChangeDate, Aap.HdEditStamp, Aap.HdPendingChanges, Aap.HdPendingSubChanges, Aap.HdProcessId, Aap.HdVersionNo,
Aap.ClosingDate, Acc.AccountNoEdited, Pt.PtDescription, Aap.InterestAmountHoCu, Aap.AccountId, Acc.AccountNo
FROM PtAccountInterestRecovery AS Aap
INNER JOIN PtAccountBase AS Acc ON Aap.AccountId = Acc.Id
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PtDescriptionView AS Pt ON Pf.PartnerId = Pt.Id

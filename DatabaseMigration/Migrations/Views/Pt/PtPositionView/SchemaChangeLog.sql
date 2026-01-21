--liquibase formatted sql

--changeset system:create-alter-view-PtPositionView context:any labels:c-any,o-view,ot-schema,on-PtPositionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionView
CREATE OR ALTER VIEW dbo.PtPositionView AS
SELECT     
     PtPosition.Id, 
     PtPosition.HdCreateDate, 
     PtPosition.HdCreator, 
     PtPosition.HdChangeDate, 
     PtPosition.HdChangeUser,
     PtPosition.HdEditStamp,
     PtPosition.HdVersionNo,
     PtPosition.HdProcessId, 
     PtPosition.HdStatusFlag,
     PtPosition.HdNoUpdateFlag, PtPosition.HdPendingChanges, 
     PtPosition.HdPendingSubChanges, PtPosition.HdTriggerControl,      PtPosition.PortfolioId,
     PtPosition.ProdReferenceId, PtPosition.ProdLocGroupId,      
     PrReference.AccountId,      PtAccountBase.AccountNoText, 
     PtAccountBase.AccountNo, PtAccountBase.AccountNoEdited,      PrReference.Currency, PtPortfolio.PartnerId, 
     PtPortfolio.PortfolioNo, PtPortfolio.PortfolioNoText,      PtPortfolio.PortfolioNoEdited, PtBase.PartnerNoText, 
     PtBase.PartnerNo, PtBase.PartnerNoEdited, PtBase.FirstName,      PtBase.MiddleName, 
     PtBase.Name
FROM
     PtPosition INNER JOIN
     PrReference ON PtPosition.ProdReferenceId = PrReference.Id INNER JOIN
     PtAccountBase ON PrReference.AccountId = PtAccountBase.Id INNER JOIN
     PtPortfolio ON PtPosition.PortfolioId = PtPortfolio.Id AND 
     PtAccountBase.PortfolioId = PtPortfolio.Id INNER JOIN
     PtBase ON PtPortfolio.PartnerId = PtBase.Id


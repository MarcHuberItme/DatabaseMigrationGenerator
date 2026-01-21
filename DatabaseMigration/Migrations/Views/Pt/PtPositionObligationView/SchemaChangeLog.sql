--liquibase formatted sql

--changeset system:create-alter-view-PtPositionObligationView context:any labels:c-any,o-view,ot-schema,on-PtPositionObligationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionObligationView
CREATE OR ALTER VIEW dbo.PtPositionObligationView AS
SELECT     dbo.PtPosition.Id, dbo.PtPosition.HdCreateDate, dbo.PtPosition.HdCreator, dbo.PtPosition.HdChangeDate, dbo.PtPosition.HdChangeUser, 
                      dbo.PtPosition.HdEditStamp, dbo.PtPosition.HdVersionNo, dbo.PtPosition.HdProcessId, dbo.PtPosition.HdStatusFlag, dbo.PtPosition.HdNoUpdateFlag, 
                      dbo.PtPosition.HdPendingChanges, dbo.PtPosition.HdPendingSubChanges, dbo.PtPosition.HdTriggerControl, dbo.PtPosition.PortfolioId, 
                      dbo.PtPosition.ProdReferenceId, dbo.PrReference.AccountId, dbo.PtAccountBase.AccountNoText, dbo.PtAccountBase.AccountNo, 
                      dbo.PtAccountBase.AccountNoEdited, dbo.PrReference.Currency, dbo.PtPortfolio.PartnerId, dbo.PtPortfolio.PortfolioNo, dbo.PtPortfolio.PortfolioNoText, 
                      dbo.PtPortfolio.PortfolioNoEdited, dbo.PtBase.PartnerNoText, dbo.PtBase.PartnerNo, dbo.PtBase.PartnerNoEdited, dbo.PtBase.FirstName, 
                      dbo.PtBase.MiddleName, dbo.PtBase.Name, dbo.ReObligation.Currency AS ObligCurrency, dbo.ReObligation.ObligAmount, dbo.RePremises.GBNoAdd, 
                      dbo.RePremises.GBPlanNo, dbo.RePremises.Designation, dbo.RePremises.ReBaseId, dbo.RePremises.GBNo
FROM         dbo.ReObligPremisesRelation INNER JOIN
                      dbo.ReObligation ON dbo.ReObligPremisesRelation.ObligationId = dbo.ReObligation.Id INNER JOIN
                      dbo.RePremises ON dbo.ReObligPremisesRelation.PremisesId = dbo.RePremises.Id RIGHT OUTER JOIN
                      dbo.PtPosition INNER JOIN
                      dbo.PrReference ON dbo.PtPosition.ProdReferenceId = dbo.PrReference.Id INNER JOIN
                      dbo.PtAccountBase ON dbo.PrReference.AccountId = dbo.PtAccountBase.Id INNER JOIN
                      dbo.PtPortfolio ON dbo.PtPosition.PortfolioId = dbo.PtPortfolio.Id AND dbo.PtAccountBase.PortfolioId = dbo.PtPortfolio.Id INNER JOIN
                      dbo.PtBase ON dbo.PtPortfolio.PartnerId = dbo.PtBase.Id ON dbo.ReObligation.Id = dbo.PrReference.ObligationId

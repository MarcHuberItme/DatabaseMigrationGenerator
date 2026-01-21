--liquibase formatted sql

--changeset system:create-alter-view-PtAgrSecPosPremisesView context:any labels:c-any,o-view,ot-schema,on-PtAgrSecPosPremisesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrSecPosPremisesView
CREATE OR ALTER VIEW dbo.PtAgrSecPosPremisesView AS
SELECT     dbo.PtDescriptionView.PartnerNoEdited, dbo.PtDescriptionView.FirstName, dbo.PtDescriptionView.Name, dbo.PtAccountComposedPrice.ValidFrom, 
                      dbo.PtAccountComposedPrice.ValidTo, dbo.PtAccountComposedPrice.InterestRate, dbo.PtAccountComposedPrice.[Value], dbo.PtAgrSecurity.AgrTypeNo, 
                      PtPositionObligationView_2.PortfolioNoEdited AS [Agr Portfolio No], PtPositionObligationView_2.GBNoAdd AS [Agr Portfolio GBNo Add], 
                      PtPositionObligationView_2.GBPlanNo AS [Agr Portfolio GBPlanNo], PtPositionObligationView_2.Designation AS [Agr Portfolio Designation], 
                      PtPositionObligationView_2.ObligAmount AS [Agr Portfolio Amount], PtPositionObligationView_1.ObligAmount AS [Agr Position Amount], 
                      PtPositionObligationView_1.GBNoAdd AS [Agr Position GBNoAdd], PtPositionObligationView_1.GBPlanNo AS [Agr Postition GBPlanNo], 
                      PtPositionObligationView_1.Designation AS [Agr Postion Designation], PtPositionObligationView_1.ReBaseId AS [Position Base], 
                      PtPositionObligationView_2.ReBaseId AS [Portfolio Base], PtPositionObligationView_2.ReBaseId AS [Partner Base], 
                      PtPositionObligationView_2.Designation AS [Partner Designation], PtPositionObligationView_2.GBPlanNo AS [Partner GBPlanNo], 
                      PtPositionObligationView_2.GBNoAdd AS [Partner GBNoAdd], PtPositionObligationView_2.GBNo AS [Partner GBNo], 
                      PtPositionObligationView_1.GBNo AS [Position GBNo], PtPositionObligationView_3.GBNo AS [Portfolio GBNo], 
                      PtPositionObligationView_3.ReBaseId AS [Portfolio BaseId], PtPositionObligationView_3.Designation AS [Portfolio Designation], 
                      PtPositionObligationView_3.GBPlanNo AS [Portfolio GBPlanNo], PtPositionObligationView_3.GBNoAdd AS [Portfolio GBNoAdd], 
                      PtPositionObligationView_3.ObligAmount AS [Portfolio Amount]
FROM         dbo.PtAgrSecurity INNER JOIN
                      dbo.PtAccountCompSecurity ON dbo.PtAgrSecurity.Id = dbo.PtAccountCompSecurity.AgrSecurityId INNER JOIN
                      dbo.PtAccountComposedPrice ON dbo.PtAccountCompSecurity.AccountCompId = dbo.PtAccountComposedPrice.AccountComponentId INNER JOIN
                      dbo.PtDescriptionView ON dbo.PtAgrSecurity.PartnerId = dbo.PtDescriptionView.Id INNER JOIN
                      dbo.PtAgrSecurityPosition ON dbo.PtAgrSecurity.Id = dbo.PtAgrSecurityPosition.SecurityVersionId LEFT OUTER JOIN
                      dbo.PtPositionObligationView PtPositionObligationView_2 ON 
                      dbo.PtAgrSecurityPosition.PartnerId = PtPositionObligationView_2.PartnerId LEFT OUTER JOIN
                      dbo.PtPositionObligationView PtPositionObligationView_1 ON dbo.PtAgrSecurityPosition.PositionId = PtPositionObligationView_1.Id LEFT OUTER JOIN
                      dbo.PtPositionObligationView PtPositionObligationView_3 ON dbo.PtAgrSecurityPosition.PortfolioId = PtPositionObligationView_3.PortfolioId

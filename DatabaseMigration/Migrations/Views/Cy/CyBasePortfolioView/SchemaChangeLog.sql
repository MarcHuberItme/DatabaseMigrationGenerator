--liquibase formatted sql

--changeset system:create-alter-view-CyBasePortfolioView context:any labels:c-any,o-view,ot-schema,on-CyBasePortfolioView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CyBasePortfolioView
CREATE OR ALTER VIEW dbo.CyBasePortfolioView AS
SELECT 
 CyBase.Id,
 CyBase.Symbol as Symbol_Iso4217,
 AsText.TextShort,
 AsText.LanguageNo FROM CyBase 
 JOIN AsText ON CyBase.Id = AsText.MasterId
 WHERE CyBase.HdVersionNo > 0 AND CyBase.HdVersionNo < 999999999 AND CyBase.PortfolioAcceptance='1'


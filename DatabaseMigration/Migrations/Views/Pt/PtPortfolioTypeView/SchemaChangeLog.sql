--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioTypeView context:any labels:c-any,o-view,ot-schema,on-PtPortfolioTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioTypeView
CREATE OR ALTER VIEW dbo.PtPortfolioTypeView AS
SELECT 
PtPortfolioType.Id,
PtPortfolioType.PortfolioTypeNo,
AsText.TextShort,
AsText.LanguageNo,
AsGroupView.GroupLabel
FROM PtPortfolioType  
LEFT JOIN AsGroupView on PtPortfolioType.Id = AsGroupView.GroupMemberTargetRowId
LEFT JOIN AsText on PtPortfolioType.Id = AsText.MasterId
WHERE AsGroupView.GroupTypeLabel = 'Portfolio Classes' AND PtPortfolioType.HdVersionNo<999999999 AND PtPortfolioType.HdVersionNo > 0

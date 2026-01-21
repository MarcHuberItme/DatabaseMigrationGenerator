--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioViewNoPL context:any labels:c-any,o-view,ot-schema,on-PtPortfolioViewNoPL,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioViewNoPL
CREATE OR ALTER VIEW dbo.PtPortfolioViewNoPL AS
SELECT TOP 100 PERCENT * FROM PtPortfolioView

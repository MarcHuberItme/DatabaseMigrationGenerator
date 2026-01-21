--liquibase formatted sql

--changeset system:create-alter-view-PtCorrPortfolioViewLang context:any labels:c-any,o-view,ot-schema,on-PtCorrPortfolioViewLang,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrPortfolioViewLang
CREATE OR ALTER VIEW dbo.PtCorrPortfolioViewLang AS
SELECT TOP 100 PERCENT
	 cor.*, adr.CorrespondenceLanguageNo As CorrLanguageNo
FROM PtCorrPortfolioView AS cor
   JOIN PtAddress adr on adr.Id = cor.AddressId



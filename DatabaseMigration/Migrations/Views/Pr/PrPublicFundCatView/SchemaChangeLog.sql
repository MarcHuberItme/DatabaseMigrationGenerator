--liquibase formatted sql

--changeset system:create-alter-view-PrPublicFundCatView context:any labels:c-any,o-view,ot-schema,on-PrPublicFundCatView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicFundCatView
CREATE OR ALTER VIEW dbo.PrPublicFundCatView AS
SELECT 		TOP 100 PERCENT
    		PFC.Id, 
    		PFC.HdPendingChanges,
    		PFC.HdPendingSubChanges, 
    		PFC.HdVersionNo,
		PFC.FundCatSchemeCode, 
		PFC.FundCatCode,
		ALA.LanguageNo,
		FundCatSchemeCode + ' - ' + PFC.FundCatCode + ISNULL(' - ' + AST1.TextShort, '') AS FundCatDescription,
		AST1.TextShort
FROM 		PrPublicFundCat PFC
CROSS JOIN 	AsLanguage ALA
LEFT OUTER JOIN	AsText AST1 ON PFC.Id  = AST1.MasterId AND AST1.LanguageNo = ALA.LanguageNo
WHERE 		ALA.UserDialog = 1

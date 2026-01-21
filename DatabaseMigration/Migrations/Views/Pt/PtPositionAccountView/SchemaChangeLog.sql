--liquibase formatted sql

--changeset system:create-alter-view-PtPositionAccountView context:any labels:c-any,o-view,ot-schema,on-PtPositionAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionAccountView
CREATE OR ALTER VIEW dbo.PtPositionAccountView AS
SELECT TOP 100 PERCENT
    	POS.Id, 
    	POS.HdPendingChanges,
    	POS.HdPendingSubChanges, 
    	POS.HdVersionNo,
	ACC.AccountNoEdited,
	REF.Currency, 
	PRI.ProductNo,
	ALA.LanguageNo,
	ACC.AccountNoEdited + ' ' + IsNull(AT.TextShort + ' ','') + REF.Currency AS AccountDesc
FROM	PtPosition POS 
JOIN   	PrReference REF ON POS.ProdReferenceId = REF.Id 
JOIN   	PtAccountBase ACC ON REF.AccountId = ACC.Id 
JOIN	PrPrivate PRI ON REF.ProductId = PRI.ProductId
CROSS JOIN AsLanguage ALA
LEFT OUTER JOIN AsText AT ON AT.MasterId = PRI.Id AND AT.LanguageNo = ALA.LanguageNo
WHERE ALA.UserDialog = 1 OR ALA.CustomerOutput = 1 

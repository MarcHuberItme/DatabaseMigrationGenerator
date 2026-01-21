--liquibase formatted sql

--changeset system:create-alter-view-PrPublicInternalTextView context:any labels:c-any,o-view,ot-schema,on-PrPublicInternalTextView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicInternalTextView
CREATE OR ALTER VIEW dbo.PrPublicInternalTextView AS
SELECT		PUB.Id AS PublicId, PUB.IsinNo, PUB.VdfInstrumentSymbol, AL.LanguageNo, PTE.ShortName, PUB.ProductId
FROM		PrPublic PUB
CROSS JOIN	AsLanguage AL 
LEFT OUTER JOIN	PrPublicText PTE ON PTE.PublicId = PUB.Id AND PTE.HdVersionNo < 999999999
		AND PTE.LanguageNo = AL.LanguageNo
WHERE 		AL.HdVersionNo < 999999999 AND (AL.UserDialog = 1 OR CustomerOutput = 1)

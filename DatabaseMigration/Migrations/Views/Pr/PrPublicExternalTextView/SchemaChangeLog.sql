--liquibase formatted sql

--changeset system:create-alter-view-PrPublicExternalTextView context:any labels:c-any,o-view,ot-schema,on-PrPublicExternalTextView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicExternalTextView
CREATE OR ALTER VIEW dbo.PrPublicExternalTextView AS
SELECT		PUB.Id AS PublicId, PUB.IsinNo, PUB.VdfInstrumentSymbol, AL.LanguageNo, 
		PTE.Interest, PTE.Preffix, PTE.ValidityRange, PTE.Suffix,  PIT.Name
FROM		PrPublic PUB
CROSS JOIN	AsLanguage AL 
LEFT OUTER JOIN	PrPublicText PTE ON PTE.PublicId = PUB.Id AND PTE.HdVersionNo < 999999999
		AND PTE.LanguageNo = AL.LanguageNo
LEFT OUTER JOIN	PtInstituteName PIT ON PIT.PartnerId = PUB.NamingPartnerId AND PIT.HdVersionNo < 999999999
		AND PIT.LanguageNo = AL.LanguageNo
WHERE 		AL.HdVersionNo < 999999999 AND (AL.UserDialog = 1 OR CustomerOutput = 1)

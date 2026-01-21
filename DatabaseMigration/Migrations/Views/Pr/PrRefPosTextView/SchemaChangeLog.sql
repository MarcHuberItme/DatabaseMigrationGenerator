--liquibase formatted sql

--changeset system:create-alter-view-PrRefPosTextView context:any labels:c-any,o-view,ot-schema,on-PrRefPosTextView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrRefPosTextView
CREATE OR ALTER VIEW dbo.PrRefPosTextView AS
SELECT TOP 100 PERCENT
    REF.Id, 
    REF.HdPendingChanges,
    REF.HdPendingSubChanges, 
    REF.HdVersionNo,
    PUB.IsinNo 
	+ IsNull(' ' + PTE.ShortName, '') 
	+ IsNull(' / ' + CONVERT(VARCHAR, REF.InterestRate) + ' % ', '')
	+ IsNull(' / ' + CONVERT(VARCHAR, REF.MaturityDate, 104), '') 
	+ IsNull(' / ' + REF.SpecialKey, '')
	+ IsNull(' / ' + CONVERT(VARCHAR, OBT.ObjectSeqNo), '') 
	+ IsNull(' / ' + CONVERT(VARCHAR, POL.ObjectSeqNo), '') 
	+ IsNull(' / ' + CONVERT(VARCHAR, OBL.ObjectSeqNo), '') 
	AS PosDescription,
    ALA.LanguageNo
FROM PrReference REF
JOIN PrPublic PUB ON PUB.ProductId = REF.ProductId
CROSS JOIN AsLanguage ALA
LEFT OUTER JOIN PrPublicText PTE ON PUB.Id  = PTE.PublicId AND PTE.LanguageNo = ALA.LanguageNo
LEFT OUTER JOIN PrObject OBT ON OBT.Id  = REF.ObjectId
LEFT OUTER JOIN PrInsurancePolice POL ON POL.Id  = REF.InsurancePoliceId
LEFT OUTER JOIN ReObligation OBL ON OBL.Id  = REF.ObligationId
WHERE ALA.UserDialog = 1
UNION
SELECT TOP 100 PERCENT
    REF.Id, 
    REF.HdPendingChanges,
    REF.HdPendingSubChanges, 
    REF.HdVersionNo,
    ACC.AccountNoEdited 
	+ IsNull(' ' + AST.TextShort, '') 
	+ IsNull(' ' + ACC.CustomerReference, '') 
	AS PosDescription, 
    ALA.LanguageNo
FROM PrReference REF
JOIN PtAccountBase ACC ON ACC.Id = REF.AccountId
CROSS JOIN AsLanguage ALA
JOIN PrPrivate PRV ON PRV.ProductId = REF.ProductId
LEFT OUTER JOIN AsText AST ON PRV.Id  = AST.MasterId AND AST.LanguageNo = ALA.LanguageNo
WHERE ALA.UserDialog = 1

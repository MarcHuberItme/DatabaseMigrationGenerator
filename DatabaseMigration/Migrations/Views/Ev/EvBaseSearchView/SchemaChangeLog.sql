--liquibase formatted sql

--changeset system:create-alter-view-EvBaseSearchView context:any labels:c-any,o-view,ot-schema,on-EvBaseSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvBaseSearchView
CREATE OR ALTER VIEW dbo.EvBaseSearchView AS
SELECT TOP 100 PERCENT
    EVB.Id, 
    EVB.HdPendingChanges,
    EVB.HdPendingSubChanges, 
    EVB.HdVersionNo,
    EVB.EventNo,
    EVB.PublicId,
    EVB.ProdReferenceId, 
    IsNull(Convert(varchar,REF.InterestRate) + ' % ', '') 
    + IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')  
    + IsNull(REF.SpecialKey,'') AS ReferenceData,      
    EVB.EventStatusNo,
    EVB.EffectiveDate,
    EVB.EventTypeNo,
    EVB.EventPosApplyNo,
    EVB.CanceledEventId, 
    EVA.PaymentCurrency,
    PUB.IsinNo + IsNull(' ' + PTE.ShortName, '') as PublicDescription,
    ALA.LanguageNo,
    PUB.RefTypeNo, 
    IsNull(CF.VdfIdentification, IsNull(CST.VdfIdentification, IsNull(TRF.VdfIdentification, IsNull(POM.VdfIdentification, '')))) AS VdfIdentification
FROM EvBase EVB
JOIN PrPublic PUB ON PUB.Id = EVB.PublicId
LEFT OUTER JOIN	EvVariant EVA ON EVA.EventId = EVB.Id AND EVA.VariantNo = 1
LEFT OUTER JOIN	PrReference REF ON REF.Id = EVB.ProdReferenceId
LEFT OUTER JOIN PrPublicCf CF ON CF.Id = EVB.PublicCfId
LEFT OUTER JOIN PrPublicCfSet CST ON CST.Id = EVB.PublicCfSetId
LEFT OUTER JOIN PrPublicTransform TRF ON TRF.Id = EVB.PublicTransformId
LEFT OUTER JOIN PrPublicOfficialMeetingView POM ON POM.Id = EVB.PublicOfficialMeetingId  
CROSS JOIN 	AsLanguage ALA
LEFT OUTER JOIN PrPublicText PTE ON PUB.Id  = PTE.PublicId AND PTE.LanguageNo = ALA.LanguageNo
WHERE ALA.UserDialog = 1

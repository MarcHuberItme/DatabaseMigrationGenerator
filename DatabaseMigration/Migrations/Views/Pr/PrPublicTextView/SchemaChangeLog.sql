--liquibase formatted sql

--changeset system:create-alter-view-PrPublicTextView context:any labels:c-any,o-view,ot-schema,on-PrPublicTextView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicTextView
CREATE OR ALTER VIEW dbo.PrPublicTextView AS
SELECT TOP 100 PERCENT
   PTE.Id,
   PTE.HdCreateDate,
   PTE.HdCreator,
   PTE.HdChangeDate,
   PTE.HdChangeUser,
   PTE.HdEditStamp,
   PTE.HdVersionNo,
   PTE.HdProcessId,
   PTE.HdStatusFlag,
   PTE.HdNoUpdateFlag,
   PTE.HdPendingChanges,
   PTE.HdPendingSubChanges,
   PTE.HdTriggerControl,
   PTE.PublicId,
   PTE.LanguageNo,
   PTE.VdfLanguageNo,
   PTE.VdfShortName,
   PTE.VdfPreffix,
   PTE.VdfSuffix,
   PTE.ShortName,
   PTE.Interest,
   PTE.Preffix,
   PTE.ValidityRange,
   PTE.Suffix,
   PTE.ShortNameManual,
   PTE.LongNameManual,
   PIN.NAME
FROM PrPublicText PTE
JOIN PrPublic PUB
   ON PUB.Id = PTE.PublicId
LEFT OUTER JOIN PtInstituteName PIN
   ON PUB.NamingPartnerId = PIN.PartnerId 
WHERE PIN.LanguageNo IS NULL OR
               PTE.LanguageNo IS NULL OR
               PTE.LanguageNo = PIN.LanguageNo


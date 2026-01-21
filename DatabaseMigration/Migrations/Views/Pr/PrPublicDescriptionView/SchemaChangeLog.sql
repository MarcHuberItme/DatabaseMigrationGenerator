--liquibase formatted sql

--changeset system:create-alter-view-PrPublicDescriptionView context:any labels:c-any,o-view,ot-schema,on-PrPublicDescriptionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicDescriptionView
CREATE OR ALTER VIEW dbo.PrPublicDescriptionView AS
SELECT TOP 100 PERCENT
    PUB.Id, 
    PUB.HdPendingChanges,
    PUB.HdPendingSubChanges, 
    PUB.HdVersionNo,
    PUB.IssuerId,
    PUB.InstrumentTypeNo,
    PUB.IsinNo,
    PUB.InstrumentStatusNo,
    PUB.NominalCurrency,
    PUB.VdfInstrumentSymbol,
    PUB.SecurityType,
    PTE.LanguageNo,
    PTE.ShortName,
    IsNull(Convert(varchar,PTE.Interest) + ' % ', '') 
    + IsNull(PTE.Preffix + ' ', '') 
    + IsNull(PIN.NAME + ' ', '') 
    + IsNull(PTE.ValidityRange + ' ', '') 
    + IsNull(PTE.Suffix,'') as LongName, 
    PUB.IsinNo 
    + IsNull(' ' + PTE.ShortName, '') as PublicDescription,
    PUB.VdfInstrumentSymbol + ' / ' +
    PUB.IsinNo
    + IsNull(' ' + PTE.ShortName, '') as PublicDescriptionWithValNr,
    PUB.RefTypeNo,
    PUB.ProductId,
    PUB.SmallDenom,
    PUB.FundTypeNo,
    PTE.ShortNameManual, 
    PTE.LongNameManual, 
    PUB.FinfraGApplicTaxRep
FROM PrPublic PUB
LEFT OUTER JOIN PrPublicText PTE
   ON PUB.Id  = PTE.PublicId 
LEFT OUTER JOIN PtInstituteName PIN
   ON PUB.NamingPartnerId = PIN.PartnerId 
WHERE PIN.LanguageNo IS NULL OR
               PTE.LanguageNo IS NULL OR
               PTE.LanguageNo = PIN.LanguageNo

--liquibase formatted sql

--changeset system:create-alter-view-MgValorDescriptionView context:any labels:c-any,o-view,ot-schema,on-MgValorDescriptionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MgValorDescriptionView
CREATE OR ALTER VIEW dbo.MgValorDescriptionView AS
SELECT TOP 100 PERCENT
    MGV.Id, 
    MGV.HdPendingChanges,
    MGV.HdPendingSubChanges, 
    MGV.HdVersionNo,
    MGV.VrxValNrTk,
    MGV.VrxValAnr,
    MGV.VrxTitArt,
    MGV.ToffVerfall,
    MGV.ToffBasis,
    MGV.VrxShortText,
    MGV.FinstarValNr,
    PTE.LanguageNo,
    PTE.ShortName,
    MGV.MappingChecked
FROM MgValor MGV
LEFT OUTER JOIN PrPublic PUB
   ON PUB.VdfInstrumentSymbol = MGV.FinstarValNr
LEFT OUTER JOIN PrPublicText PTE
   ON PUB.Id  = PTE.PublicId 

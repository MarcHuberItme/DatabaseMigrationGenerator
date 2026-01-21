--liquibase formatted sql

--changeset system:create-alter-view-AsDocumentMetaDataViewV2 context:any labels:c-any,o-view,ot-schema,on-AsDocumentMetaDataViewV2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentMetaDataViewV2
CREATE OR ALTER VIEW dbo.AsDocumentMetaDataViewV2 AS

SELECT
    AsDocument.Id,
    AsDocument.Location,
    AsDocument.PartnerId,
    AsDocument.AddressId,
    AsDocument.PortfolioId,
    AsDocument.AccountBaseId,
    AsDocument.Amount,
    AsDocument.DocumentNo,
    AsDocument.ExpirationStart,
    AsDocument.NumPages,
    AsDocument.Type as DocumentTypeId,
    AsCorrItem.ItemNo as DocumentTypeNo,
    AsDocumentTypeText.TextLong as DocumentTypeName,
    AsCorrItem.DocumentGroup as DocumentGroupNo,
    AsCorrItem.ForEBanking as ForEBanking,
    AsDocumentGroup.Id as DocumentGroupId,
    AsDocumentGroupText.TextLong as DocumentGroupName,
    AsDocument.VirtualDate,
    AsDocumentData.Id as FileId,
    AsDocumentData.ExpirationStart as FileExpirationStart,
    AsDocumentData.Format as FileFormat,
    AsDocumentData.RecordDate,
    AsDocumentData.Comments,
    AsDocumentData.Location as FileArchiveState,
    AsDocumentData.StatusNo as StatusNumber,
    AsDocumentData.Replaceable,
    log1.AccessDateTime as LastFileAccess,
    PtBase.PartnerNo,
    PtBase.PartnerNoEdited,
    PtBase.PartnerNoText,
    PtAddress.ReportAdrLine as PartnerDescriptionFromMainAddr,
    PtPortfolio.PortfolioNo,
    PtPortfolio.PortfolioNoEdited,
    PtPortfolio.PortfolioNoText,
    PtPortfolio.CustomerReference as PortfolioCustomerReference,
	PtPortfolio.PortfolioTypeNo,
    PtAccountBase.AccountNo,
    PtAccountBase.AccountNoEdited,
    PtAccountBase.AccountNoText,
	PtAccountBase.CustomerReference As AccountCustomerReference,
	PrPrivate.ProductNo
    
FROM AsDocument
LEFT OUTER JOIN AsDocumentData on AsDocumentData.DocumentId = AsDocument.Id
JOIN AsCorrItem on AsCorrItem.Id = AsDocument.Type and AsCorrItem.HdVersionNo < 999999999
LEFT OUTER JOIN AsCorrItemGroup on AsCorrItemGroup.CorrItemGroupNo = AsCorrItem.ItemNo
LEFT OUTER JOIN PtAccountBase on AsDocument.AccountBaseId = PtAccountBase.Id
JOIN PtBase on AsDocument.PartnerId = PtBase.Id
LEFT OUTER JOIN PtAddress on PtBase.Id = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
LEFT OUTER JOIN AsDocumentGroup on AsDocumentGroup.GroupCode = AsCorrItem.DocumentGroup
LEFT OUTER JOIN PtPortfolio on AsDocument.PortfolioId = PtPortfolio.Id
LEFT OUTER JOIN AsText as AsDocumentGroupText on AsDocumentGroup.Id = AsDocumentGroupText.MasterId and AsDocumentGroupText.LanguageNo = 1
LEFT OUTER JOIN AsText as AsDocumentTypeText on AsCorrItem.Id = AsDocumentTypeText.MasterId and AsDocumentTypeText.LanguageNo = 1
LEFT OUTER JOIN PrReference on PrReference.AccountId = PtAccountBase.Id
LEFT OUTER JOIN PrPrivate on PrReference.ProductId = PrPrivate.ProductId
LEFT OUTER JOIN AsDocumentDataAccessLog log1 on log1.AsDocumentDataId = AsDocumentData.Id
LEFT OUTER JOIN AsDocumentDataAccessLog log2 on log1.AsDocumentDataId = AsDocumentData.Id AND log1.AccessLogSequence < log2.AccessLogSequence
where AsDocument.HdVersionNo < 999999999
and log2.Id IS NULL

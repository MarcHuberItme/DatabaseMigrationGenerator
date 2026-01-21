--liquibase formatted sql

--changeset system:generated-create-navigation-index-AiTaxAIADetail context:any labels:c-any,o-table,ot-schema,on-AiTaxAIADetail,fin-13659 runOnChange:true
--comment: Create navigation index on table AiTaxAIADetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AiTaxAIADetail_TaxStatusId%')
BEGIN
    CREATE INDEX IX_AiTaxAIADetail_TaxStatusId
    ON AiTaxAIADetail (TaxStatusId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-AiTaxCARFDetail context:any labels:c-any,o-table,ot-schema,on-AiTaxCARFDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table AiTaxCARFDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AiTaxCARFDetail_TaxStatusId%')
BEGIN
    CREATE INDEX IX_AiTaxCARFDetail_TaxStatusId
    ON AiTaxCARFDetail (TaxStatusId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-AiTaxConsolidatedAsset context:any labels:c-any,o-table,ot-schema,on-AiTaxConsolidatedAsset,fin-13659 runOnChange:true
--comment: Create navigation index on table AiTaxConsolidatedAsset
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AiTaxConsolidatedAsset_PartnerId%')
BEGIN
    CREATE INDEX IX_AiTaxConsolidatedAsset_PartnerId
    ON AiTaxConsolidatedAsset (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-AiTaxDetailFatca context:any labels:c-any,o-table,ot-schema,on-AiTaxDetailFatca,fin-13659 runOnChange:true
--comment: Create navigation index on table AiTaxDetailFatca
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AiTaxDetailFatca_TaxStatusId%')
BEGIN
    CREATE INDEX IX_AiTaxDetailFatca_TaxStatusId
    ON AiTaxDetailFatca (TaxStatusId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-AiTaxDetailQI context:any labels:c-any,o-table,ot-schema,on-AiTaxDetailQI,fin-13659 runOnChange:true
--comment: Create navigation index on table AiTaxDetailQI
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AiTaxDetailQI_TaxStatusId%')
BEGIN
    CREATE INDEX IX_AiTaxDetailQI_TaxStatusId
    ON AiTaxDetailQI (TaxStatusId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-AiTaxStatus context:any labels:c-any,o-table,ot-schema,on-AiTaxStatus,fin-13659 runOnChange:true
--comment: Create navigation index on table AiTaxStatus
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AiTaxStatus_PartnerId%')
BEGIN
    CREATE INDEX IX_AiTaxStatus_PartnerId
    ON AiTaxStatus (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-AxTaxDetailATX context:any labels:c-any,o-table,ot-schema,on-AxTaxDetailATX,fin-13659 runOnChange:true
--comment: Create navigation index on table AxTaxDetailATX
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_AxTaxDetailATX_TaxStatusId%')
BEGIN
    CREATE INDEX IX_AxTaxDetailATX_TaxStatusId
    ON AxTaxDetailATX (TaxStatusId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-CoBaseass context:any labels:c-any,o-table,ot-schema,on-CoBaseass,fin-13659 runOnChange:true
--comment: Create navigation index on table CoBaseass
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_CoBaseass_AccountId%')
BEGIN
    CREATE INDEX IX_CoBaseass_AccountId
    ON CoBaseass (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvDetailCharge context:any labels:c-any,o-table,ot-schema,on-EvDetailCharge,fin-13659 runOnChange:true
--comment: Create navigation index on table EvDetailCharge
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvDetailCharge_EventDetailId%')
BEGIN
    CREATE INDEX IX_EvDetailCharge_EventDetailId
    ON EvDetailCharge (EventDetailId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvDetailReportText context:any labels:c-any,o-table,ot-schema,on-EvDetailReportText,fin-13659 runOnChange:true
--comment: Create navigation index on table EvDetailReportText
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvDetailReportText_EventDetailId%')
BEGIN
    CREATE INDEX IX_EvDetailReportText_EventDetailId
    ON EvDetailReportText (EventDetailId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvDetailTaxRate context:any labels:c-any,o-table,ot-schema,on-EvDetailTaxRate,fin-13659 runOnChange:true
--comment: Create navigation index on table EvDetailTaxRate
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvDetailTaxRate_EventDetailTaxId%')
BEGIN
    CREATE INDEX IX_EvDetailTaxRate_EventDetailTaxId
    ON EvDetailTaxRate (EventDetailTaxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvDetailTaxReclaim context:any labels:c-any,o-table,ot-schema,on-EvDetailTaxReclaim,fin-13659 runOnChange:true
--comment: Create navigation index on table EvDetailTaxReclaim
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvDetailTaxReclaim_DetailTaxRateId%')
BEGIN
    CREATE INDEX IX_EvDetailTaxReclaim_DetailTaxRateId
    ON EvDetailTaxReclaim (DetailTaxRateId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvPosAmount context:any labels:c-any,o-table,ot-schema,on-EvPosAmount,fin-13659 runOnChange:true
--comment: Create navigation index on table EvPosAmount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvPosAmount_PosDetailId%')
BEGIN
    CREATE INDEX IX_EvPosAmount_PosDetailId
    ON EvPosAmount (PosDetailId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvPosDetail context:any labels:c-any,o-table,ot-schema,on-EvPosDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table EvPosDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvPosDetail_SelectionPosId%')
BEGIN
    CREATE INDEX IX_EvPosDetail_SelectionPosId
    ON EvPosDetail (SelectionPosId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvPosTaxAmount context:any labels:c-any,o-table,ot-schema,on-EvPosTaxAmount,fin-13659 runOnChange:true
--comment: Create navigation index on table EvPosTaxAmount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvPosTaxAmount_PosDetailId%')
BEGIN
    CREATE INDEX IX_EvPosTaxAmount_PosDetailId
    ON EvPosTaxAmount (PosDetailId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-EvSelectionPos context:any labels:c-any,o-table,ot-schema,on-EvSelectionPos,fin-13659 runOnChange:true
--comment: Create navigation index on table EvSelectionPos
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_EvSelectionPos_EventSelectionId%')
BEGIN
    CREATE INDEX IX_EvSelectionPos_EventSelectionId
    ON EvSelectionPos (EventSelectionId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-MgDS12 context:any labels:c-any,o-table,ot-schema,on-MgDS12,fin-13659 runOnChange:true
--comment: Create navigation index on table MgDS12
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_MgDS12_PortfolioId%')
BEGIN
    CREATE INDEX IX_MgDS12_PortfolioId
    ON MgDS12 (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-MgDS40 context:any labels:c-any,o-table,ot-schema,on-MgDS40,fin-13659 runOnChange:true
--comment: Create navigation index on table MgDS40
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_MgDS40_PortfolioId%')
BEGIN
    CREATE INDEX IX_MgDS40_PortfolioId
    ON MgDS40 (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-MgXS23 context:any labels:c-any,o-table,ot-schema,on-MgXS23,fin-13659 runOnChange:true
--comment: Create navigation index on table MgXS23
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_MgXS23_AccountId%')
BEGIN
    CREATE INDEX IX_MgXS23_AccountId
    ON MgXS23 (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-MgXS40 context:any labels:c-any,o-table,ot-schema,on-MgXS40,fin-13659 runOnChange:true
--comment: Create navigation index on table MgXS40
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_MgXS40_AccountId%')
BEGIN
    CREATE INDEX IX_MgXS40_AccountId
    ON MgXS40 (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-MgZS23 context:any labels:c-any,o-table,ot-schema,on-MgZS23,fin-13659 runOnChange:true
--comment: Create navigation index on table MgZS23
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_MgZS23_PartnerId%')
BEGIN
    CREATE INDEX IX_MgZS23_PartnerId
    ON MgZS23 (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-MgZS40 context:any labels:c-any,o-table,ot-schema,on-MgZS40,fin-13659 runOnChange:true
--comment: Create navigation index on table MgZS40
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_MgZS40_PartnerId%')
BEGIN
    CREATE INDEX IX_MgZS40_PartnerId
    ON MgZS40 (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicBlocking context:any labels:c-any,o-table,ot-schema,on-PrPublicBlocking,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicBlocking
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicBlocking_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicBlocking_PublicId
    ON PrPublicBlocking (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCaTax context:any labels:c-any,o-table,ot-schema,on-PrPublicCaTax,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCaTax
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCaTax_PublicTransformId%')
BEGIN
    CREATE INDEX IX_PrPublicCaTax_PublicTransformId
    ON PrPublicCaTax (PublicTransformId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCaTaxAmount context:any labels:c-any,o-table,ot-schema,on-PrPublicCaTaxAmount,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCaTaxAmount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCaTaxAmount_PublicTaxId%')
BEGIN
    CREATE INDEX IX_PrPublicCaTaxAmount_PublicTaxId
    ON PrPublicCaTaxAmount (PublicTaxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCf context:any labels:c-any,o-table,ot-schema,on-PrPublicCf,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCf
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCf_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicCf_PublicId
    ON PrPublicCf (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfAmount context:any labels:c-any,o-table,ot-schema,on-PrPublicCfAmount,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfAmount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfAmount_PublicCfId%')
BEGIN
    CREATE INDEX IX_PrPublicCfAmount_PublicCfId
    ON PrPublicCfAmount (PublicCfId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfComp context:any labels:c-any,o-table,ot-schema,on-PrPublicCfComp,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfComp
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfComp_PublicCfParentSetId%')
BEGIN
    CREATE INDEX IX_PrPublicCfComp_PublicCfParentSetId
    ON PrPublicCfComp (PublicCfParentSetId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfCondFixPrice context:any labels:c-any,o-table,ot-schema,on-PrPublicCfCondFixPrice,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfCondFixPrice
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfCondFixPrice_PublicCfId%')
BEGIN
    CREATE INDEX IX_PrPublicCfCondFixPrice_PublicCfId
    ON PrPublicCfCondFixPrice (PublicCfId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfOrigin context:any labels:c-any,o-table,ot-schema,on-PrPublicCfOrigin,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfOrigin
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfOrigin_PublicCfId%')
BEGIN
    CREATE INDEX IX_PrPublicCfOrigin_PublicCfId
    ON PrPublicCfOrigin (PublicCfId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfSet context:any labels:c-any,o-table,ot-schema,on-PrPublicCfSet,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfSet
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfSet_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicCfSet_PublicId
    ON PrPublicCfSet (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfSettlFix context:any labels:c-any,o-table,ot-schema,on-PrPublicCfSettlFix,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfSettlFix
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfSettlFix_PublicCfId%')
BEGIN
    CREATE INDEX IX_PrPublicCfSettlFix_PublicCfId
    ON PrPublicCfSettlFix (PublicCfId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfStrikeBarrierDef context:any labels:c-any,o-table,ot-schema,on-PrPublicCfStrikeBarrierDef,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfStrikeBarrierDef
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfStrikeBarrierDef_CashFlowId%')
BEGIN
    CREATE INDEX IX_PrPublicCfStrikeBarrierDef_CashFlowId
    ON PrPublicCfStrikeBarrierDef (CashFlowId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfStrikeBarrierDetail context:any labels:c-any,o-table,ot-schema,on-PrPublicCfStrikeBarrierDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfStrikeBarrierDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfStrikeBarrierDetail_CashFlowId%')
BEGIN
    CREATE INDEX IX_PrPublicCfStrikeBarrierDetail_CashFlowId
    ON PrPublicCfStrikeBarrierDetail (CashFlowId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfTax context:any labels:c-any,o-table,ot-schema,on-PrPublicCfTax,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfTax
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfTax_PublicCfId%')
BEGIN
    CREATE INDEX IX_PrPublicCfTax_PublicCfId
    ON PrPublicCfTax (PublicCfId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCfTaxAmount context:any labels:c-any,o-table,ot-schema,on-PrPublicCfTaxAmount,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCfTaxAmount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCfTaxAmount_PublicTaxId%')
BEGIN
    CREATE INDEX IX_PrPublicCfTaxAmount_PublicTaxId
    ON PrPublicCfTaxAmount (PublicTaxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCorpAct context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpAct,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCorpAct
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCorpAct_PartnerId%')
BEGIN
    CREATE INDEX IX_PrPublicCorpAct_PartnerId
    ON PrPublicCorpAct (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCorpActRef context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActRef,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCorpActRef
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCorpActRef_PublicCorpActId%')
BEGIN
    CREATE INDEX IX_PrPublicCorpActRef_PublicCorpActId
    ON PrPublicCorpActRef (PublicCorpActId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCorpActRole context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActRole,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCorpActRole
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCorpActRole_PublicCorpActId%')
BEGIN
    CREATE INDEX IX_PrPublicCorpActRole_PublicCorpActId
    ON PrPublicCorpActRole (PublicCorpActId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCorpActSub context:any labels:c-any,o-table,ot-schema,on-PrPublicCorpActSub,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCorpActSub
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCorpActSub_PublicCorpActId%')
BEGIN
    CREATE INDEX IX_PrPublicCorpActSub_PublicCorpActId
    ON PrPublicCorpActSub (PublicCorpActId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicCurrentTax context:any labels:c-any,o-table,ot-schema,on-PrPublicCurrentTax,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicCurrentTax
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicCurrentTax_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicCurrentTax_PublicId
    ON PrPublicCurrentTax (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicEuTaxDetail context:any labels:c-any,o-table,ot-schema,on-PrPublicEuTaxDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicEuTaxDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicEuTaxDetail_PublicEuTaxId%')
BEGIN
    CREATE INDEX IX_PrPublicEuTaxDetail_PublicEuTaxId
    ON PrPublicEuTaxDetail (PublicEuTaxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicEuTaxStartVal context:any labels:c-any,o-table,ot-schema,on-PrPublicEuTaxStartVal,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicEuTaxStartVal
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicEuTaxStartVal_PublicEuTaxId%')
BEGIN
    CREATE INDEX IX_PrPublicEuTaxStartVal_PublicEuTaxId
    ON PrPublicEuTaxStartVal (PublicEuTaxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicFundSelfDecl context:any labels:c-any,o-table,ot-schema,on-PrPublicFundSelfDecl,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicFundSelfDecl
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicFundSelfDecl_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicFundSelfDecl_PublicId
    ON PrPublicFundSelfDecl (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicFundSelfDeclDetail context:any labels:c-any,o-table,ot-schema,on-PrPublicFundSelfDeclDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicFundSelfDeclDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicFundSelfDeclDetail_PublicFundSelfDeclId%')
BEGIN
    CREATE INDEX IX_PrPublicFundSelfDeclDetail_PublicFundSelfDeclId
    ON PrPublicFundSelfDeclDetail (PublicFundSelfDeclId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicHist context:any labels:c-any,o-table,ot-schema,on-PrPublicHist,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicHist
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicHist_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicHist_PublicId
    ON PrPublicHist (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicIdent context:any labels:c-any,o-table,ot-schema,on-PrPublicIdent,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicIdent
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicIdent_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicIdent_PublicId
    ON PrPublicIdent (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicInstituteRole context:any labels:c-any,o-table,ot-schema,on-PrPublicInstituteRole,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicInstituteRole
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicInstituteRole_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicInstituteRole_PublicId
    ON PrPublicInstituteRole (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicInstrSnbClass context:any labels:c-any,o-table,ot-schema,on-PrPublicInstrSnbClass,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicInstrSnbClass
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicInstrSnbClass_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicInstrSnbClass_PublicId
    ON PrPublicInstrSnbClass (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicIntTaxEvent context:any labels:c-any,o-table,ot-schema,on-PrPublicIntTaxEvent,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicIntTaxEvent
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicIntTaxEvent_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicIntTaxEvent_PublicId
    ON PrPublicIntTaxEvent (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicKeyFigure context:any labels:c-any,o-table,ot-schema,on-PrPublicKeyFigure,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicKeyFigure
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicKeyFigure_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicKeyFigure_PublicId
    ON PrPublicKeyFigure (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicListing context:any labels:c-any,o-table,ot-schema,on-PrPublicListing,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicListing
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicListing_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicListing_PublicId
    ON PrPublicListing (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicListingSymbol context:any labels:c-any,o-table,ot-schema,on-PrPublicListingSymbol,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicListingSymbol
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicListingSymbol_PublicListingId%')
BEGIN
    CREATE INDEX IX_PrPublicListingSymbol_PublicListingId
    ON PrPublicListingSymbol (PublicListingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicOfficialMeeting context:any labels:c-any,o-table,ot-schema,on-PrPublicOfficialMeeting,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicOfficialMeeting
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicOfficialMeeting_OfficialMeetingId%')
BEGIN
    CREATE INDEX IX_PrPublicOfficialMeeting_OfficialMeetingId
    ON PrPublicOfficialMeeting (OfficialMeetingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicRelation context:any labels:c-any,o-table,ot-schema,on-PrPublicRelation,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicRelation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicRelation_SourcePublicId%')
BEGIN
    CREATE INDEX IX_PrPublicRelation_SourcePublicId
    ON PrPublicRelation (SourcePublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicRestr context:any labels:c-any,o-table,ot-schema,on-PrPublicRestr,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicRestr
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicRestr_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicRestr_PublicId
    ON PrPublicRestr (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicSpecFundCat context:any labels:c-any,o-table,ot-schema,on-PrPublicSpecFundCat,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicSpecFundCat
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicSpecFundCat_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicSpecFundCat_PublicId
    ON PrPublicSpecFundCat (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicStopList context:any labels:c-any,o-table,ot-schema,on-PrPublicStopList,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicStopList
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicStopList_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicStopList_PublicId
    ON PrPublicStopList (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicStopNo context:any labels:c-any,o-table,ot-schema,on-PrPublicStopNo,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicStopNo
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicStopNo_PublicStopListId%')
BEGIN
    CREATE INDEX IX_PrPublicStopNo_PublicStopListId
    ON PrPublicStopNo (PublicStopListId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicStructure context:any labels:c-any,o-table,ot-schema,on-PrPublicStructure,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicStructure
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicStructure_MasterId%')
BEGIN
    CREATE INDEX IX_PrPublicStructure_MasterId
    ON PrPublicStructure (MasterId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicStructureAssign context:any labels:c-any,o-table,ot-schema,on-PrPublicStructureAssign,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicStructureAssign
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicStructureAssign_StructureId%')
BEGIN
    CREATE INDEX IX_PrPublicStructureAssign_StructureId
    ON PrPublicStructureAssign (StructureId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicTax context:any labels:c-any,o-table,ot-schema,on-PrPublicTax,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicTax
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicTax_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicTax_PublicId
    ON PrPublicTax (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicTaxAmount context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxAmount,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicTaxAmount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicTaxAmount_PublicTaxId%')
BEGIN
    CREATE INDEX IX_PrPublicTaxAmount_PublicTaxId
    ON PrPublicTaxAmount (PublicTaxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicTaxPrice context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxPrice,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicTaxPrice
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicTaxPrice_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicTaxPrice_PublicId
    ON PrPublicTaxPrice (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicTaxRegulation context:any labels:c-any,o-table,ot-schema,on-PrPublicTaxRegulation,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicTaxRegulation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicTaxRegulation_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicTaxRegulation_PublicId
    ON PrPublicTaxRegulation (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicText context:any labels:c-any,o-table,ot-schema,on-PrPublicText,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicText
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicText_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicText_PublicId
    ON PrPublicText (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicTransform context:any labels:c-any,o-table,ot-schema,on-PrPublicTransform,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicTransform
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicTransform_PublicId%')
BEGIN
    CREATE INDEX IX_PrPublicTransform_PublicId
    ON PrPublicTransform (PublicId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PrPublicTransformTo context:any labels:c-any,o-table,ot-schema,on-PrPublicTransformTo,fin-13659 runOnChange:true
--comment: Create navigation index on table PrPublicTransformTo
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PrPublicTransformTo_PublicTransformId%')
BEGIN
    CREATE INDEX IX_PrPublicTransformTo_PublicTransformId
    ON PrPublicTransformTo (PublicTransformId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountAdviceOrMeRule context:any labels:c-any,o-table,ot-schema,on-PtAccountAdviceOrMeRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountAdviceOrMeRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountAdviceOrMeRule_AccountAdviceRuleId%')
BEGIN
    CREATE INDEX IX_PtAccountAdviceOrMeRule_AccountAdviceRuleId
    ON PtAccountAdviceOrMeRule (AccountAdviceRuleId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountAdviceRule context:any labels:c-any,o-table,ot-schema,on-PtAccountAdviceRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountAdviceRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountAdviceRule_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountAdviceRule_AccountBaseId
    ON PtAccountAdviceRule (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountAssignmentCredit context:any labels:c-any,o-table,ot-schema,on-PtAccountAssignmentCredit,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountAssignmentCredit
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountAssignmentCredit_AccountId%')
BEGIN
    CREATE INDEX IX_PtAccountAssignmentCredit_AccountId
    ON PtAccountAssignmentCredit (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountBuildingLoanCheck context:any labels:c-any,o-table,ot-schema,on-PtAccountBuildingLoanCheck,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountBuildingLoanCheck
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountBuildingLoanCheck_AccountId%')
BEGIN
    CREATE INDEX IX_PtAccountBuildingLoanCheck_AccountId
    ON PtAccountBuildingLoanCheck (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountCommission context:any labels:c-any,o-table,ot-schema,on-PtAccountCommission,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountCommission
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountCommission_AccountId%')
BEGIN
    CREATE INDEX IX_PtAccountCommission_AccountId
    ON PtAccountCommission (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountComponent context:any labels:c-any,o-table,ot-schema,on-PtAccountComponent,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountComponent
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountComponent_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountComponent_AccountBaseId
    ON PtAccountComponent (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountCompValue context:any labels:c-any,o-table,ot-schema,on-PtAccountCompValue,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountCompValue
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountCompValue_AccountComponentId%')
BEGIN
    CREATE INDEX IX_PtAccountCompValue_AccountComponentId
    ON PtAccountCompValue (AccountComponentId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountCreditRating context:any labels:c-any,o-table,ot-schema,on-PtAccountCreditRating,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountCreditRating
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountCreditRating_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountCreditRating_AccountBaseId
    ON PtAccountCreditRating (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountCreditRatingDetail context:any labels:c-any,o-table,ot-schema,on-PtAccountCreditRatingDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountCreditRatingDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountCreditRatingDetail_CreditRatingId%')
BEGIN
    CREATE INDEX IX_PtAccountCreditRatingDetail_CreditRatingId
    ON PtAccountCreditRatingDetail (CreditRatingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountDirectDebiting context:any labels:c-any,o-table,ot-schema,on-PtAccountDirectDebiting,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountDirectDebiting
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountDirectDebiting_AccountId%')
BEGIN
    CREATE INDEX IX_PtAccountDirectDebiting_AccountId
    ON PtAccountDirectDebiting (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountExpense context:any labels:c-any,o-table,ot-schema,on-PtAccountExpense,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountExpense
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountExpense_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountExpense_AccountBaseId
    ON PtAccountExpense (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountExpenseExeption context:any labels:c-any,o-table,ot-schema,on-PtAccountExpenseExeption,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountExpenseExeption
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountExpenseExeption_AccountExpenseId%')
BEGIN
    CREATE INDEX IX_PtAccountExpenseExeption_AccountExpenseId
    ON PtAccountExpenseExeption (AccountExpenseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountNotice context:any labels:c-any,o-table,ot-schema,on-PtAccountNotice,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountNotice
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountNotice_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountNotice_AccountBaseId
    ON PtAccountNotice (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountPayback context:any labels:c-any,o-table,ot-schema,on-PtAccountPayback,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountPayback
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountPayback_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountPayback_AccountBaseId
    ON PtAccountPayback (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountPaymentRule context:any labels:c-any,o-table,ot-schema,on-PtAccountPaymentRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountPaymentRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountPaymentRule_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountPaymentRule_AccountBaseId
    ON PtAccountPaymentRule (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountPriceDeviation context:any labels:c-any,o-table,ot-schema,on-PtAccountPriceDeviation,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountPriceDeviation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountPriceDeviation_AccountBaseId%')
BEGIN
    CREATE INDEX IX_PtAccountPriceDeviation_AccountBaseId
    ON PtAccountPriceDeviation (AccountBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAccountProcRule context:any labels:c-any,o-table,ot-schema,on-PtAccountProcRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAccountProcRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAccountProcRule_AccountId%')
BEGIN
    CREATE INDEX IX_PtAccountProcRule_AccountId
    ON PtAccountProcRule (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrCardBase context:any labels:c-any,o-table,ot-schema,on-PtAgrCardBase,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrCardBase
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrCardBase_PartnerId%')
BEGIN
    CREATE INDEX IX_PtAgrCardBase_PartnerId
    ON PtAgrCardBase (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgreement context:any labels:c-any,o-table,ot-schema,on-PtAgreement,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgreement
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgreement_SecurityId%')
BEGIN
    CREATE INDEX IX_PtAgreement_SecurityId
    ON PtAgreement (SecurityId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrGeneralContract context:any labels:c-any,o-table,ot-schema,on-PtAgrGeneralContract,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrGeneralContract
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrGeneralContract_PartnerId%')
BEGIN
    CREATE INDEX IX_PtAgrGeneralContract_PartnerId
    ON PtAgrGeneralContract (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrGeneralContractSignature context:any labels:c-any,o-table,ot-schema,on-PtAgrGeneralContractSignature,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrGeneralContractSignature
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrGeneralContractSignature_GeneralContractId%')
BEGIN
    CREATE INDEX IX_PtAgrGeneralContractSignature_GeneralContractId
    ON PtAgrGeneralContractSignature (GeneralContractId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrGeneralContractTemplates context:any labels:c-any,o-table,ot-schema,on-PtAgrGeneralContractTemplates,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrGeneralContractTemplates
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrGeneralContractTemplates_GeneralContractId%')
BEGIN
    CREATE INDEX IX_PtAgrGeneralContractTemplates_GeneralContractId
    ON PtAgrGeneralContractTemplates (GeneralContractId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrGeneralContrApplicFunds context:any labels:c-any,o-table,ot-schema,on-PtAgrGeneralContrApplicFunds,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrGeneralContrApplicFunds
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrGeneralContrApplicFunds_GeneralContractId%')
BEGIN
    CREATE INDEX IX_PtAgrGeneralContrApplicFunds_GeneralContractId
    ON PtAgrGeneralContrApplicFunds (GeneralContractId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrSecurity context:any labels:c-any,o-table,ot-schema,on-PtAgrSecurity,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrSecurity
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrSecurity_PartnerId%')
BEGIN
    CREATE INDEX IX_PtAgrSecurity_PartnerId
    ON PtAgrSecurity (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrSecurityPosition context:any labels:c-any,o-table,ot-schema,on-PtAgrSecurityPosition,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrSecurityPosition
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrSecurityPosition_SecurityVersionId%')
BEGIN
    CREATE INDEX IX_PtAgrSecurityPosition_SecurityVersionId
    ON PtAgrSecurityPosition (SecurityVersionId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrSecurityVersion context:any labels:c-any,o-table,ot-schema,on-PtAgrSecurityVersion,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrSecurityVersion
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrSecurityVersion_AgrSecurityId%')
BEGIN
    CREATE INDEX IX_PtAgrSecurityVersion_AgrSecurityId
    ON PtAgrSecurityVersion (AgrSecurityId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtAgrTaxRegulation context:any labels:c-any,o-table,ot-schema,on-PtAgrTaxRegulation,fin-13659 runOnChange:true
--comment: Create navigation index on table PtAgrTaxRegulation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtAgrTaxRegulation_PartnerId%')
BEGIN
    CREATE INDEX IX_PtAgrTaxRegulation_PartnerId
    ON PtAgrTaxRegulation (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtBaseStructure context:any labels:c-any,o-table,ot-schema,on-PtBaseStructure,fin-13659 runOnChange:true
--comment: Create navigation index on table PtBaseStructure
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtBaseStructure_MasterId%')
BEGIN
    CREATE INDEX IX_PtBaseStructure_MasterId
    ON PtBaseStructure (MasterId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtBaseStructureAssign context:any labels:c-any,o-table,ot-schema,on-PtBaseStructureAssign,fin-13659 runOnChange:true
--comment: Create navigation index on table PtBaseStructureAssign
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtBaseStructureAssign_StructureId%')
BEGIN
    CREATE INDEX IX_PtBaseStructureAssign_StructureId
    ON PtBaseStructureAssign (StructureId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtBlocking context:any labels:c-any,o-table,ot-schema,on-PtBlocking,fin-13659 runOnChange:true
--comment: Create navigation index on table PtBlocking
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtBlocking_PartnerId%')
BEGIN
    CREATE INDEX IX_PtBlocking_PartnerId
    ON PtBlocking (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtBranchAccessPermit context:any labels:c-any,o-table,ot-schema,on-PtBranchAccessPermit,fin-13659 runOnChange:true
--comment: Create navigation index on table PtBranchAccessPermit
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtBranchAccessPermit_PartnerId%')
BEGIN
    CREATE INDEX IX_PtBranchAccessPermit_PartnerId
    ON PtBranchAccessPermit (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtBusinessRatio context:any labels:c-any,o-table,ot-schema,on-PtBusinessRatio,fin-13659 runOnChange:true
--comment: Create navigation index on table PtBusinessRatio
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtBusinessRatio_PartnerId%')
BEGIN
    CREATE INDEX IX_PtBusinessRatio_PartnerId
    ON PtBusinessRatio (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCashTransList context:any labels:c-any,o-table,ot-schema,on-PtCashTransList,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCashTransList
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCashTransList_PartnerId%')
BEGIN
    CREATE INDEX IX_PtCashTransList_PartnerId
    ON PtCashTransList (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtChild context:any labels:c-any,o-table,ot-schema,on-PtChild,fin-13659 runOnChange:true
--comment: Create navigation index on table PtChild
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtChild_PartnerId%')
BEGIN
    CREATE INDEX IX_PtChild_PartnerId
    ON PtChild (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtContactPerson context:any labels:c-any,o-table,ot-schema,on-PtContactPerson,fin-13659 runOnChange:true
--comment: Create navigation index on table PtContactPerson
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtContactPerson_PartnerId%')
BEGIN
    CREATE INDEX IX_PtContactPerson_PartnerId
    ON PtContactPerson (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtContactReport context:any labels:c-any,o-table,ot-schema,on-PtContactReport,fin-13659 runOnChange:true
--comment: Create navigation index on table PtContactReport
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtContactReport_PartnerId%')
BEGIN
    CREATE INDEX IX_PtContactReport_PartnerId
    ON PtContactReport (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCorrAccount context:any labels:c-any,o-table,ot-schema,on-PtCorrAccount,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCorrAccount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCorrAccount_AccountId%')
BEGIN
    CREATE INDEX IX_PtCorrAccount_AccountId
    ON PtCorrAccount (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCorrAccountItemGroup context:any labels:c-any,o-table,ot-schema,on-PtCorrAccountItemGroup,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCorrAccountItemGroup
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCorrAccountItemGroup_CorrAccountId%')
BEGIN
    CREATE INDEX IX_PtCorrAccountItemGroup_CorrAccountId
    ON PtCorrAccountItemGroup (CorrAccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCorrPartner context:any labels:c-any,o-table,ot-schema,on-PtCorrPartner,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCorrPartner
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCorrPartner_PartnerId%')
BEGIN
    CREATE INDEX IX_PtCorrPartner_PartnerId
    ON PtCorrPartner (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCorrPartnerItemGroup context:any labels:c-any,o-table,ot-schema,on-PtCorrPartnerItemGroup,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCorrPartnerItemGroup
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCorrPartnerItemGroup_CorrPartnerId%')
BEGIN
    CREATE INDEX IX_PtCorrPartnerItemGroup_CorrPartnerId
    ON PtCorrPartnerItemGroup (CorrPartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCorrPortfolio context:any labels:c-any,o-table,ot-schema,on-PtCorrPortfolio,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCorrPortfolio
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCorrPortfolio_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtCorrPortfolio_PortfolioId
    ON PtCorrPortfolio (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtCorrPortfolioItemGroup context:any labels:c-any,o-table,ot-schema,on-PtCorrPortfolioItemGroup,fin-13659 runOnChange:true
--comment: Create navigation index on table PtCorrPortfolioItemGroup
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtCorrPortfolioItemGroup_CorrPortfolioId%')
BEGIN
    CREATE INDEX IX_PtCorrPortfolioItemGroup_CorrPortfolioId
    ON PtCorrPortfolioItemGroup (CorrPortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoBoard context:any labels:c-any,o-table,ot-schema,on-PtEcoBoard,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoBoard
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoBoard_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoBoard_EcoId
    ON PtEcoBoard (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoBusinessLine context:any labels:c-any,o-table,ot-schema,on-PtEcoBusinessLine,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoBusinessLine
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoBusinessLine_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoBusinessLine_EcoId
    ON PtEcoBusinessLine (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoManagement context:any labels:c-any,o-table,ot-schema,on-PtEcoManagement,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoManagement
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoManagement_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoManagement_EcoId
    ON PtEcoManagement (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoNews context:any labels:c-any,o-table,ot-schema,on-PtEcoNews,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoNews
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoNews_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoNews_EcoId
    ON PtEcoNews (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoOwner context:any labels:c-any,o-table,ot-schema,on-PtEcoOwner,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoOwner
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoOwner_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoOwner_EcoId
    ON PtEcoOwner (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoParticipation context:any labels:c-any,o-table,ot-schema,on-PtEcoParticipation,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoParticipation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoParticipation_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoParticipation_EcoId
    ON PtEcoParticipation (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoPortrait context:any labels:c-any,o-table,ot-schema,on-PtEcoPortrait,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoPortrait
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoPortrait_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoPortrait_EcoId
    ON PtEcoPortrait (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEcoPubl context:any labels:c-any,o-table,ot-schema,on-PtEcoPubl,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEcoPubl
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEcoPubl_EcoId%')
BEGIN
    CREATE INDEX IX_PtEcoPubl_EcoId
    ON PtEcoPubl (EcoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtEMailAddress context:any labels:c-any,o-table,ot-schema,on-PtEMailAddress,fin-13659 runOnChange:true
--comment: Create navigation index on table PtEMailAddress
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtEMailAddress_PartnerId%')
BEGIN
    CREATE INDEX IX_PtEMailAddress_PartnerId
    ON PtEMailAddress (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtESGPreference context:any labels:c-any,o-table,ot-schema,on-PtESGPreference,fin-13659 runOnChange:true
--comment: Create navigation index on table PtESGPreference
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtESGPreference_PartnerId%')
BEGIN
    CREATE INDEX IX_PtESGPreference_PartnerId
    ON PtESGPreference (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtExternalALInfo context:any labels:c-any,o-table,ot-schema,on-PtExternalALInfo,fin-13659 runOnChange:true
--comment: Create navigation index on table PtExternalALInfo
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtExternalALInfo_PartnerId%')
BEGIN
    CREATE INDEX IX_PtExternalALInfo_PartnerId
    ON PtExternalALInfo (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtFiscalCountry context:any labels:c-any,o-table,ot-schema,on-PtFiscalCountry,fin-13659 runOnChange:true
--comment: Create navigation index on table PtFiscalCountry
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtFiscalCountry_PartnerId%')
BEGIN
    CREATE INDEX IX_PtFiscalCountry_PartnerId
    ON PtFiscalCountry (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtFiscalDomicile context:any labels:c-any,o-table,ot-schema,on-PtFiscalDomicile,fin-13659 runOnChange:true
--comment: Create navigation index on table PtFiscalDomicile
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtFiscalDomicile_PartnerId%')
BEGIN
    CREATE INDEX IX_PtFiscalDomicile_PartnerId
    ON PtFiscalDomicile (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtFormOrder context:any labels:c-any,o-table,ot-schema,on-PtFormOrder,fin-13659 runOnChange:true
--comment: Create navigation index on table PtFormOrder
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtFormOrder_PartnerId%')
BEGIN
    CREATE INDEX IX_PtFormOrder_PartnerId
    ON PtFormOrder (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtGeneralLimit context:any labels:c-any,o-table,ot-schema,on-PtGeneralLimit,fin-13659 runOnChange:true
--comment: Create navigation index on table PtGeneralLimit
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtGeneralLimit_PartnerId%')
BEGIN
    CREATE INDEX IX_PtGeneralLimit_PartnerId
    ON PtGeneralLimit (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtHobby context:any labels:c-any,o-table,ot-schema,on-PtHobby,fin-13659 runOnChange:true
--comment: Create navigation index on table PtHobby
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtHobby_PartnerId%')
BEGIN
    CREATE INDEX IX_PtHobby_PartnerId
    ON PtHobby (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtHomePlace context:any labels:c-any,o-table,ot-schema,on-PtHomePlace,fin-13659 runOnChange:true
--comment: Create navigation index on table PtHomePlace
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtHomePlace_PartnerId%')
BEGIN
    CREATE INDEX IX_PtHomePlace_PartnerId
    ON PtHomePlace (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtIdentification context:any labels:c-any,o-table,ot-schema,on-PtIdentification,fin-13659 runOnChange:true
--comment: Create navigation index on table PtIdentification
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtIdentification_PartnerId%')
BEGIN
    CREATE INDEX IX_PtIdentification_PartnerId
    ON PtIdentification (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtIdentificationExternal context:any labels:c-any,o-table,ot-schema,on-PtIdentificationExternal,fin-13659 runOnChange:true
--comment: Create navigation index on table PtIdentificationExternal
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtIdentificationExternal_PartnerId%')
BEGIN
    CREATE INDEX IX_PtIdentificationExternal_PartnerId
    ON PtIdentificationExternal (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtInfoPoolAccount context:any labels:c-any,o-table,ot-schema,on-PtInfoPoolAccount,fin-13659 runOnChange:true
--comment: Create navigation index on table PtInfoPoolAccount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtInfoPoolAccount_AccountId%')
BEGIN
    CREATE INDEX IX_PtInfoPoolAccount_AccountId
    ON PtInfoPoolAccount (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtInfoPoolPartner context:any labels:c-any,o-table,ot-schema,on-PtInfoPoolPartner,fin-13659 runOnChange:true
--comment: Create navigation index on table PtInfoPoolPartner
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtInfoPoolPartner_PartnerId%')
BEGIN
    CREATE INDEX IX_PtInfoPoolPartner_PartnerId
    ON PtInfoPoolPartner (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtInfoPoolPortfolio context:any labels:c-any,o-table,ot-schema,on-PtInfoPoolPortfolio,fin-13659 runOnChange:true
--comment: Create navigation index on table PtInfoPoolPortfolio
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtInfoPoolPortfolio_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtInfoPoolPortfolio_PortfolioId
    ON PtInfoPoolPortfolio (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtInstituteName context:any labels:c-any,o-table,ot-schema,on-PtInstituteName,fin-13659 runOnChange:true
--comment: Create navigation index on table PtInstituteName
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtInstituteName_PartnerId%')
BEGIN
    CREATE INDEX IX_PtInstituteName_PartnerId
    ON PtInstituteName (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtInvestmentKHExperience context:any labels:c-any,o-table,ot-schema,on-PtInvestmentKHExperience,fin-13659 runOnChange:true
--comment: Create navigation index on table PtInvestmentKHExperience
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtInvestmentKHExperience_ProfileId%')
BEGIN
    CREATE INDEX IX_PtInvestmentKHExperience_ProfileId
    ON PtInvestmentKHExperience (ProfileId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtInvestmentRiskProfile context:any labels:c-any,o-table,ot-schema,on-PtInvestmentRiskProfile,fin-13659 runOnChange:true
--comment: Create navigation index on table PtInvestmentRiskProfile
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtInvestmentRiskProfile_PartnerId%')
BEGIN
    CREATE INDEX IX_PtInvestmentRiskProfile_PartnerId
    ON PtInvestmentRiskProfile (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtLiabilities context:any labels:c-any,o-table,ot-schema,on-PtLiabilities,fin-13659 runOnChange:true
--comment: Create navigation index on table PtLiabilities
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtLiabilities_PartnerId%')
BEGIN
    CREATE INDEX IX_PtLiabilities_PartnerId
    ON PtLiabilities (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtMLMonitoringLog context:any labels:c-any,o-table,ot-schema,on-PtMLMonitoringLog,fin-13659 runOnChange:true
--comment: Create navigation index on table PtMLMonitoringLog
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtMLMonitoringLog_PartnerId%')
BEGIN
    CREATE INDEX IX_PtMLMonitoringLog_PartnerId
    ON PtMLMonitoringLog (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtMLPeriodicCheck context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheck,fin-13659 runOnChange:true
--comment: Create navigation index on table PtMLPeriodicCheck
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtMLPeriodicCheck_PeriodicCheckOverviewId%')
BEGIN
    CREATE INDEX IX_PtMLPeriodicCheck_PeriodicCheckOverviewId
    ON PtMLPeriodicCheck (PeriodicCheckOverviewId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtMLPeriodicCheckOverview context:any labels:c-any,o-table,ot-schema,on-PtMLPeriodicCheckOverview,fin-13659 runOnChange:true
--comment: Create navigation index on table PtMLPeriodicCheckOverview
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtMLPeriodicCheckOverview_PartnerId%')
BEGIN
    CREATE INDEX IX_PtMLPeriodicCheckOverview_PartnerId
    ON PtMLPeriodicCheckOverview (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtMLRecommendations context:any labels:c-any,o-table,ot-schema,on-PtMLRecommendations,fin-13659 runOnChange:true
--comment: Create navigation index on table PtMLRecommendations
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtMLRecommendations_ProfileId%')
BEGIN
    CREATE INDEX IX_PtMLRecommendations_ProfileId
    ON PtMLRecommendations (ProfileId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtNationality context:any labels:c-any,o-table,ot-schema,on-PtNationality,fin-13659 runOnChange:true
--comment: Create navigation index on table PtNationality
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtNationality_PartnerId%')
BEGIN
    CREATE INDEX IX_PtNationality_PartnerId
    ON PtNationality (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtOfferNewAddInfo context:any labels:c-any,o-table,ot-schema,on-PtOfferNewAddInfo,fin-13659 runOnChange:true
--comment: Create navigation index on table PtOfferNewAddInfo
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtOfferNewAddInfo_PartnerId%')
BEGIN
    CREATE INDEX IX_PtOfferNewAddInfo_PartnerId
    ON PtOfferNewAddInfo (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtOfferNotes context:any labels:c-any,o-table,ot-schema,on-PtOfferNotes,fin-13659 runOnChange:true
--comment: Create navigation index on table PtOfferNotes
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtOfferNotes_EbInfoId%')
BEGIN
    CREATE INDEX IX_PtOfferNotes_EbInfoId
    ON PtOfferNotes (EbInfoId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtOfferVariationComp context:any labels:c-any,o-table,ot-schema,on-PtOfferVariationComp,fin-13659 runOnChange:true
--comment: Create navigation index on table PtOfferVariationComp
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtOfferVariationComp_VariationId%')
BEGIN
    CREATE INDEX IX_PtOfferVariationComp_VariationId
    ON PtOfferVariationComp (VariationId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtOfficialMeeting context:any labels:c-any,o-table,ot-schema,on-PtOfficialMeeting,fin-13659 runOnChange:true
--comment: Create navigation index on table PtOfficialMeeting
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtOfficialMeeting_PartnerId%')
BEGIN
    CREATE INDEX IX_PtOfficialMeeting_PartnerId
    ON PtOfficialMeeting (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtOpenIssue context:any labels:c-any,o-table,ot-schema,on-PtOpenIssue,fin-13659 runOnChange:true
--comment: Create navigation index on table PtOpenIssue
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtOpenIssue_PartnerId%')
BEGIN
    CREATE INDEX IX_PtOpenIssue_PartnerId
    ON PtOpenIssue (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPartnerProcRule context:any labels:c-any,o-table,ot-schema,on-PtPartnerProcRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPartnerProcRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPartnerProcRule_PartnerId%')
BEGIN
    CREATE INDEX IX_PtPartnerProcRule_PartnerId
    ON PtPartnerProcRule (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPhoneNumber context:any labels:c-any,o-table,ot-schema,on-PtPhoneNumber,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPhoneNumber
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPhoneNumber_PartnerId%')
BEGIN
    CREATE INDEX IX_PtPhoneNumber_PartnerId
    ON PtPhoneNumber (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPKICert context:any labels:c-any,o-table,ot-schema,on-PtPKICert,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPKICert
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPKICert_AgrPkiId%')
BEGIN
    CREATE INDEX IX_PtPKICert_AgrPkiId
    ON PtPKICert (AgrPkiId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPortfolioCurrencyChange context:any labels:c-any,o-table,ot-schema,on-PtPortfolioCurrencyChange,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPortfolioCurrencyChange
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPortfolioCurrencyChange_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtPortfolioCurrencyChange_PortfolioId
    ON PtPortfolioCurrencyChange (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPortfolioKeyFigure context:any labels:c-any,o-table,ot-schema,on-PtPortfolioKeyFigure,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPortfolioKeyFigure
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPortfolioKeyFigure_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtPortfolioKeyFigure_PortfolioId
    ON PtPortfolioKeyFigure (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPortfolioPaymentRule context:any labels:c-any,o-table,ot-schema,on-PtPortfolioPaymentRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPortfolioPaymentRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPortfolioPaymentRule_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtPortfolioPaymentRule_PortfolioId
    ON PtPortfolioPaymentRule (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtPortfolioProcRule context:any labels:c-any,o-table,ot-schema,on-PtPortfolioProcRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtPortfolioProcRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtPortfolioProcRule_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtPortfolioProcRule_PortfolioId
    ON PtPortfolioProcRule (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtProfileSuspect context:any labels:c-any,o-table,ot-schema,on-PtProfileSuspect,fin-13659 runOnChange:true
--comment: Create navigation index on table PtProfileSuspect
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtProfileSuspect_ProfileId%')
BEGIN
    CREATE INDEX IX_PtProfileSuspect_ProfileId
    ON PtProfileSuspect (ProfileId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtRating context:any labels:c-any,o-table,ot-schema,on-PtRating,fin-13659 runOnChange:true
--comment: Create navigation index on table PtRating
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtRating_PartnerId%')
BEGIN
    CREATE INDEX IX_PtRating_PartnerId
    ON PtRating (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtRatingConsolidation context:any labels:c-any,o-table,ot-schema,on-PtRatingConsolidation,fin-13659 runOnChange:true
--comment: Create navigation index on table PtRatingConsolidation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtRatingConsolidation_PartnerId%')
BEGIN
    CREATE INDEX IX_PtRatingConsolidation_PartnerId
    ON PtRatingConsolidation (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtRecognition context:any labels:c-any,o-table,ot-schema,on-PtRecognition,fin-13659 runOnChange:true
--comment: Create navigation index on table PtRecognition
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtRecognition_PartnerId%')
BEGIN
    CREATE INDEX IX_PtRecognition_PartnerId
    ON PtRecognition (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtRelationSlave context:any labels:c-any,o-table,ot-schema,on-PtRelationSlave,fin-13659 runOnChange:true
--comment: Create navigation index on table PtRelationSlave
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtRelationSlave_MasterId%')
BEGIN
    CREATE INDEX IX_PtRelationSlave_MasterId
    ON PtRelationSlave (MasterId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtSafeDepositVisit context:any labels:c-any,o-table,ot-schema,on-PtSafeDepositVisit,fin-13659 runOnChange:true
--comment: Create navigation index on table PtSafeDepositVisit
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtSafeDepositVisit_AgrSafeDepositBoxId%')
BEGIN
    CREATE INDEX IX_PtSafeDepositVisit_AgrSafeDepositBoxId
    ON PtSafeDepositVisit (AgrSafeDepositBoxId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtShadowAccount context:any labels:c-any,o-table,ot-schema,on-PtShadowAccount,fin-13659 runOnChange:true
--comment: Create navigation index on table PtShadowAccount
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtShadowAccount_PortfolioId%')
BEGIN
    CREATE INDEX IX_PtShadowAccount_PortfolioId
    ON PtShadowAccount (PortfolioId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtStandingOrder context:any labels:c-any,o-table,ot-schema,on-PtStandingOrder,fin-13659 runOnChange:true
--comment: Create navigation index on table PtStandingOrder
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtStandingOrder_AccountId%')
BEGIN
    CREATE INDEX IX_PtStandingOrder_AccountId
    ON PtStandingOrder (AccountId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtStandingOrderDetail context:any labels:c-any,o-table,ot-schema,on-PtStandingOrderDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table PtStandingOrderDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtStandingOrderDetail_StandingOrderId%')
BEGIN
    CREATE INDEX IX_PtStandingOrderDetail_StandingOrderId
    ON PtStandingOrderDetail (StandingOrderId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtSubmission context:any labels:c-any,o-table,ot-schema,on-PtSubmission,fin-13659 runOnChange:true
--comment: Create navigation index on table PtSubmission
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtSubmission_PartnerId%')
BEGIN
    CREATE INDEX IX_PtSubmission_PartnerId
    ON PtSubmission (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtTabu context:any labels:c-any,o-table,ot-schema,on-PtTabu,fin-13659 runOnChange:true
--comment: Create navigation index on table PtTabu
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtTabu_PartnerId%')
BEGIN
    CREATE INDEX IX_PtTabu_PartnerId
    ON PtTabu (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtTaxRegOwner context:any labels:c-any,o-table,ot-schema,on-PtTaxRegOwner,fin-13659 runOnChange:true
--comment: Create navigation index on table PtTaxRegOwner
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtTaxRegOwner_TaxRegulationId%')
BEGIN
    CREATE INDEX IX_PtTaxRegOwner_TaxRegulationId
    ON PtTaxRegOwner (TaxRegulationId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtTaxRegulation context:any labels:c-any,o-table,ot-schema,on-PtTaxRegulation,fin-13659 runOnChange:true
--comment: Create navigation index on table PtTaxRegulation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtTaxRegulation_PartnerId%')
BEGIN
    CREATE INDEX IX_PtTaxRegulation_PartnerId
    ON PtTaxRegulation (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtTransSxContactReport context:any labels:c-any,o-table,ot-schema,on-PtTransSxContactReport,fin-13659 runOnChange:true
--comment: Create navigation index on table PtTransSxContactReport
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtTransSxContactReport_ContactReportId%')
BEGIN
    CREATE INDEX IX_PtTransSxContactReport_ContactReportId
    ON PtTransSxContactReport (ContactReportId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtUserTimeAssignment context:any labels:c-any,o-table,ot-schema,on-PtUserTimeAssignment,fin-13659 runOnChange:true
--comment: Create navigation index on table PtUserTimeAssignment
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtUserTimeAssignment_UserBaseId%')
BEGIN
    CREATE INDEX IX_PtUserTimeAssignment_UserBaseId
    ON PtUserTimeAssignment (UserBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtUserTimeFrame context:any labels:c-any,o-table,ot-schema,on-PtUserTimeFrame,fin-13659 runOnChange:true
--comment: Create navigation index on table PtUserTimeFrame
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtUserTimeFrame_UserBaseId%')
BEGIN
    CREATE INDEX IX_PtUserTimeFrame_UserBaseId
    ON PtUserTimeFrame (UserBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtUserTimeLog context:any labels:c-any,o-table,ot-schema,on-PtUserTimeLog,fin-13659 runOnChange:true
--comment: Create navigation index on table PtUserTimeLog
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtUserTimeLog_UserBaseId%')
BEGIN
    CREATE INDEX IX_PtUserTimeLog_UserBaseId
    ON PtUserTimeLog (UserBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtUserTimeRule context:any labels:c-any,o-table,ot-schema,on-PtUserTimeRule,fin-13659 runOnChange:true
--comment: Create navigation index on table PtUserTimeRule
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtUserTimeRule_UserBaseId%')
BEGIN
    CREATE INDEX IX_PtUserTimeRule_UserBaseId
    ON PtUserTimeRule (UserBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtUserTimeStatistic context:any labels:c-any,o-table,ot-schema,on-PtUserTimeStatistic,fin-13659 runOnChange:true
--comment: Create navigation index on table PtUserTimeStatistic
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtUserTimeStatistic_UserBaseId%')
BEGIN
    CREATE INDEX IX_PtUserTimeStatistic_UserBaseId
    ON PtUserTimeStatistic (UserBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-PtWebAddress context:any labels:c-any,o-table,ot-schema,on-PtWebAddress,fin-13659 runOnChange:true
--comment: Create navigation index on table PtWebAddress
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_PtWebAddress_PartnerId%')
BEGIN
    CREATE INDEX IX_PtWebAddress_PartnerId
    ON PtWebAddress (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBaseAttachment context:any labels:c-any,o-table,ot-schema,on-ReBaseAttachment,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBaseAttachment
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBaseAttachment_ReBaseId%')
BEGIN
    CREATE INDEX IX_ReBaseAttachment_ReBaseId
    ON ReBaseAttachment (ReBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBaseValues context:any labels:c-any,o-table,ot-schema,on-ReBaseValues,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBaseValues
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBaseValues_ReBaseId%')
BEGIN
    CREATE INDEX IX_ReBaseValues_ReBaseId
    ON ReBaseValues (ReBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBelong context:any labels:c-any,o-table,ot-schema,on-ReBelong,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBelong
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBelong_NoteId%')
BEGIN
    CREATE INDEX IX_ReBelong_NoteId
    ON ReBelong (NoteId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingAdd context:any labels:c-any,o-table,ot-schema,on-ReBuildingAdd,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingAdd
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingAdd_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingAdd_BuildingId
    ON ReBuildingAdd (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingAlteration context:any labels:c-any,o-table,ot-schema,on-ReBuildingAlteration,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingAlteration
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingAlteration_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingAlteration_BuildingId
    ON ReBuildingAlteration (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingConditionDetail context:any labels:c-any,o-table,ot-schema,on-ReBuildingConditionDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingConditionDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingConditionDetail_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingConditionDetail_BuildingId
    ON ReBuildingConditionDetail (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingDwellingTotal context:any labels:c-any,o-table,ot-schema,on-ReBuildingDwellingTotal,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingDwellingTotal
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingDwellingTotal_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingDwellingTotal_BuildingId
    ON ReBuildingDwellingTotal (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingPtRel context:any labels:c-any,o-table,ot-schema,on-ReBuildingPtRel,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingPtRel
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingPtRel_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingPtRel_BuildingId
    ON ReBuildingPtRel (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingQualityDetail context:any labels:c-any,o-table,ot-schema,on-ReBuildingQualityDetail,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingQualityDetail
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingQualityDetail_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingQualityDetail_BuildingId
    ON ReBuildingQualityDetail (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingRoom context:any labels:c-any,o-table,ot-schema,on-ReBuildingRoom,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingRoom
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingRoom_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingRoom_BuildingId
    ON ReBuildingRoom (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReBuildingValues context:any labels:c-any,o-table,ot-schema,on-ReBuildingValues,fin-13659 runOnChange:true
--comment: Create navigation index on table ReBuildingValues
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReBuildingValues_BuildingId%')
BEGIN
    CREATE INDEX IX_ReBuildingValues_BuildingId
    ON ReBuildingValues (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReConstruction context:any labels:c-any,o-table,ot-schema,on-ReConstruction,fin-13659 runOnChange:true
--comment: Create navigation index on table ReConstruction
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReConstruction_BuildingId%')
BEGIN
    CREATE INDEX IX_ReConstruction_BuildingId
    ON ReConstruction (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReCoProperty context:any labels:c-any,o-table,ot-schema,on-ReCoProperty,fin-13659 runOnChange:true
--comment: Create navigation index on table ReCoProperty
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReCoProperty_NoteId%')
BEGIN
    CREATE INDEX IX_ReCoProperty_NoteId
    ON ReCoProperty (NoteId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReDev context:any labels:c-any,o-table,ot-schema,on-ReDev,fin-13659 runOnChange:true
--comment: Create navigation index on table ReDev
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReDev_BuildingId%')
BEGIN
    CREATE INDEX IX_ReDev_BuildingId
    ON ReDev (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReDevelopmentDet context:any labels:c-any,o-table,ot-schema,on-ReDevelopmentDet,fin-13659 runOnChange:true
--comment: Create navigation index on table ReDevelopmentDet
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReDevelopmentDet_PremisesId%')
BEGIN
    CREATE INDEX IX_ReDevelopmentDet_PremisesId
    ON ReDevelopmentDet (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReDwelling context:any labels:c-any,o-table,ot-schema,on-ReDwelling,fin-13659 runOnChange:true
--comment: Create navigation index on table ReDwelling
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReDwelling_BuildingId%')
BEGIN
    CREATE INDEX IX_ReDwelling_BuildingId
    ON ReDwelling (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReEnvironmentAdd context:any labels:c-any,o-table,ot-schema,on-ReEnvironmentAdd,fin-13659 runOnChange:true
--comment: Create navigation index on table ReEnvironmentAdd
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReEnvironmentAdd_PremisesId%')
BEGIN
    CREATE INDEX IX_ReEnvironmentAdd_PremisesId
    ON ReEnvironmentAdd (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReIAZIValuation context:any labels:c-any,o-table,ot-schema,on-ReIAZIValuation,fin-13659 runOnChange:true
--comment: Create navigation index on table ReIAZIValuation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReIAZIValuation_PremisesId%')
BEGIN
    CREATE INDEX IX_ReIAZIValuation_PremisesId
    ON ReIAZIValuation (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReImmission context:any labels:c-any,o-table,ot-schema,on-ReImmission,fin-13659 runOnChange:true
--comment: Create navigation index on table ReImmission
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReImmission_PremisesId%')
BEGIN
    CREATE INDEX IX_ReImmission_PremisesId
    ON ReImmission (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReLand context:any labels:c-any,o-table,ot-schema,on-ReLand,fin-13659 runOnChange:true
--comment: Create navigation index on table ReLand
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReLand_PremisesId%')
BEGIN
    CREATE INDEX IX_ReLand_PremisesId
    ON ReLand (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReLegalLien context:any labels:c-any,o-table,ot-schema,on-ReLegalLien,fin-13659 runOnChange:true
--comment: Create navigation index on table ReLegalLien
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReLegalLien_PremisesId%')
BEGIN
    CREATE INDEX IX_ReLegalLien_PremisesId
    ON ReLegalLien (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReNote context:any labels:c-any,o-table,ot-schema,on-ReNote,fin-13659 runOnChange:true
--comment: Create navigation index on table ReNote
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReNote_PremisesId%')
BEGIN
    CREATE INDEX IX_ReNote_PremisesId
    ON ReNote (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReObligPremisesRelation context:any labels:c-any,o-table,ot-schema,on-ReObligPremisesRelation,fin-13659 runOnChange:true
--comment: Create navigation index on table ReObligPremisesRelation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReObligPremisesRelation_PremisesId%')
BEGIN
    CREATE INDEX IX_ReObligPremisesRelation_PremisesId
    ON ReObligPremisesRelation (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReOwner context:any labels:c-any,o-table,ot-schema,on-ReOwner,fin-13659 runOnChange:true
--comment: Create navigation index on table ReOwner
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReOwner_ReBaseId%')
BEGIN
    CREATE INDEX IX_ReOwner_ReBaseId
    ON ReOwner (ReBaseId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReParking context:any labels:c-any,o-table,ot-schema,on-ReParking,fin-13659 runOnChange:true
--comment: Create navigation index on table ReParking
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReParking_BuildingId%')
BEGIN
    CREATE INDEX IX_ReParking_BuildingId
    ON ReParking (BuildingId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePollution context:any labels:c-any,o-table,ot-schema,on-RePollution,fin-13659 runOnChange:true
--comment: Create navigation index on table RePollution
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePollution_PremisesId%')
BEGIN
    CREATE INDEX IX_RePollution_PremisesId
    ON RePollution (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesAttachment context:any labels:c-any,o-table,ot-schema,on-RePremisesAttachment,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesAttachment
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesAttachment_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesAttachment_PremisesId
    ON RePremisesAttachment (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesPtRel context:any labels:c-any,o-table,ot-schema,on-RePremisesPtRel,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesPtRel
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesPtRel_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesPtRel_PremisesId
    ON RePremisesPtRel (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesRelOblig context:any labels:c-any,o-table,ot-schema,on-RePremisesRelOblig,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesRelOblig
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesRelOblig_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesRelOblig_PremisesId
    ON RePremisesRelOblig (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesRelRight context:any labels:c-any,o-table,ot-schema,on-RePremisesRelRight,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesRelRight
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesRelRight_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesRelRight_PremisesId
    ON RePremisesRelRight (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesRelRightToBuild context:any labels:c-any,o-table,ot-schema,on-RePremisesRelRightToBuild,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesRelRightToBuild
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesRelRightToBuild_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesRelRightToBuild_PremisesId
    ON RePremisesRelRightToBuild (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesRelSTWE context:any labels:c-any,o-table,ot-schema,on-RePremisesRelSTWE,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesRelSTWE
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesRelSTWE_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesRelSTWE_PremisesId
    ON RePremisesRelSTWE (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesROICalculation context:any labels:c-any,o-table,ot-schema,on-RePremisesROICalculation,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesROICalculation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesROICalculation_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesROICalculation_PremisesId
    ON RePremisesROICalculation (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-RePremisesValues context:any labels:c-any,o-table,ot-schema,on-RePremisesValues,fin-13659 runOnChange:true
--comment: Create navigation index on table RePremisesValues
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_RePremisesValues_PremisesId%')
BEGIN
    CREATE INDEX IX_RePremisesValues_PremisesId
    ON RePremisesValues (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReRes context:any labels:c-any,o-table,ot-schema,on-ReRes,fin-13659 runOnChange:true
--comment: Create navigation index on table ReRes
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReRes_PremisesId%')
BEGIN
    CREATE INDEX IX_ReRes_PremisesId
    ON ReRes (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReSituation context:any labels:c-any,o-table,ot-schema,on-ReSituation,fin-13659 runOnChange:true
--comment: Create navigation index on table ReSituation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReSituation_PremisesId%')
BEGIN
    CREATE INDEX IX_ReSituation_PremisesId
    ON ReSituation (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReValuation context:any labels:c-any,o-table,ot-schema,on-ReValuation,fin-13659 runOnChange:true
--comment: Create navigation index on table ReValuation
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReValuation_PremisesId%')
BEGIN
    CREATE INDEX IX_ReValuation_PremisesId
    ON ReValuation (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-ReValuationExt context:any labels:c-any,o-table,ot-schema,on-ReValuationExt,fin-13659 runOnChange:true
--comment: Create navigation index on table ReValuationExt
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_ReValuationExt_PremisesId%')
BEGIN
    CREATE INDEX IX_ReValuationExt_PremisesId
    ON ReValuationExt (PremisesId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-TdOrders context:any labels:c-any,o-table,ot-schema,on-TdOrders,fin-13659 runOnChange:true
--comment: Create navigation index on table TdOrders
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_TdOrders_PartnerId%')
BEGIN
    CREATE INDEX IX_TdOrders_PartnerId
    ON TdOrders (PartnerId)
    ON FsIndex
END

--changeset system:generated-create-navigation-index-Test context:any labels:c-any,o-table,ot-schema,on-Test,fin-13659 runOnChange:true
--comment: Create navigation index on table Test
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name like 'IX_Test_CurSharedNode%')
BEGIN
    CREATE INDEX IX_Test_CurSharedNode
    ON Test (CurSharedNode)
    ON FsIndex
END
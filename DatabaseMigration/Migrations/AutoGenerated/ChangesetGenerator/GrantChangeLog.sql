--liquibase formatted sql

--changeset system:generated-create-fseb-role context:any labels:c-any,o-permission,ot-schema,on-General,fin-13659 runOnChange:true
--comment: Create FsEb role if it doesn't exist
IF NOT EXISTS(SELECT * FROM sys.database_principals WHERE Name = 'FsEb' AND Type = 'R')
BEGIN
    CREATE ROLE FsEb
END

--changeset system:generated-create-grant-AsDocument context:any labels:c-any,o-permission,ot-schema,on-AsDocument,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsDocument
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsDocument')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsDocument FROM FsEb
  GRANT INSERT, UPDATE ON AsDocument TO FsEb
END

--changeset system:generated-create-grant-AsDocumentAccess context:any labels:c-any,o-permission,ot-schema,on-AsDocumentAccess,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsDocumentAccess
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsDocumentAccess')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsDocumentAccess FROM FsEb
  GRANT INSERT, UPDATE ON AsDocumentAccess TO FsEb
END

--changeset system:generated-create-grant-AsDocumentData_O context:any labels:c-any,o-permission,ot-schema,on-AsDocumentData_O,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsDocumentData_O
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsDocumentData_O')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsDocumentData_O FROM FsEb
  GRANT INSERT, UPDATE ON AsDocumentData_O TO FsEb
END

--changeset system:generated-create-grant-AsDocumentIndex context:any labels:c-any,o-permission,ot-schema,on-AsDocumentIndex,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsDocumentIndex
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsDocumentIndex')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsDocumentIndex FROM FsEb
  GRANT INSERT, UPDATE ON AsDocumentIndex TO FsEb
END

--changeset system:generated-create-grant-AsHistory context:any labels:c-any,o-permission,ot-schema,on-AsHistory,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsHistory
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsHistory')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsHistory FROM FsEb
  GRANT INSERT, UPDATE ON AsHistory TO FsEb
END

--changeset system:generated-create-grant-AsNavigationIndex context:any labels:c-any,o-permission,ot-schema,on-AsNavigationIndex,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsNavigationIndex
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsNavigationIndex')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsNavigationIndex FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON AsNavigationIndex TO FsEb
END

--changeset system:generated-create-grant-AsNavigationIndexSub context:any labels:c-any,o-permission,ot-schema,on-AsNavigationIndexSub,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsNavigationIndexSub
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsNavigationIndexSub')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsNavigationIndexSub FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON AsNavigationIndexSub TO FsEb
END

--changeset system:generated-create-grant-AsPayee context:any labels:c-any,o-permission,ot-schema,on-AsPayee,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table AsPayee
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AsPayee')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON AsPayee FROM FsEb
  GRANT INSERT, UPDATE ON AsPayee TO FsEb
END

--changeset system:generated-create-grant-BpJobWorkItem context:any labels:c-any,o-permission,ot-schema,on-BpJobWorkItem,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table BpJobWorkItem
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BpJobWorkItem')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON BpJobWorkItem FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON BpJobWorkItem TO FsEb
END

--changeset system:generated-create-grant-CMFileConfirmation context:any labels:c-any,o-permission,ot-schema,on-CMFileConfirmation,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table CMFileConfirmation
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CMFileConfirmation')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON CMFileConfirmation FROM FsEb
  GRANT INSERT, UPDATE ON CMFileConfirmation TO FsEb
END

--changeset system:generated-create-grant-CMFileImportError context:any labels:c-any,o-permission,ot-schema,on-CMFileImportError,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table CMFileImportError
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CMFileImportError')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON CMFileImportError FROM FsEb
  GRANT INSERT, UPDATE ON CMFileImportError TO FsEb
END

--changeset system:generated-create-grant-CMFileImportPaymentError context:any labels:c-any,o-permission,ot-schema,on-CMFileImportPaymentError,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table CMFileImportPaymentError
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CMFileImportPaymentError')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON CMFileImportPaymentError FROM FsEb
  GRANT INSERT, UPDATE ON CMFileImportPaymentError TO FsEb
END

--changeset system:generated-create-grant-CMFileImportProcess context:any labels:c-any,o-permission,ot-schema,on-CMFileImportProcess,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table CMFileImportProcess
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CMFileImportProcess')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON CMFileImportProcess FROM FsEb
  GRANT INSERT, UPDATE ON CMFileImportProcess TO FsEb
END

--changeset system:generated-create-grant-CMPainImportStatus context:any labels:c-any,o-permission,ot-schema,on-CMPainImportStatus,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table CMPainImportStatus
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CMPainImportStatus')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON CMPainImportStatus FROM FsEb
  GRANT INSERT, UPDATE ON CMPainImportStatus TO FsEb
END

--changeset system:generated-create-grant-CyCashOrderPlacement context:any labels:c-any,o-permission,ot-schema,on-CyCashOrderPlacement,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table CyCashOrderPlacement
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CyCashOrderPlacement')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON CyCashOrderPlacement FROM FsEb
  GRANT INSERT, UPDATE ON CyCashOrderPlacement TO FsEb
END

--changeset system:generated-create-grant-IfCamtDownloadHistory context:any labels:c-any,o-permission,ot-schema,on-IfCamtDownloadHistory,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfCamtDownloadHistory
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfCamtDownloadHistory')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfCamtDownloadHistory FROM FsEb
  GRANT INSERT, UPDATE ON IfCamtDownloadHistory TO FsEb
END

--changeset system:generated-create-grant-IfCamtDownloadHistoryAssoc context:any labels:c-any,o-permission,ot-schema,on-IfCamtDownloadHistoryAssoc,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfCamtDownloadHistoryAssoc
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfCamtDownloadHistoryAssoc')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfCamtDownloadHistoryAssoc FROM FsEb
  GRANT INSERT, UPDATE ON IfCamtDownloadHistoryAssoc TO FsEb
END

--changeset system:generated-create-grant-IfDeliveryDataHistory context:any labels:c-any,o-permission,ot-schema,on-IfDeliveryDataHistory,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliveryDataHistory
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliveryDataHistory')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliveryDataHistory FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliveryDataHistory TO FsEb
END

--changeset system:generated-create-grant-IfDeliveryDetailHistory context:any labels:c-any,o-permission,ot-schema,on-IfDeliveryDetailHistory,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliveryDetailHistory
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliveryDetailHistory')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliveryDetailHistory FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliveryDetailHistory TO FsEb
END

--changeset system:generated-create-grant-IfDeliveryDocumentData context:any labels:c-any,o-permission,ot-schema,on-IfDeliveryDocumentData,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliveryDocumentData
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliveryDocumentData')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliveryDocumentData FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliveryDocumentData TO FsEb
END

--changeset system:generated-create-grant-IfDeliveryHistory context:any labels:c-any,o-permission,ot-schema,on-IfDeliveryHistory,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliveryHistory
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliveryHistory')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliveryHistory FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliveryHistory TO FsEb
END

--changeset system:generated-create-grant-IfDeliveryHistoryAssoc context:any labels:c-any,o-permission,ot-schema,on-IfDeliveryHistoryAssoc,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliveryHistoryAssoc
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliveryHistoryAssoc')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliveryHistoryAssoc FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliveryHistoryAssoc TO FsEb
END

--changeset system:generated-create-grant-IfDeliveryItem context:any labels:c-any,o-permission,ot-schema,on-IfDeliveryItem,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliveryItem
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliveryItem')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliveryItem FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliveryItem TO FsEb
END

--changeset system:generated-create-grant-IfDeliverySetting context:any labels:c-any,o-permission,ot-schema,on-IfDeliverySetting,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table IfDeliverySetting
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'IfDeliverySetting')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON IfDeliverySetting FROM FsEb
  GRANT INSERT, UPDATE ON IfDeliverySetting TO FsEb
END

--changeset system:generated-create-grant-MsGoiOutMsg context:any labels:c-any,o-permission,ot-schema,on-MsGoiOutMsg,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table MsGoiOutMsg
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MsGoiOutMsg')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON MsGoiOutMsg FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON MsGoiOutMsg TO FsEb
END

--changeset system:generated-create-grant-MsGoiOutTraderMsg context:any labels:c-any,o-permission,ot-schema,on-MsGoiOutTraderMsg,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table MsGoiOutTraderMsg
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MsGoiOutTraderMsg')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON MsGoiOutTraderMsg FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON MsGoiOutTraderMsg TO FsEb
END

--changeset system:generated-create-grant-MsIntEventOutboxMsg context:any labels:c-any,o-permission,ot-schema,on-MsIntEventOutboxMsg,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table MsIntEventOutboxMsg
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MsIntEventOutboxMsg')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON MsIntEventOutboxMsg FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON MsIntEventOutboxMsg TO FsEb
END

--changeset system:generated-create-grant-OaAgrApp context:any labels:c-any,o-permission,ot-schema,on-OaAgrApp,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaAgrApp
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaAgrApp')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaAgrApp FROM FsEb
  GRANT INSERT, UPDATE ON OaAgrApp TO FsEb
END

--changeset system:generated-create-grant-OaAgrIdpUser context:any labels:c-any,o-permission,ot-schema,on-OaAgrIdpUser,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaAgrIdpUser
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaAgrIdpUser')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaAgrIdpUser FROM FsEb
  GRANT INSERT, UPDATE ON OaAgrIdpUser TO FsEb
END

--changeset system:generated-create-grant-OaIdempotencyStore context:any labels:c-any,o-permission,ot-schema,on-OaIdempotencyStore,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaIdempotencyStore
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaIdempotencyStore')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaIdempotencyStore FROM FsEb
  GRANT INSERT, UPDATE ON OaIdempotencyStore TO FsEb
END

--changeset system:generated-create-grant-OaNotificationRule context:any labels:c-any,o-permission,ot-schema,on-OaNotificationRule,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaNotificationRule
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaNotificationRule')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaNotificationRule FROM FsEb
  GRANT INSERT, UPDATE ON OaNotificationRule TO FsEb
END

--changeset system:generated-create-grant-OaNotificationTrigger context:any labels:c-any,o-permission,ot-schema,on-OaNotificationTrigger,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaNotificationTrigger
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaNotificationTrigger')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaNotificationTrigger FROM FsEb
  GRANT INSERT, UPDATE ON OaNotificationTrigger TO FsEb
END

--changeset system:generated-create-grant-OaSessionCache context:any labels:c-any,o-permission,ot-schema,on-OaSessionCache,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaSessionCache
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaSessionCache')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaSessionCache FROM FsEb
  GRANT INSERT, UPDATE ON OaSessionCache TO FsEb
END

--changeset system:generated-create-grant-OaTwoFaFuturaeSession context:any labels:c-any,o-permission,ot-schema,on-OaTwoFaFuturaeSession,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaTwoFaFuturaeSession
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaTwoFaFuturaeSession')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaTwoFaFuturaeSession FROM FsEb
  GRANT INSERT, UPDATE ON OaTwoFaFuturaeSession TO FsEb
END

--changeset system:generated-create-grant-OaTwoFaSession context:any labels:c-any,o-permission,ot-schema,on-OaTwoFaSession,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaTwoFaSession
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaTwoFaSession')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaTwoFaSession FROM FsEb
  GRANT INSERT, UPDATE ON OaTwoFaSession TO FsEb
END

--changeset system:generated-create-grant-OaTwoFaTransLog context:any labels:c-any,o-permission,ot-schema,on-OaTwoFaTransLog,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaTwoFaTransLog
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaTwoFaTransLog')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaTwoFaTransLog FROM FsEb
  GRANT INSERT, UPDATE ON OaTwoFaTransLog TO FsEb
END

--changeset system:generated-create-grant-OaTwoFaTransLogResult context:any labels:c-any,o-permission,ot-schema,on-OaTwoFaTransLogResult,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table OaTwoFaTransLogResult
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OaTwoFaTransLogResult')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON OaTwoFaTransLogResult FROM FsEb
  GRANT INSERT, UPDATE ON OaTwoFaTransLogResult TO FsEb
END

--changeset system:generated-create-grant-PrPublicListing context:any labels:c-any,o-permission,ot-schema,on-PrPublicListing,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PrPublicListing
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PrPublicListing')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PrPublicListing FROM FsEb
  GRANT INSERT, UPDATE ON PrPublicListing TO FsEb
END

--changeset system:generated-create-grant-PrReference context:any labels:c-any,o-permission,ot-schema,on-PrReference,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PrReference
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PrReference')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PrReference FROM FsEb
  GRANT INSERT, UPDATE ON PrReference TO FsEb
END

--changeset system:generated-create-grant-PtAccountBase context:any labels:c-any,o-permission,ot-schema,on-PtAccountBase,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAccountBase
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAccountBase')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAccountBase FROM FsEb
  GRANT INSERT, UPDATE ON PtAccountBase TO FsEb
END

--changeset system:generated-create-grant-PtAgrAnnouncement context:any labels:c-any,o-permission,ot-schema,on-PtAgrAnnouncement,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrAnnouncement
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrAnnouncement')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrAnnouncement FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrAnnouncement TO FsEb
END

--changeset system:generated-create-grant-PtAgrAnnouncement2Agr2TnC context:any labels:c-any,o-permission,ot-schema,on-PtAgrAnnouncement2Agr2TnC,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrAnnouncement2Agr2TnC
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrAnnouncement2Agr2TnC')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrAnnouncement2Agr2TnC FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrAnnouncement2Agr2TnC TO FsEb
END

--changeset system:generated-create-grant-PtAgrCard context:any labels:c-any,o-permission,ot-schema,on-PtAgrCard,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrCard
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrCard')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrCard FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrCard TO FsEb
END

--changeset system:generated-create-grant-PtAgrEBanking context:any labels:c-any,o-permission,ot-schema,on-PtAgrEBanking,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrEBanking
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrEBanking')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrEBanking FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrEBanking TO FsEb
END

--changeset system:generated-create-grant-PtAgrEBankingDetail context:any labels:c-any,o-permission,ot-schema,on-PtAgrEBankingDetail,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrEBankingDetail
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrEBankingDetail')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrEBankingDetail FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrEBankingDetail TO FsEb
END

--changeset system:generated-create-grant-PtAgrEBankingDetailCfg context:any labels:c-any,o-permission,ot-schema,on-PtAgrEBankingDetailCfg,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrEBankingDetailCfg
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrEBankingDetailCfg')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrEBankingDetailCfg FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrEBankingDetailCfg TO FsEb
END

--changeset system:generated-create-grant-PtAgrEBankingObProvider context:any labels:c-any,o-permission,ot-schema,on-PtAgrEBankingObProvider,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrEBankingObProvider
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrEBankingObProvider')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrEBankingObProvider FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrEBankingObProvider TO FsEb
END

--changeset system:generated-create-grant-PtAgrEBankingSettings context:any labels:c-any,o-permission,ot-schema,on-PtAgrEBankingSettings,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrEBankingSettings
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrEBankingSettings')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrEBankingSettings FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrEBankingSettings TO FsEb
END

--changeset system:generated-create-grant-PtAgrSecureList context:any labels:c-any,o-permission,ot-schema,on-PtAgrSecureList,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrSecureList
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrSecureList')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrSecureList FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrSecureList TO FsEb
END

--changeset system:generated-create-grant-PtAgrSecureListAstTransHist context:any labels:c-any,o-permission,ot-schema,on-PtAgrSecureListAstTransHist,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrSecureListAstTransHist
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrSecureListAstTransHist')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrSecureListAstTransHist FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrSecureListAstTransHist TO FsEb
END

--changeset system:generated-create-grant-PtAgrSecureListMobileCodeHist context:any labels:c-any,o-permission,ot-schema,on-PtAgrSecureListMobileCodeHist,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrSecureListMobileCodeHist
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrSecureListMobileCodeHist')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrSecureListMobileCodeHist FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrSecureListMobileCodeHist TO FsEb
END

--changeset system:generated-create-grant-PtAgrTermsAndConditions context:any labels:c-any,o-permission,ot-schema,on-PtAgrTermsAndConditions,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtAgrTermsAndConditions
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtAgrTermsAndConditions')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtAgrTermsAndConditions FROM FsEb
  GRANT INSERT, UPDATE ON PtAgrTermsAndConditions TO FsEb
END

--changeset system:generated-create-grant-PtBillCustomerPID context:any labels:c-any,o-permission,ot-schema,on-PtBillCustomerPID,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtBillCustomerPID
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtBillCustomerPID')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtBillCustomerPID FROM FsEb
  GRANT INSERT, UPDATE ON PtBillCustomerPID TO FsEb
END

--changeset system:generated-create-grant-PtBLinkCaasPermission context:any labels:c-any,o-permission,ot-schema,on-PtBLinkCaasPermission,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtBLinkCaasPermission
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtBLinkCaasPermission')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtBLinkCaasPermission FROM FsEb
  GRANT INSERT, UPDATE ON PtBLinkCaasPermission TO FsEb
END

--changeset system:generated-create-grant-PtContactReport context:any labels:c-any,o-permission,ot-schema,on-PtContactReport,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtContactReport
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtContactReport')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtContactReport FROM FsEb
  GRANT INSERT, UPDATE ON PtContactReport TO FsEb
END

--changeset system:generated-create-grant-PtLogin context:any labels:c-any,o-permission,ot-schema,on-PtLogin,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtLogin
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtLogin')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtLogin FROM FsEb
  GRANT INSERT, UPDATE ON PtLogin TO FsEb
END

--changeset system:generated-create-grant-PtOrderDetailChange context:any labels:c-any,o-permission,ot-schema,on-PtOrderDetailChange,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtOrderDetailChange
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtOrderDetailChange')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtOrderDetailChange FROM FsEb
  GRANT INSERT, UPDATE ON PtOrderDetailChange TO FsEb
END

--changeset system:generated-create-grant-PtPain002Notification context:any labels:c-any,o-permission,ot-schema,on-PtPain002Notification,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtPain002Notification
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtPain002Notification')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtPain002Notification FROM FsEb
  GRANT INSERT, UPDATE ON PtPain002Notification TO FsEb
END

--changeset system:generated-create-grant-PtPaymentInstantExecution context:any labels:c-any,o-permission,ot-schema,on-PtPaymentInstantExecution,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtPaymentInstantExecution
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtPaymentInstantExecution')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtPaymentInstantExecution FROM FsEb
  GRANT INSERT, UPDATE ON PtPaymentInstantExecution TO FsEb
END

--changeset system:generated-create-grant-PtPaymentOrder context:any labels:c-any,o-permission,ot-schema,on-PtPaymentOrder,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtPaymentOrder
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtPaymentOrder')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtPaymentOrder FROM FsEb
  GRANT INSERT, UPDATE ON PtPaymentOrder TO FsEb
END

--changeset system:generated-create-grant-PtPaymentOrderDetail context:any labels:c-any,o-permission,ot-schema,on-PtPaymentOrderDetail,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtPaymentOrderDetail
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtPaymentOrderDetail')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtPaymentOrderDetail FROM FsEb
  GRANT INSERT, UPDATE ON PtPaymentOrderDetail TO FsEb
END

--changeset system:generated-create-grant-PtPKICert context:any labels:c-any,o-permission,ot-schema,on-PtPKICert,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtPKICert
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtPKICert')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtPKICert FROM FsEb
  GRANT INSERT, UPDATE ON PtPKICert TO FsEb
END

--changeset system:generated-create-grant-PtStandingOrder context:any labels:c-any,o-permission,ot-schema,on-PtStandingOrder,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtStandingOrder
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtStandingOrder')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtStandingOrder FROM FsEb
  GRANT INSERT, UPDATE ON PtStandingOrder TO FsEb
END

--changeset system:generated-create-grant-PtStandingOrderDetail context:any labels:c-any,o-permission,ot-schema,on-PtStandingOrderDetail,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtStandingOrderDetail
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtStandingOrderDetail')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtStandingOrderDetail FROM FsEb
  GRANT INSERT, UPDATE ON PtStandingOrderDetail TO FsEb
END

--changeset system:generated-create-grant-PtTradingOrder context:any labels:c-any,o-permission,ot-schema,on-PtTradingOrder,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTradingOrder
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTradingOrder')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTradingOrder FROM FsEb
  GRANT INSERT, UPDATE ON PtTradingOrder TO FsEb
END

--changeset system:generated-create-grant-PtTradingOrderMessage context:any labels:c-any,o-permission,ot-schema,on-PtTradingOrderMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTradingOrderMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTradingOrderMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTradingOrderMessage FROM FsEb
  GRANT INSERT, UPDATE ON PtTradingOrderMessage TO FsEb
END

--changeset system:generated-create-grant-PtTradingOrderMessageDetail context:any labels:c-any,o-permission,ot-schema,on-PtTradingOrderMessageDetail,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTradingOrderMessageDetail
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTradingOrderMessageDetail')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTradingOrderMessageDetail FROM FsEb
  GRANT INSERT, UPDATE ON PtTradingOrderMessageDetail TO FsEb
END

--changeset system:generated-create-grant-PtTradingOrderMessageMod context:any labels:c-any,o-permission,ot-schema,on-PtTradingOrderMessageMod,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTradingOrderMessageMod
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTradingOrderMessageMod')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTradingOrderMessageMod FROM FsEb
  GRANT INSERT, UPDATE ON PtTradingOrderMessageMod TO FsEb
END

--changeset system:generated-create-grant-PtTradingOrderMod context:any labels:c-any,o-permission,ot-schema,on-PtTradingOrderMod,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTradingOrderMod
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTradingOrderMod')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTradingOrderMod FROM FsEb
  GRANT INSERT, UPDATE ON PtTradingOrderMod TO FsEb
END

--changeset system:generated-create-grant-PtTransEsrFetched context:any labels:c-any,o-permission,ot-schema,on-PtTransEsrFetched,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTransEsrFetched
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTransEsrFetched')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTransEsrFetched FROM FsEb
  GRANT INSERT, UPDATE ON PtTransEsrFetched TO FsEb
END

--changeset system:generated-create-grant-PtTransEsrFile context:any labels:c-any,o-permission,ot-schema,on-PtTransEsrFile,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTransEsrFile
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTransEsrFile')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTransEsrFile FROM FsEb
  GRANT INSERT, UPDATE ON PtTransEsrFile TO FsEb
END

--changeset system:generated-create-grant-PtTransEsrFileData context:any labels:c-any,o-permission,ot-schema,on-PtTransEsrFileData,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTransEsrFileData
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTransEsrFileData')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTransEsrFileData FROM FsEb
  GRANT INSERT, UPDATE ON PtTransEsrFileData TO FsEb
END

--changeset system:generated-create-grant-PtTransMessageOut context:any labels:c-any,o-permission,ot-schema,on-PtTransMessageOut,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtTransMessageOut
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtTransMessageOut')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtTransMessageOut FROM FsEb
  GRANT INSERT, UPDATE ON PtTransMessageOut TO FsEb
END

--changeset system:generated-create-grant-PtValidCustomerReference context:any labels:c-any,o-permission,ot-schema,on-PtValidCustomerReference,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table PtValidCustomerReference
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PtValidCustomerReference')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON PtValidCustomerReference FROM FsEb
  GRANT INSERT, UPDATE ON PtValidCustomerReference TO FsEb
END

--changeset system:generated-create-grant-SwMtAccount context:any labels:c-any,o-permission,ot-schema,on-SwMtAccount,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table SwMtAccount
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SwMtAccount')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON SwMtAccount FROM FsEb
  GRANT INSERT, UPDATE ON SwMtAccount TO FsEb
END

--changeset system:generated-create-grant-TwAddFinancialAccountMessage context:any labels:c-any,o-permission,ot-schema,on-TwAddFinancialAccountMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwAddFinancialAccountMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwAddFinancialAccountMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwAddFinancialAccountMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwAddFinancialAccountMessage TO FsEb
END

--changeset system:generated-create-grant-TwCancelAuthorizationMessage context:any labels:c-any,o-permission,ot-schema,on-TwCancelAuthorizationMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwCancelAuthorizationMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwCancelAuthorizationMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwCancelAuthorizationMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwCancelAuthorizationMessage TO FsEb
END

--changeset system:generated-create-grant-TwCancelRegistrationMessage context:any labels:c-any,o-permission,ot-schema,on-TwCancelRegistrationMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwCancelRegistrationMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwCancelRegistrationMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwCancelRegistrationMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwCancelRegistrationMessage TO FsEb
END

--changeset system:generated-create-grant-TwConnectedAccount context:any labels:c-any,o-permission,ot-schema,on-TwConnectedAccount,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwConnectedAccount
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwConnectedAccount')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwConnectedAccount FROM FsEb
  GRANT INSERT, UPDATE ON TwConnectedAccount TO FsEb
END

--changeset system:generated-create-grant-TwContract context:any labels:c-any,o-permission,ot-schema,on-TwContract,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwContract
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwContract')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwContract FROM FsEb
  GRANT INSERT, UPDATE ON TwContract TO FsEb
END

--changeset system:generated-create-grant-TwDateLastCheckPartner context:any labels:c-any,o-permission,ot-schema,on-TwDateLastCheckPartner,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwDateLastCheckPartner
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwDateLastCheckPartner')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwDateLastCheckPartner FROM FsEb
  GRANT INSERT, UPDATE ON TwDateLastCheckPartner TO FsEb
END

--changeset system:generated-create-grant-TwDeletePublicKeyMessage context:any labels:c-any,o-permission,ot-schema,on-TwDeletePublicKeyMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwDeletePublicKeyMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwDeletePublicKeyMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwDeletePublicKeyMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwDeletePublicKeyMessage TO FsEb
END

--changeset system:generated-create-grant-TwFinancialAdviceMessage context:any labels:c-any,o-permission,ot-schema,on-TwFinancialAdviceMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwFinancialAdviceMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwFinancialAdviceMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwFinancialAdviceMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwFinancialAdviceMessage TO FsEb
END

--changeset system:generated-create-grant-TwGetValidFundingsMessage context:any labels:c-any,o-permission,ot-schema,on-TwGetValidFundingsMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwGetValidFundingsMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwGetValidFundingsMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwGetValidFundingsMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwGetValidFundingsMessage TO FsEb
END

--changeset system:generated-create-grant-TwHeaderMessage context:any labels:c-any,o-permission,ot-schema,on-TwHeaderMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwHeaderMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwHeaderMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwHeaderMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwHeaderMessage TO FsEb
END

--changeset system:generated-create-grant-TwRegisterMessage context:any labels:c-any,o-permission,ot-schema,on-TwRegisterMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwRegisterMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwRegisterMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwRegisterMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwRegisterMessage TO FsEb
END

--changeset system:generated-create-grant-TwRemoveFinancialAccMessage context:any labels:c-any,o-permission,ot-schema,on-TwRemoveFinancialAccMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwRemoveFinancialAccMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwRemoveFinancialAccMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwRemoveFinancialAccMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwRemoveFinancialAccMessage TO FsEb
END

--changeset system:generated-create-grant-TwReqAuthMessage context:any labels:c-any,o-permission,ot-schema,on-TwReqAuthMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwReqAuthMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwReqAuthMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwReqAuthMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwReqAuthMessage TO FsEb
END

--changeset system:generated-create-grant-TwReqAuthP2MTransDetailMessage context:any labels:c-any,o-permission,ot-schema,on-TwReqAuthP2MTransDetailMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwReqAuthP2MTransDetailMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwReqAuthP2MTransDetailMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwReqAuthP2MTransDetailMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwReqAuthP2MTransDetailMessage TO FsEb
END

--changeset system:generated-create-grant-TwReqAuthP2PTransDetailMessage context:any labels:c-any,o-permission,ot-schema,on-TwReqAuthP2PTransDetailMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwReqAuthP2PTransDetailMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwReqAuthP2PTransDetailMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwReqAuthP2PTransDetailMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwReqAuthP2PTransDetailMessage TO FsEb
END

--changeset system:generated-create-grant-TwReqAuthResponseMessage context:any labels:c-any,o-permission,ot-schema,on-TwReqAuthResponseMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwReqAuthResponseMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwReqAuthResponseMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwReqAuthResponseMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwReqAuthResponseMessage TO FsEb
END

--changeset system:generated-create-grant-TwReqAuthStatusMessage context:any labels:c-any,o-permission,ot-schema,on-TwReqAuthStatusMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwReqAuthStatusMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwReqAuthStatusMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwReqAuthStatusMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwReqAuthStatusMessage TO FsEb
END

--changeset system:generated-create-grant-TwSystemCertificate context:any labels:c-any,o-permission,ot-schema,on-TwSystemCertificate,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwSystemCertificate
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwSystemCertificate')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwSystemCertificate FROM FsEb
  GRANT INSERT, UPDATE ON TwSystemCertificate TO FsEb
END

--changeset system:generated-create-grant-TwSystemInfo context:any labels:c-any,o-permission,ot-schema,on-TwSystemInfo,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwSystemInfo
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwSystemInfo')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwSystemInfo FROM FsEb
  GRANT INSERT, UPDATE ON TwSystemInfo TO FsEb
END

--changeset system:generated-create-grant-TwToken context:any labels:c-any,o-permission,ot-schema,on-TwToken,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwToken
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwToken')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwToken FROM FsEb
  GRANT INSERT, UPDATE ON TwToken TO FsEb
END

--changeset system:generated-create-grant-TwTokenMessage context:any labels:c-any,o-permission,ot-schema,on-TwTokenMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwTokenMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwTokenMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwTokenMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwTokenMessage TO FsEb
END

--changeset system:generated-create-grant-TwUpdateMsisdnMessage context:any labels:c-any,o-permission,ot-schema,on-TwUpdateMsisdnMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwUpdateMsisdnMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwUpdateMsisdnMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwUpdateMsisdnMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwUpdateMsisdnMessage TO FsEb
END

--changeset system:generated-create-grant-TwUpdatePublicKeyMessage context:any labels:c-any,o-permission,ot-schema,on-TwUpdatePublicKeyMessage,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table TwUpdatePublicKeyMessage
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'TwUpdatePublicKeyMessage')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON TwUpdatePublicKeyMessage FROM FsEb
  GRANT INSERT, UPDATE ON TwUpdatePublicKeyMessage TO FsEb
END

--changeset system:generated-create-grant-WfProcess context:any labels:c-any,o-permission,ot-schema,on-WfProcess,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table WfProcess
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'WfProcess')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON WfProcess FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON WfProcess TO FsEb
END

--changeset system:generated-create-grant-WfProcessProgress context:any labels:c-any,o-permission,ot-schema,on-WfProcessProgress,fin-13659 runOnChange:true
--comment: Grant to FsEb role on table WfProcessProgress
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'WfProcessProgress')
BEGIN
  REVOKE INSERT, UPDATE, DELETE ON WfProcessProgress FROM FsEb
  GRANT INSERT, UPDATE, DELETE ON WfProcessProgress TO FsEb
END
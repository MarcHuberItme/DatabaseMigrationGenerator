--liquibase formatted sql

--changeset system:create-alter-view-ExportPowerOfAttorneyView context:any labels:c-any,o-view,ot-schema,on-ExportPowerOfAttorneyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportPowerOfAttorneyView
CREATE OR ALTER VIEW dbo.ExportPowerOfAttorneyView AS
SELECT
  
    PBSlave.Id AS 'powerOfAttorney_partner_authorizedAgent_id',
    PBSlave.PartnerNo AS 'powerOfAttorney_partner_authorizedAgent_no_numeric',
    PBSlave.PartnerNoEdited AS 'powerOfAttorney_partner_authorizedAgent_no_formatted',
    PBSlave.PartnerNoText AS 'powerOfAttorney_partner_authorizedAgent_no_textForSort',
    PDVProxyRecipient.PtDescription AS 'powerOfAttorney_partner_authorizedAgent_description',
    PRS.ContactPersonId AS 'powerOfAttorney_partner_authorizedAgent_contactPerson_id',
      
    PBMaster.Id AS 'powerOfAttorney_partner_principal_id',
    PBMaster.PartnerNo AS 'powerOfAttorney_partner_principal_no_numeric',
    PBMaster.PartnerNoEdited AS 'powerOfAttorney_partner_principal_no_formatted',
    PBMaster.PartnerNoText AS 'powerOfAttorney_partner_principal_no_textForSort',
      
    PRS.ValidFrom AS 'powerOfAttorney_validFrom',
    PRS.ValidTo AS 'powerOfAttorney_validTo',
  
    PPD.ProxyRightNo AS 'powerOfAttorney_detail_proxyRight_no',
    ATPPRProxyDetail.TextShort AS 'powerOfAttorney_detail_proxyRight',
    PRS.ProxyRightNo AS 'powerOfAttorney_authorizedAgent_proxyRight_no',
    ATPPRSlave.TextShort AS 'powerOfAttorney_authorizedAgent_proxyRight',
  
    PPD.DisposalRightNo AS 'powerOfAttorney_detail_disposalRight_no',
    PRS.DisposalRightNo AS 'powerOfAttorney_authorizedAgent_disposalRight_no',
  
    PRS.CloseRelTypeNo AS 'powerOfAttorney_closeRelationType_no',
    ATPRSCRT.TextShort AS 'powerOfAttorney_closeRelationType',
  
    PPD.Instruction AS 'powerOfAttorney_detail_instruction',
    PPD.InstructionVerifyFlag AS 'powerOfAttorney_detail_instruction_verifyFlag',
 
  
    'ObjectId' = CASE WHEN PPD.PortfolioId IS NOT NULL THEN PPD.PortfolioId
    WHEN PPD.AccountId IS NOT NULL THEN PPD.AccountId
    WHEN PPD.SafeDepositId IS NOT NULL THEN PPD.SafeDepositId
        ELSE PBMaster.Id END
  
    ,'SourceTable' = CASE WHEN PPD.PortfolioId IS NOT NULL THEN 'PtPortfolio'
    WHEN PPD.AccountId IS NOT NULL THEN 'PtAccountBase'
    WHEN PPD.SafeDepositId IS NOT NULL THEN 'PtAgrSafeDeposit'
        ELSE 'PtBase' END,
  
    PRS.RelationRoleNo AS 'powerOfAttorney_authorizedAgent_relationRole_no',
    ATPRR.TextShort AS 'powerOfAttorney_authorizedAgent_relationRole',
 
    GETUTCDATE() AS 'lastSyncDate'
  
FROM PtProxyDetail PPD
JOIN PtProxyRight PPRProxyDetail ON PPRProxyDetail.ProxyRightNo=PPD.ProxyRightNo
JOIN AsText ATPPRProxyDetail ON ATPPRProxyDetail.MasterId=PPRProxyDetail.Id AND ATPPRProxyDetail.LanguageNo = 2
JOIN PtRelationSlave PRS ON PRS.Id=PPD.RelationSlaveId
LEFT JOIN PtContactPerson PCP ON PCP.Id=PRS.ContactPersonId
  
LEFT JOIN PtRelationSlaveCloseRelType PRSCRT ON PRSCRT.CloseRelTypeNo=PRS.CloseRelTypeNo
LEFT JOIN AsText ATPRSCRT ON ATPRSCRT.MasterId=PRSCRT.Id AND ATPRSCRT.LanguageNo = 2
  
JOIN PtProxyRight PPRSlave ON PPRSlave.ProxyRightNo=PRS.ProxyRightNo
JOIN AsText ATPPRSlave ON ATPPRSlave.MasterId=PPRSlave.Id AND ATPPRSlave.LanguageNo = 2
  
JOIN PtRelationRole PRR ON PRR.RelationRoleNo=PRS.RelationRoleNo
JOIN AsText ATPRR ON ATPRR.MasterId=PRR.Id AND ATPRR.LanguageNo = 2
      
JOIN PtRelationMaster PRM ON PRM.Id=PRS.MasterId
JOIN PtBase PBMaster ON PBMaster.Id=PRM.PartnerId
JOIN PtBase PBSlave ON PBSlave.Id=PRS.PartnerId
JOIN PtDescriptionView PDVProxyRecipient ON PDVProxyRecipient.Id=PBSlave.Id
  
WHERE (PPD.ValidTo > =GETDATE() OR PPD.ValidTo IS NULL)
    AND PPD.HdVersionNo BETWEEN 1 AND 999999998
    AND PRS.HdVersionNo BETWEEN 1 AND 999999998
    AND (PRS.ValidTo > =GETDATE() OR PRS.ValidTo IS NULL)
    AND PBMaster.TerminationDate IS NULL
    AND PBSlave.TerminationDate IS NULL

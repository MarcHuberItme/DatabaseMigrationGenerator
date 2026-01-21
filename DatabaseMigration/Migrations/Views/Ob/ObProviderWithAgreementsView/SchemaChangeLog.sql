--liquibase formatted sql

--changeset system:create-alter-view-ObProviderWithAgreementsView context:any labels:c-any,o-view,ot-schema,on-ObProviderWithAgreementsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ObProviderWithAgreementsView
CREATE OR ALTER VIEW dbo.ObProviderWithAgreementsView AS
select 
	ObHub.Id as HubId,
	ObHub.HdVersionNo as HubHdVersionNo,
	ObHub.Name as HubName,
	ObProvider.Id as ProviderId,
	ObProvider.CompanyName as CompanyName,
	ObProvider.ProviderId as ProviderIdThirdParty,
	ObProvider.StatusNo as ProviderStatus,
	ObProvider.IsEnabled as IsProviderEnabled,
                ObProvider.ThirdPartyProviderLastModified,
	ObProvider.HdVersionNo as ProviderHdVersionNo,
	ObProviderImage.Id as ImageId,
	ObProviderImage.HdVersionNo as ImageHdVersionNo,
	ObProviderImage.TypeNo as ImageType,
	ObProviderImage.Data as ImageData,
    ObProviderImage.MimeType as ImageMimeType,
	ObHubConsentFlow.Id as ConsentFlowId,
	ObHubConsentFlow.HdVersionNo as ConsentFlowHdVersionNo,
	ObHubConsentFlow.TypeNo as ConsentFlowType,
	ObHubConsentFlow.Version as ConsentFlowVersion,
	ObProviderSupportsConsent.Id as SupportsConsentFlowId,
	ObProviderSupportsConsent.HdVersionNo as SupportsConsentHdVersionNo,
	ObProviderSupportsConsent.StatusNo as SupportsConsentFlowStatus,
	ObProviderSupportsConsent.ValidFrom as SupportsConsentFlowValidFrom,
	ObProviderSupportsConsent.ValidTo as SupportsConsentFlowValidTo,
	ObHubUseCase.Id as UseCaseId,
	ObHubUseCase.HdVersionNo as UseCaseHdVersionNo,
	ObHubUseCase.Name as UseCaseName,
	ObHubUseCase.Version as UseCaseVersion,
	ObHubUseCaseScope.Id as UseCaseScopeId,
	ObHubUseCaseScope.HdVersionNo as UseCaseScopeHdVersionNo,
	ObHubUseCaseScope.Scope as UseCaseScope,
	ObProviderSupportsScope.Id as SupportsScopeId,
	ObProviderSupportsScope.HdVersionNo as SupportsScopeHdVersionNo,
	ObProviderSupportsScope.StatusNo as SupportsScopeStatus,
	ObProviderSupportsScope.ValidFrom as SupportsScopeValidFrom,
	ObProviderSupportsScope.ValidTo as SupportsScopeValidTo,
	PtAgrEBankingObProvider.AgreementId as LinkedAgreementId,
	PtAgrEBankingObProvider.Id as LinkedId,
	PtAgrEBankingObProvider.HdVersionNo as LinkedHdVersionNo,
	PtBLinkCaasPermission.Id as BLinkPermissionId,
	PtBLinkCaasPermission.HdVersionNo as BLinkPermissionHdVersionNo,
	PtBLinkCaasPermission.StatusNo as BLinkPermissionStatus,
	PtBLinkCaasPermission.PermissionId as BLinkPermissionIdThirdParty,
	PtBLinkCaasPermission.HdChangeDate as BLinkPermissionHdChangeDate,
                PtBLinkCaasPermission.LastRefreshedPermissionDate as BLinkPermissionLastRefreshed
from 
	ObProvider
	inner join ObHub on ObHub.Id = ObProvider.HubId
	inner join ObHubConsentFlow on ObHubConsentFlow.HubId = ObHub.Id
	inner join ObHubUseCase on ObHubUseCase.HubId = ObHub.Id
	inner join ObHubUseCaseScope on ObHubUseCaseScope.UseCaseId = ObHubUseCase.Id
	inner join ObProviderSupportsConsent on ObProviderSupportsConsent.ProviderId = ObProvider.Id and ObProviderSupportsConsent.ConsentFlowId = ObHubConsentFlow.Id
	inner join ObProviderSupportsScope on ObProviderSupportsScope.ProviderId = ObProvider.Id and ObProviderSupportsScope.UseCaseScopeId = ObHubUseCaseScope.Id
	inner join ObProviderImage on ObProviderImage.ProviderId = ObProvider.Id
	left join PtAgrEBankingObProvider on PtAgrEBankingObProvider.ProviderId = ObProvider.Id
	left join PtBLinkCaasPermission on PtBLinkCaasPermission.AgreementObProviderId = PtAgrEBankingObProvider.Id
where
	ObHub.HdVersionNo BETWEEN 1 AND 999999998
	AND ObProvider.HdVersionNo BETWEEN 1 AND 999999998
	AND ObProviderImage.HdVersionNo BETWEEN 1 AND 999999998
	AND ObHubConsentFlow.HdVersionNo BETWEEN 1 AND 999999998
	AND ObHubUseCase.HdVersionNo BETWEEN 1 AND 999999998
	AND ObHubUseCaseScope.HdVersionNo BETWEEN 1 AND 999999998
	AND ObProviderSupportsConsent.HdVersionNo BETWEEN 1 AND 999999998
	AND ObProviderSupportsScope.HdVersionNo BETWEEN 1 AND 999999998

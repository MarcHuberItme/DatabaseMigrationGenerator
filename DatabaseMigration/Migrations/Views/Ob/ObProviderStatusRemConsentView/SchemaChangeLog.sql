--liquibase formatted sql

--changeset system:create-alter-view-ObProviderStatusRemConsentView context:any labels:c-any,o-view,ot-schema,on-ObProviderStatusRemConsentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ObProviderStatusRemConsentView
CREATE OR ALTER VIEW dbo.ObProviderStatusRemConsentView AS
SELECT ObProvider.Id AS ProviderId,
ObProvider.CompanyName AS ServiceProvider,
PtBLinkCaasPermissionStatus.Status,
PtBLinkCaasPermissionStatus.StatusNo,
CASE
  WHEN PtBLinkCaasPermission.LastRefreshedPermissionDate < PtBLinkCaasPermission.HdCreateDate
  THEN PtBLinkCaasPermission.HdCreateDate
  ELSE PtBLinkCaasPermission.LastRefreshedPermissionDate
END AS LastUpdate,
PtAgrEBankingObProvider.AgreementId,
CAST(0 AS Bit) AS RemoveConsent
FROM ObProvider
INNER JOIN ObProviderStatus ON ObProvider.StatusNo = ObProviderStatus.StatusNo
INNER JOIN PtAgrEBankingObProvider ON ObProvider.Id = PtAgrEBankingObProvider.ProviderId
INNER JOIN PtBLinkCaasPermission ON PtBLinkCaasPermission.AgreementObProviderId = PtAgrEBankingObProvider.Id
INNER JOIN PtBLinkCaasPermissionStatus on PtBLinkCaasPermissionStatus.StatusNo = PtBLinkCaasPermission.StatusNo
WHERE ObProvider.IsEnabled = '1'
AND ObProvider.HdVersionNo BETWEEN 1 AND 999999998
AND (ObProviderStatus.StatusNo = 2 OR ObProviderStatus.StatusNo = 1)
AND PtBLinkCaasPermission.HdVersionNo BETWEEN 1 AND 999999998
AND PtAgrEBankingObProvider.HdVersionNo BETWEEN 1 AND 999999998
AND PtBLinkCaasPermissionStatus.HdVersionNo BETWEEN 1 AND 999999998


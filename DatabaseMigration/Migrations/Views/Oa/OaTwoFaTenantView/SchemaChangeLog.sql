--liquibase formatted sql

--changeset system:create-alter-view-OaTwoFaTenantView context:any labels:c-any,o-view,ot-schema,on-OaTwoFaTenantView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view OaTwoFaTenantView
CREATE OR ALTER VIEW dbo.OaTwoFaTenantView AS
select provider.Id          as ProviderId,
       tenant.Id            as TenantId,
       tenant.Name          as TenantName,
       provider.TypeNo      as ProviderTypeNo,
       tenant.HdVersionNo   as TenantHdVersionNo,
       provider.HdVersionNo as ProviderHdVersionNo,
       typeText.TextShort   as ProviderTypeText

from OaTwoFaProviderTenant tenant
         join OaTwoFaProvider provider on provider.id = tenant.TwoFaProviderId
         join OaTwoFaProviderType providerType on providerType.TypeNo = provider.TypeNo
        join AsText typeText on typeText.MasterId = providerType.Id and typeText.LanguageNo = 1
         

--liquibase formatted sql

--changeset system:create-alter-view-OaTwoFaTransLogView context:any labels:c-any,o-view,ot-schema,on-OaTwoFaTransLogView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view OaTwoFaTransLogView
CREATE OR ALTER VIEW dbo.OaTwoFaTransLogView AS
SELECT 
       InitiationRequest.Id,
       InitiationRequest.Id as TwoFaTransLogId,
       Result.Id as TwoFaTransResultLogId,
       InitiationRequest.HdVersionNo as LogVersionNo,
       InitiationRequest.SessionId AS SessionId,
       InitiationRequest.Factor AS Factor,
       InitiationRequest.AgreementId AS EbankingAgreementId,
       InitiationRequest.InitiationDatetime AS InitiationDateTime,
       InitiationRequest.UserId AS TwoFaUserId,
       InitiationRequest.MessageContent AS MessageContent,
       InitiationRequest.UseCase AS UseCase,
       InitiationRequest.TwoFaProviderTenantId,
       ProviderTypeName.TextShort as Provider,
       TenantName.TextShort as Tenant,
       Result.DeviceId AS DeviceId,
       Result.DateTime AS ResultDateTime,
       Result.OriginalResult AS OriginalResult,
       Result.Result AS ResultTypeNo,
       ResultTypeName.TextShort as ResultType,
      InitiationRequest.HdVersionNo, InitiationRequest.HdPendingChanges, InitiationRequest.HdPendingSubChanges, InitiationRequest.HdProcessId, InitiationRequest.HdCreateDate, InitiationRequest.HdEditStamp
FROM OaTwoFaTransLog InitiationRequest
         LEFT JOIN OaTwoFaTransLogResult Result
                   ON Result.SessionId = InitiationRequest.SessionId
         JOIN OaTwoFaProviderTenant Tenant on Tenant.Id = TwoFaProviderTenantId
         JOIN AsText TenantName on TenantName.MasterId = Tenant.Id
         JOIN OaTwoFaProvider Provider on Tenant.TwoFaProviderId = Provider.Id
         JOIN OaTwoFaProviderType ProviderType on Provider.TypeNo = ProviderType.TypeNo
         JOIN AsText ProviderTypeName on ProviderTypeName.MasterId = ProviderType.Id

         LEFT JOIN OaTwoFaTransResultType ResultType on ResultType.TypeNo = Result.Result
         LEFT JOIN AsText ResultTypeName on ResultTypeName.MasterId = ResultType.Id

WHERE TenantName.LanguageNo = 1
  AND ProviderTypeName.LanguageNo = 1
  and (ResultTypeName.LanguageNo = 1 or ResultTypeName.LanguageNo is NULL)

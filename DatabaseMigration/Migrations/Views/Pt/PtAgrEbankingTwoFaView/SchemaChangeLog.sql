--liquibase formatted sql

--changeset system:create-alter-view-PtAgrEbankingTwoFaView context:any labels:c-any,o-view,ot-schema,on-PtAgrEbankingTwoFaView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrEbankingTwoFaView
CREATE OR ALTER VIEW dbo.PtAgrEbankingTwoFaView AS
SELECT agreement.id                                          AS AgreementId,
       twoFactorAuthentication.Id                            AS SecureListId,
       agreement.MgVTNo                                      AS AgreementNo,
       agreement.HdVersionNo                                 AS HdVersionNo,
       agreement.HdCreateDate                                AS HdCreateDate,
       agreement.ExpirationDate                              AS AgreementExpirationDate,
       twoFactorAuthentication.FuturaeUserId                 AS FuturaeUserId,
       twoFactorAuthentication.IsFuturaeAllowed              AS IsFuturaeActive,
       twoFactorAuthentication.FuturaeDeviceActivationCode   AS LastFuturaeDevActShortCode,
       twoFactorAuthentication.FuturaeDevActQrCodeDataUri    AS LastFuturaeDevActQrCodeDataUri,
       twoFactorAuthentication.FuturaeActivationCodeValidity AS LastFuturaeActCodeExpDateTime,
       twoFactorAuthentication.CurrentFuturaeTwoFaTenantId   AS CurrentFuturaeTwoFaTenantId,
       twoFactorAuthentication.AstUserId                     AS KobilUserId,
       twoFactorAuthentication.AstActivationCode             AS LastKobilDevActCode,
       twoFactorAuthentication.AstCodeValidity               AS LastKobilDevActCodeExpDateTime,
       twoFactorAuthentication.IsAstAllowed                  AS IsKobilActive,
       twoFactorAuthentication.PartnerId                     AS PartnerId,
       twoFactorAuthentication.UsingFuturaeDueDate           AS FuturaeMigDueDate,
       twoFactorAuthentication.IsSecureListEnabled AS IsSecureListAvailable,
       twoFactorAuthentication.IsMatrixList AS IsMatrixListAvailable
FROM PtAgrEBanking agreement
         JOIN PtAgrSecureList twoFactorAuthentication ON agreement.MgVTNo = twoFactorAuthentication.PrevEBankingNo

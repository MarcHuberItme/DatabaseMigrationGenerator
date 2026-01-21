--liquibase formatted sql

--changeset system:create-alter-view-OaAgrAppView context:any labels:c-any,o-view,ot-schema,on-OaAgrAppView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view OaAgrAppView
CREATE OR ALTER VIEW dbo.OaAgrAppView AS
SELECT pae.Id,
pae.MgVTNo,
pae.BeginDate,
pae.ExpirationDate,
pae.AcceptanceDate,
pae.AGBacceptedByCustomer,
oa.AppIdentifier,
oa.RequiresStrongAuthentication,
oaa.StrongAuthForQueries,
CASE WHEN oa.AppSpecificPassword = 1 THEN oaa.PasswordBcrypt ELSE oaapw.PasswordBcrypt END AS PasswordBcrypt,
oaa.WrongPasswordCounter,
oaa.Id AS PasswordRecordId,
oa.OrderGroupTypeNo,
CASE WHEN oaa.SingleMoneyTransferLimit IS NULL THEN oa.MaxSingleMoneyTransferLimit ELSE oaa.SingleMoneyTransferLimit END AS SingleMoneyTransferLimit,
CASE WHEN oaa.DailyMoneyTransferLimit IS NULL THEN oa.MaxDailyMoneyTransferLimit ELSE oaa.DailyMoneyTransferLimit END AS DailyMoneyTransferLimit,
CASE WHEN oaa.MonthlyMoneyTransferLimit IS NULL THEN oa.MaxMonthlyMoneyTransferLimit ELSE oaa.MonthlyMoneyTransferLimit END AS MonthlyMoneyTransferLimit,
CASE WHEN oaa.YearlyMoneyTransferLimit IS NULL THEN oa.MaxYearlyMoneyTransferLimit ELSE oaa.YearlyMoneyTransferLimit END AS YearlyMoneyTransferLimit,
oa.ConfirmEachTransaction,
oa.AccountRestriction,
CASE WHEN oaa.SingleMoneyTransferLimit IS NOT NULL THEN 1 WHEN oa.MaxSingleMoneyTransferLimit IS NOT NULL THEN 1 ELSE 0 END AS LimitSingleMoneyTransfer,
oa.ShowOnlyDefaultAccount,
oa.UseEBankingConfirmationMethod,
oa.IgnoreLimitsForOwnAccounts,
oa.MaxSingleIpMoneyTransferLimit SingleIpMoneyTransferLimit,
oa.MaxDailyIpMoneyTransferLimit DailyIpMoneyTransferLimit,
oa.MaxMonthlyIpMoneyTransferLimit MonthlyIpMoneyTransferLimit,
oa.MaxYearlyIpMoneyTransferLimit YearlyIpMoneyTransferLimit
FROM PtAgrEBanking AS pae
INNER JOIN OaAgrApp AS oaa ON oaa.AgrEBankingId = pae.Id
INNER JOIN OaApp AS oa ON oa.Id = oaa.AppId AND oa.AppIdentifier <> 'Oauth_Password'
LEFT OUTER JOIN OaAgrApp AS oaapw ON oaapw.AgrEBankingId = pae.Id
LEFT OUTER JOIN OaApp AS oapw ON oapw.Id = oaapw.AppId AND oapw.AppIdentifier = 'Oauth_Password'

WHERE (pae.HdVersionNo BETWEEN 1 AND 999999998)
 AND (oaapw.HdVersionNo BETWEEN 1 AND 999999998 OR oaapw.HdVersionNo IS NULL)
 AND (oapw.HdVersionNo BETWEEN 1 AND 999999998 OR oapw.HdVersionNo IS NULL)
 AND (oaa.HdVersionNo BETWEEN 1 AND 999999998)
 AND (oa.HdVersionNo BETWEEN 1 AND 999999998)


--liquibase formatted sql

--changeset system:create-alter-view-PtStandingOrderSearchView context:any labels:c-any,o-view,ot-schema,on-PtStandingOrderSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtStandingOrderSearchView
CREATE OR ALTER VIEW dbo.PtStandingOrderSearchView AS
SELECT

-- PtStandingOrder == SO
SO.Id,
SO.HdCreateDate,
So.HdChangeDate,
SO.HdVersionNo,
SO.AccountId AS DebtorAccountId,
SO.ChargeBorneTypeNo AS ChargeBearerTypeNo,
SO.FirstSelectionDate AS FirstExecutionDate,
SO.FinalSelectionDate AS FinalExecutionDate,
SO.MaxSelection AS MaximumNumberOfExecutions,
SO.NextSelectionDate AS NextExecutionDate,
SO.NokCounter AS ConsecutiveFailedPaymentCount,
SO.PeriodRuleNo,
SO.PaymentAmount AS Amount,
SO.PaymentCurrency AS Currency,
SO.PreviousSelectionDate,
SO.PreviousExecutionDate,
SO.ReferenceNo AS EsrOrQrReferenceNo,
SO.SenderRemarks AS DebtorRemark,
SO.StructuredCreditorReference AS ScoReference,
SO.SuspendFrom,
SO.SuspendTo,
SO.TransTypeOrig as SlipType,
SO.SalaryFlag,
SO.EndBeneficiaryBuildingNo AS UltimateCreditorBuildingNumber,
SO.EndBeneficiaryCountry AS UltimateCreditorCountryCode,
SO.EndBeneficiaryName AS UltimateCreditorName,
SO.EndBeneficiaryPostCode AS UltimateCreditorPostCode,
SO.EndBeneficiaryStreetName AS UltimateCreditorStreetName,
SO.EndBeneficiaryTownName AS UltimateCreditorTownName,
SO.OriginalSenderBuildingNo AS UltimateDebtorBuildingNumber,
SO.OriginalSenderCountry AS UltimateDebtorCountryCode,
SO.OriginalSenderName AS UltimateDebtorName,
SO.OriginalSenderPostCode AS UltimateDebtorPostCode,
SO.OriginalSenderStreetName AS UltimateDebtorStreetName,
SO.OriginalSenderTownName AS UltimateDebtorTownName,
SO.PaymentInformation AS RemittanceInformation,
SO.RejectedEbankingAddress AS RejectedUnstructuredAddress,
SO.EBankingId as CreatorAgreementId,
SO.EBankingIdVisum1 as AgreementIdThatApproved1,
SO.EBankingIdVisum2 as AgreementIdThatApproved2,

-- PtAccountBase of internal creditor = AB
AB.AccountNo AS InternalCreditorAccountNumber,
AB.AccountNoIbanElect as InternalCreditorIban,
AB.QrIban as InternalCreditorQrIban,

-- PtAccountBase of debtor = DAB
DAB.AccountNo as DebtorAccountNo,
DAB.AccountNoIbanElect as DebtorIban,

-- AsPayee = AP
AP.AccountNoExt  AS ExternalCreditorAccountNumber,
AP.BeneficiaryBuildingNo as ExternalCreditorBuildingNumber,
AP.BeneficiaryCountry as ExternalCreditorCountryCode,
AP.BeneficiaryName as ExternalCreditorName,
AP.BeneficiaryPostCode as ExternalCreditorPostCode,
AP.BeneficiaryStreetName as ExternalCreditorStreetName,
AP.BeneficiaryTownName as ExternalCreditorTownName,
AP.PCNo as CreditorPostAccountNo,
AP.PCNoUnformatted as CreditorPostAccountNoUnf,

-- PtAddress = AD
AD.CountryCode As InternalCreditorCountryCode,
AD.Town As InternalCreditorTownName,
AD.Zip AS InternalCreditorPostCode,
AD.Street AS InternalCreditorStreetName,
AD.HouseNo AS InternalCreditorBuildingNumber,

-- PartnerBase = PB
PB.FirstName AS InternalCreditorFirstName,
PB.Name AS InternalCreditorLastName,
PB.MiddleName AS InternalCreditorMiddleName,
PB.NameCont AS InternalCreditorNameCont,

-- Customer confirmation
SO.CustomerConfirmationPending as IsCustomerConfirmationPending,

-- Try to construct name of internal creditor. It works most of the cases, for joint legal statuses it does not always work.
REPLACE(CONCAT(PB.FirstName, ' ', CASE WHEN PB.UseMiddleName = 1 THEN CONCAT(PB.MiddleName, ' ') else '' END, CASE WHEN PB.NameCont is not null THEN CONCAT(PB.NameCont, ',',' ') ELSE '' END, PB.Name), '  ', ' ') AS InternalCreditorName,
PB.UseMiddleName AS IsInternalCreditorMidNameUsed

FROM PtStandingOrder SO

LEFT JOIN AsPayee AP on AP.id = SO.PayeeId
LEFT JOIN PrReference AS PRR ON SO.CreditReferenceId = PRR.Id
LEFT JOIN PtAccountBase AS AB ON PRR.AccountId = AB.Id
LEFT JOIN PtPortfolio AS P ON AB.PortfolioId = P.Id
LEFT JOIN PtAddress AS AD ON P.PartnerId = AD.PartnerId AND AD.AddressTypeNo = 11
LEFT JOIN PtBase AS PB on PB.Id = P.PartnerId
JOIN PtAccountBase as DAB on DAB.Id = SO.AccountId

-- Use always this filter, otherwise there must be changed other things too.
WHERE SO.BlockedForPartner = 0 and SO.UsageNo = 0 and SO.OrderType = 0

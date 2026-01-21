--liquibase formatted sql

--changeset system:create-alter-view-ExportStandingOrdersView context:any labels:c-any,o-view,ot-schema,on-ExportStandingOrdersView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportStandingOrdersView
CREATE OR ALTER VIEW dbo.ExportStandingOrdersView AS
SELECT TOP 100 PERCENT
 
PB.Id AS 'standingOrder_partner_id',
PB.PartnerNo AS 'standingOrder_partner_no_numeric',
PB.PartnerNoEdited AS 'standingOrder_partner_no_formatted',
PB.PartnerNoText AS 'standingOrder_partner_no_textForSort',
PDV.PtDescription AS 'standingOrder_partner_description',
 
PAB.AccountNo AS 'standingOrder_account_no_numeric',
PAB.AccountNoEdited AS 'standingOrder_account_no_formatted',
PAB.AccountNoText AS 'standingOrder_account_no_textForSort',
 
PSO.OrderNo AS 'standingOrder_no',
PSO.UsageNo AS 'standingOrder_usage_no',
PSOUsageT.TextShort AS 'standingOrder_usage',
PSO.PaymentCurrency AS 'standingOrder_paymentCurrency',
PSO.PaymentAmount AS 'standingOrder_paymentAmount',
PSO.PreDefTypeNo AS 'standingOrder_preDefinedType_no',
PSOPDTypeT.TextShort AS 'standingOrder_preDefinedType',
(CASE
    WHEN PSO.SalaryFlag = 0 THEN 'false'
    WHEN PSO.SalaryFlag = 1 THEN 'true'
    END) AS 'standingOrder_salaryFlag',
PSO.PaymentAmountMin AS 'standingOrder_paymentAmountMinimum',
PSO.BalanceLimit AS 'standingOrder_balanceLimit',
PSO.PaymentInformation AS 'standingOrder_paymentInformation',
 
PSO.PeriodRuleNo AS 'standingOrder_periodRule_no',
APRuleT.TextShort AS 'standingOrder_periodRule',
PSO.PeriodRuleBase AS 'standingOrder_periodRule_base',
 
PSO.FirstSelectionDate AS 'standingOrder_firstSelectionDate',
PSO.ChargeBorneTypeNo AS 'standingOrder_chargeBorneType_no',
PChBTypeT.TextShort AS 'standingOrder_chargeBorneType',
 
PSO.PayeeId AS 'standingOrder_payee_id',
AP.AccountNoExt AS 'standingOrder_payee_account_external_no',
 
AP.BCId AS 'standingOrder_payee_bc_id',
ABCI.BankName AS 'standingOrder_payee_bc_bankName',
ABCI.Domicile AS 'standingOrder_payee_bc_domicile',
ABCI.PostalAddress AS 'standingOrder_payee_bc_postalAddress',
ABCI.ZipCode AS 'standingOrder_payee_bc_zipCode',
ABCI.Place AS 'standingOrder_payee_bc_place',
ABCI.ShortName AS 'standingOrder_payee_bc_shortName',
ABCI.BICAddress AS 'standingOrder_payee_bc_bic_address',
 
AP.PCNo AS 'standingOrder_payee_PCNo',
AP.PCNoUnformatted AS 'standingOrder_payee_PCNoUnformatted',
 
AP.Beneficary AS 'standingOrder_payee_beneficary',
AP.PtAgrEBankingId AS 'standingOrder_payee_ebanking_id',
 
PBInternal.Id AS 'standingOrder_internal_beneficary_partner_id',
PBInternal.PartnerNo AS 'standingOrder_internal_beneficary_partner_no_numeric',
PBInternal.PartnerNoEdited AS 'standingOrder_internal_beneficary_partner_no_formatted',
PBInternal.PartnerNoText AS 'standingOrder_internal_beneficary_partner_no_textForSort',
PDVInternal.PtDescription AS 'standingOrder_internal_beneficary_partner_description',
 
PABInternal.AccountNo AS 'standingOrder_internal_beneficary_account_no_numeric',
PABInternal.AccountNoEdited AS 'standingOrder_internal_beneficary_account_no_formatted',
PABInternal.AccountNoText AS 'standingOrder_internal_beneficary_account_no_textForSort',
 
PSO.ReferenceNo AS 'standingOrder_reference_no',
PSO.ReferenceType AS 'standingOrder_reference_type',
 
PSO.PreviousSelectionDate AS 'standingOrder_selection_previous_date',
PSO.PreviousExecutionDate AS 'standingOrder_execution_date',
PSO.NextSelectionDate AS 'standingOrder_selection_next_date',
 
PSO.SuspendFrom AS 'standingOrder_suspendFrom',
PSO.SuspendTo AS 'standingOrder_suspendTo',
 
PSO.Remark AS 'standingOrder_remark',
 
(CASE
    WHEN (PSO.FinalSelectionDate IS NULL
            AND PSO.MaxSelection IS NULL) THEN 'true'
    ELSE 'false'
    END) AS 'standingOrder_untilRevocation',            -- naming(?)
 
PSO.FinalSelectionDate AS 'standingOrder_selection_final_date',
 
PSO.SelectionCounter AS 'standingOrder_selection_executionCounter',
 
PSO.MaxSelection AS 'standingOrder_selection_max_amount',
 
(CASE
    WHEN (PSO.MaxSelection IS NOT NULL AND PSO.MaxSelection > PSO.SelectionCounter) THEN 'aktiv, Anzahl Ausführungen'
    WHEN (PSO.MaxSelection IS NOT NULL AND PSO.SelectionCounter = PSO.SelectionCounter) THEN 'abgelaufen, maximale Ausführung erreicht'
     
    WHEN (PSO.FinalSelectionDate IS NOT NULL AND PSO.FinalSelectionDate > PSO.NextSelectionDate) THEN 'aktiv, letzte Ausführung noch nicht erreicht'
    WHEN (PSO.FinalSelectionDate < GETDATE() AND PSO.NextSelectionDate = '9999-12-31') THEN 'abgelaufen, letze Ausführung erreicht'
 
    ELSE 'aktiv, bis auf Widerruf'
    END) AS 'standingOrder_status',
 
(CASE
    WHEN (GETDATE() > PSO.SuspendFrom AND GETDATE() < PSO.SuspendTo) THEN 'true'
    ELSE 'false'
    END) AS 'isSuspended',
 
GETUTCDATE() AS 'lastSyncDate'
 
FROM PtStandingOrder PSO
JOIN PtStandingOrderUsage PSOUsage ON PSOUsage.UsageNo = PSO.UsageNo
JOIN AsText PSOUsageT ON PSOUsageT.MasterId = PSOUsage.Id
    AND PSOUsageT.LanguageNo = 2
LEFT JOIN PtStandingOrderPreDefType PSOPDType ON PSOPDType.PreDefTypeNo = PSO.PreDefTypeNo
LEFT JOIN AsText PSOPDTypeT ON PSOPDTypeT.MasterId = PSOPDType.Id
    AND PSOPDTypeT.LanguageNo = 2
JOIN AsPeriodRule APRule ON APRule.PeriodRuleNo = PSO.PeriodRuleNo
JOIN AsText APRuleT ON APRuleT.MasterId = APRule.Id
    AND APRuleT.LanguageNo = 2
LEFT JOIN PtChargeBorneType PChBType ON PChBType.ChargeBorneTypeNo = PSO.ChargeBorneTypeNo
LEFT JOIN AsText PChBTypeT ON PChBTypeT.MasterId = PChBType.Id
    AND PChBTypeT.LanguageNo = 2
LEFT JOIN AsPayee AP ON AP.Id = PSO.PayeeId
LEFT JOIN AsBCIndex ABCI ON ABCI.Id = AP.BCId
 
LEFT JOIN PrReference PREF ON PREF.Id = PSO.CreditReferenceId
LEFT JOIN PtAccountBase PABInternal ON PABInternal.Id = PREF.AccountId
LEFT JOIN PtPortfolio PPInternal ON PPInternal.Id = PABInternal.PortfolioId
LEFT JOIN PtBase PBInternal ON PBInternal.Id = PPInternal.PartnerId
LEFT JOIN PtDescriptionView PDVInternal ON PDVInternal.Id = PBInternal.Id
 
JOIN PtAccountBase PAB ON PAB.Id = PSO.AccountId
JOIN PtPortfolio PP ON PP.Id = PAB.PortfolioId
JOIN PtBase PB ON PB.Id = PP.PartnerId
JOIN PtDescriptionView PDV ON PDV.Id = PB.Id
WHERE PSO.HdVersionNo BETWEEN 1 AND 999999998
 
ORDER BY standingOrder_status ASC

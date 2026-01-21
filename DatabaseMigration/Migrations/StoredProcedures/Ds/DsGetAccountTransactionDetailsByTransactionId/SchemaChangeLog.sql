--liquibase formatted sql

--changeset system:create-alter-procedure-DsGetAccountTransactionDetailsByTransactionId context:any labels:c-any,o-stored-procedure,ot-schema,on-DsGetAccountTransactionDetailsByTransactionId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DsGetAccountTransactionDetailsByTransactionId
CREATE OR ALTER PROCEDURE dbo.DsGetAccountTransactionDetailsByTransactionId
@TransactionId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        RTID.Id AS account_transactions_id,
        RTID.AccountId AS account_id,
        RTID.OwnAccount AS account_transactions_ownAccount_iban,
        PABOwnAccount.AccountNo AS account_transactions_ownAccount_otherAccountIdentification_technical,
        PABOwnAccount.AccountNoEdited AS account_transactions_ownAccount_otherAccountIdentification_formatted,
        PABOwnAccount.CustomerReference AS account_transactions_ownAccount_designation,
        PREFOwnAccount.Currency AS account_transactions_ownAccount_currency,
        RTID.EntryId AS account_transactions_entry_id,
        RTID.GroupId AS account_transactions_groupKey,
        RTID.EntryReference AS account_transactions_entryReference,
        RTID.EntryReferenceInternal AS account_transactions_entryReferenceInternal_id,
        RTID.EntryReferenceInternalType AS account_transactions_entryReferenceInternal_type,
        RTID.SourceId AS account_transactions_source_id,
        RTID.SourceNumber AS account_transactions_source_number,
        RTID.SourceType AS account_transactions_source_type,

        CASE WHEN RTID.ReversalIndicator = 1 THEN 'true' ELSE 'false' END AS account_transactions_reversalIndicator,

        RTID.BookingDate AS account_transactions_transactionDate,
        RTID.TransDate AS account_transactions_transactionDateTime,
        RTID.ValueDate AS account_transactions_valueDate,
        RTID.CreditDebitIndicator AS account_transactions_creditDebitIndicator,
        RTID.ExchangeRate AS account_transactions_exchangeRate,
        RTID.OriginalAmount AS account_transactions_original_amount,
        RTID.OriginalCurrency AS account_transactions_original_currency_translationCode,
        'currencySymbol' AS account_transactions_original_currency_translationKey,
        RTID.Amount AS account_transactions_amount,
        RTID.Currency AS account_transactions_currency_translationCode,
        'currencySymbol' AS account_transactions_currency_translationKey,
        RTID.TotalChargesAndTaxAmount AS account_transactions_totalChargesAndTaxAmount_amount,
        RTID.TotalChargesAndTaxCurrency AS account_transactions_totalChargesAndTaxAmount_currency_translationCode,
        'currencySymbol' AS account_transactions_totalChargesAndTaxAmount_currency_translationKey,
        RTID.ChargesRecords AS account_transactions_chargesRecords,
        RTID.EndToEndId AS account_transactions_endToEnd_id,
        RTID.TxDomainCode AS account_transactions_bankTransactionCode_domain,
        RTID.TxFamilyCode AS account_transactions_bankTransactionCode_family,
        RTID.TxSubFamilyCode AS account_transactions_bankTransactionCode_subFamily,
        RTID.TxProprietaryCode AS account_transactions_transactionCode_translationCode,
        'transactionCode' AS account_transactions_transactionCode_translationKey,
        RTID.TransactionId AS account_transactions_transaction_id,
        RTID.CounterPartyName AS account_transactions_counterParty_name,
        RTID.CounterPartyStreetName AS account_transactions_counterParty_postalAddress_structured_streetName,
        RTID.CounterPartyBuildingNo AS account_transactions_counterParty_postalAddress_structured_buildingNumber,
        RTID.CounterPartyPostCode AS account_transactions_counterParty_postalAddress_structured_postCode,
        RTID.CounterPartyTownName AS account_transactions_counterParty_postalAddress_structured_townName,
        RTID.CounterPartyCountry AS account_transactions_counterParty_postalAddress_structured_country,
        RTID.CounterPartyAddressLine1 AS account_transactions_counterParty_postalAddress_unstructured_addressLines1,
        RTID.CounterPartyAddressLine2 AS account_transactions_counterParty_postalAddress_unstructured_addressLines2,
        RTID.CounterPartyAddressLine3 AS account_transactions_counterParty_postalAddress_unstructured_addressLines3,
        RTID.CounterPartyAddressLine4 AS account_transactions_counterParty_postalAddress_unstructured_addressLines4,
        RTID.CounterPartyAccountType AS account_transactions_counterParty_account_type,
        RTID.CounterPartyAccount AS account_transactions_counterParty_account_identification,
        RTID.Bic AS account_transactions_agent_bic,
        RTID.ClearingSystemCode AS account_transactions_agent_clearningSystemMemberIdentification_code,
        RTID.ClearingSystemMemberId AS account_transactions_agent_clearningSystemMemberIdentification_memberId,
        RTID.UnstructuredReference AS account_transactions_remittanceInformation,
        RTID.ReferenceType AS account_transactions_remittanceReference_type,
        RTID.Reference AS account_transactions_remittanceReference_reference,
        RTID.AdditionalInformation AS account_transactions_additionalInformation,
        PTRM.id AS account_transactions_messageId,

        -- Business Use Case
        CASE
            WHEN RTID.TxProprietaryCode = 34 AND RTID.OriginalCurrency = RTID.Currency THEN 'payment_transfer'
            WHEN RTID.TxProprietaryCode = 34 AND RTID.OriginalCurrency <> RTID.Currency THEN 'payment_exchange'
            WHEN RTID.TxProprietaryCode = 38 AND (PPOwnAccount.PartnerId = PPCounterPartyAccount.PartnerId AND RTID.OriginalCurrency = RTID.Currency) THEN 'recurring_payment_transfer'
            WHEN RTID.TxProprietaryCode = 38 AND (PPOwnAccount.PartnerId = PPCounterPartyAccount.PartnerId AND RTID.OriginalCurrency <> RTID.Currency) THEN 'recurring_payment_exchange'
            -- Add more cases as needed
            ELSE 'not_mapped'
        END AS account_transactions_businessUseCase,

        CASE WHEN PTRM.SalaryFlag = 1 THEN 'true' ELSE 'false' END AS account_transactions_salaryFlag,

        PTR.TransTypeNo AS account_transactions_transactionType_translationCode,
        'transactionType' AS account_transactions_transactionType_translationKey,
        PPO.OrderType AS account_transactions_paymentOrderType_translationCode,
        'paymentOrderType' AS account_transactions_paymentOrderType_translationKey,

        CASE 
            WHEN RTID.CreditDebitIndicator = 'DBIT' THEN PTRM.CreditMessageStandard
            WHEN RTID.CreditDebitIndicator = 'CRDT' THEN PTRM.DebitMessageStandard
            ELSE 'UNKNOWN'
        END AS account_transactions_messageStandard,

        PPO.Id AS account_transactions_paymentOrder_id,
        PC.ContractNo AS account_transactions_fxTrades_contract_no,
        SUBSTRING(PC.InternalRemark, 0 , CHARINDEX((CHAR(13)), PC.InternalRemark)) AS account_transactions_fxTrades_contract_orderId,
        PC.ExternalRemark AS account_transactions_fxTrades_contract_externalReference,

        CASE 
            WHEN RTID.CreditDebitIndicator = 'DBIT' THEN CAST(PTRM.Id AS varchar(36)) + '_D'
            WHEN RTID.CreditDebitIndicator = 'CRDT' THEN CAST(PTRM.Id AS varchar(36)) + '_C'
            ELSE 'UNKNOWN'
        END AS trans_correlation_key,

        RTID.HdCreateDate AS account_transactions_creationDate,
        GETUTCDATE() AS account_transactions_lastSyncDate,
        PTI.TransText AS account_transactions_transText,
        RTID.HdChangeDate AS account_transactions_lastModifiedDate,
        A.TransText AS account_transactions_detail_transText,

        CASE 
            WHEN PTI.Id IS NOT NULL THEN 'true'
            WHEN PTI.Id IS NULL THEN 'false'
            ELSE 'unknown'
        END AS account_transactions_isMainEntry,

        CASE
            WHEN RTID.GroupId IS NOT NULL THEN COUNT(*) OVER (PARTITION BY RTID.GroupId)
            ELSE NULL
        END AS account_transactions_numberOfDetails

    FROM RoTransItemDetail RTID
    LEFT JOIN PtTransItem PTI ON PTI.Id = RTID.Id
    LEFT JOIN (
        SELECT PTID.Id, PTID.TransText FROM PtTransItemDetail PTID
    ) A ON A.Id = RTID.Id
    JOIN PtAccountBase PABOwnAccount ON PABOwnAccount.Id = RTID.AccountId
    JOIN PrReference PREFOwnAccount ON PREFOwnAccount.AccountId = PABOwnAccount.Id
    JOIN PtPortfolio PPOwnAccount ON PPOwnAccount.Id = PABOwnAccount.PortfolioId
    LEFT JOIN PtAccountBase PABCounterPartyAccount ON PABCounterPartyAccount.AccountNoIbanElect = RTID.CounterPartyAccount
    LEFT JOIN PtPortfolio PPCounterPartyAccount ON PPCounterPartyAccount.Id = PABCounterPartyAccount.PortfolioId
    LEFT JOIN PtContract PC ON PC.FxTransId = RTID.TransactionId
    LEFT JOIN PtTransMessage PTRM ON PTRM.Id = RTID.TransMessageId
    LEFT JOIN PtAccountBase PABTRMD ON PABTRMD.AccountNo = PTRM.DebitAccountNo
    LEFT JOIN PtPortfolio PPTRMD ON PPTRMD.Id = PABTRMD.PortfolioId
    LEFT JOIN PtAccountBase PABTRMC ON PABTRMC.AccountNo = PTRM.CreditAccountNo
    LEFT JOIN PtPortfolio PPTRMC ON PPTRMC.Id = PABTRMC.PortfolioId
    LEFT JOIN PtTransItemText PTIT ON PTIT.TextNo = RTID.TxProprietaryCode
    LEFT JOIN AsText PTITT ON PTITT.MasterId = PTIT.Id AND PTITT.LanguageNo = 1
    JOIN PtTransaction PTR ON PTR.Id = RTID.TransactionId
    LEFT JOIN PtPaymentOrder PPO ON PPO.Id = PTR.PaymentOrderId

    WHERE RTID.TransactionId = @TransactionId;
END;


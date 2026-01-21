--liquibase formatted sql

--changeset system:create-alter-view-ExportMaturitiesContractsView context:any labels:c-any,o-view,ot-schema,on-ExportMaturitiesContractsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportMaturitiesContractsView
CREATE OR ALTER VIEW dbo.ExportMaturitiesContractsView AS
SELECT  PB.Id AS 'contract_partner_id',
        PB.PartnerNo AS 'contract_partner_no_numeric',
        PB.PartnerNoEdited AS 'contract_partner_no_formatted',
        PB.PartnerNoText AS 'contract_partner_no_textForSort',
        PDV.PtDescription AS 'contract_partner_description',
        PC.Id AS 'contract_id',
        PC.ContractNo AS 'contract_no',
        PC.SequenceNo AS 'contract_seqNo',
        PC.ContractType AS 'contract_type_no',
        ATPCType.TextShort AS 'contract_type_description',
        PC.Amount AS 'contract_amount',
        PC.Currency AS 'contract_currency',
        PC.InterestRate AS 'contract_interest_rate',
        ATAIP.TextShort AS 'contract_interest_practiceType',
        PAB.AccountNo AS 'contract_account_no_numeric',
        PAB.AccountNoEdited AS 'contract_account_no_formatted',
        PAB.AccountNoText AS 'contract_account_no_textForSort',
        PPRIV.ProductId AS 'contract_account_product_id',
        PPRIV.ProductNo AS 'contract_account_product_no',
        ATPPRIV.TextShort AS 'contract_account_product_description',
        PC.OrderDate AS 'contract_date_orderDate',
        PC.DateFrom AS 'contract_date_duration_from',
        PC.DateTo AS 'contract_date_duration_to',
        PC.InterestPaymentDate AS 'contract_date_interestPayment',
        PC.TerminationDate AS 'contract_date_terminationDate',
        PC.InternalRemark AS 'contract_remark_internal',
        PC.ExternalRemark AS 'contract_remark_external',
        PC.Status AS 'contract_status_no',
        ATPCS.TextShort AS 'contract_status_description',
        GETUTCDATE() AS 'lastSyncDate'
FROM    PtContract PC
JOIN    PtContractType PCType ON PCType.ContractType = PC.ContractType
JOIN    AsText ATPCType ON ATPCType.MasterId = PCType.Id
            AND ATPCType.LanguageNo = 2
JOIN    PtAccountBase PAB ON PAB.AccountNo = PC.CapitalAccountNo
JOIN    PtPortfolio PP ON PP.Id = PAB.PortfolioId
JOIN    PtBase PB ON PB.Id = PP.PartnerId
JOIN    PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN    PrReference PREF ON PREF.AccountId = PAB.Id
JOIN    PrPrivate PPRIV ON PPRIV.ProductId = PREF.ProductId
JOIN    AsText ATPPRIV ON ATPPRIV.MasterId = PPRIV.Id
            AND ATPPRIV.LanguageNo = 2
JOIN    AsInterestPractice AIP ON AIP.PracticeType = PC.InterestPracticeType
JOIN    AsText ATAIP ON ATAIP.MasterId = AIP.Id
            AND ATAIP.LanguageNo = 2
JOIN    PtContractStatus PCS ON PCS.ContractStatusNo = PC.Status
JOIN    AsText ATPCS ON ATPCS.MasterId = PCS.Id
            AND ATPCS.LanguageNo = 2
  
WHERE   PC.DateTo > DATEADD(year, -1, GETDATE())
        AND PCType.ContractType NOT IN (51, 52, 53)     -- Devisentermine & Spot Trades

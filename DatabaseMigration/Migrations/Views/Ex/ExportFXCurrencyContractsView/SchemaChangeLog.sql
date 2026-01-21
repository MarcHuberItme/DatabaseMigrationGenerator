--liquibase formatted sql

--changeset system:create-alter-view-ExportFXCurrencyContractsView context:any labels:c-any,o-view,ot-schema,on-ExportFXCurrencyContractsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportFXCurrencyContractsView
CREATE OR ALTER VIEW dbo.ExportFXCurrencyContractsView AS
SELECT  PC.Id AS 'contract_id',
        PC.ContractNo AS 'contract_no',
        PC.SequenceNo AS 'contract_seqNo',
        PC.ContractType AS 'contract_type_no',
        ATPCType.TextShort AS 'contract_type_description',
        PC.FxSellCurrency AS 'contract_fxSellCurrency',     -- nur Devisentermine
        PC.Amount AS 'contract_amount',
        PC.FxBuyCurrency AS 'contract_fxBuyCurrency',       -- nur Devisentermine
        (CASE   WHEN PCP.IsFxBuyer = 0 THEN 'Borrower'
                WHEN PCP.IsFxBuyer = 1 THEN 'Investor'
        END) AS 'contract_fxDealerType',
        PCP.PartnerDescription AS 'contract_dealer_description',
        PC.Status AS 'contract_status_no',
        ATPCS.TextShort AS 'contract_status_description',
        PC.OrderDate AS 'contract_date_orderDate',
        PC.DateFrom AS 'contract_date_duration_from',
        PC.DateTo AS 'contract_date_duration_to',
        PC.TerminationDate AS 'contract_date_terminationDate',
        PC.InternalRemark AS 'contract_remark_internal',
        PC.ExternalRemark AS 'contract_remark_external',
        GETUTCDATE() AS 'lastSyncDate'
FROM    PtContract PC
JOIN    PtContractType PCType ON PCType.ContractType = PC.ContractType
JOIN    AsText ATPCType ON ATPCType.MasterId = PCType.Id
            AND ATPCType.LanguageNo = 2
JOIN    PtContractStatus PCS ON PCS.ContractStatusNo = PC.Status
JOIN    AsText ATPCS ON ATPCS.MasterId = PCS.Id
            AND ATPCS.LanguageNo = 2
JOIN    PtContractPartner PCP ON PCP.ContractId = PC.Id
WHERE   PC.DateTo > DATEADD(year, -1, GETDATE())
AND     PC.ContractType IN (51, 52, 53)         -- Devisentermine & Spot Trades
AND     PCP.HdVersionNo BETWEEN 1 AND 999999998

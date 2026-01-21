--liquibase formatted sql

--changeset system:create-alter-view-PrSafeDepositChargeLastView context:any labels:c-any,o-view,ot-schema,on-PrSafeDepositChargeLastView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrSafeDepositChargeLastView
CREATE OR ALTER VIEW dbo.PrSafeDepositChargeLastView AS
SELECT TOP 100 PERCENT a.Id, 
    a.HdCreateDate, 
    a.HdCreator, 
    a.HdChangeDate, 
    a.HdEditStamp, 
    a.HdVersionNo, 
    a.HdProcessId, 
    a.HdStatusFlag, 
    a.HdNoUpdateFlag, 
    a.HdPendingChanges, 
    a.HdPendingSubChanges, 
    a.HdTriggerControl, 
    a.Partner_ID AS VPartnerID, 
    a.BranchNo AS VBranchNo, 
    a.BoxNo AS VBoxNo, 
    a.PeriodBegin AS VPeriodBegin, 
    a.PeriodEnd AS VPeriodEnd, 
    a.ChargeType AS VChargeType, 
    a.ChargeAmount AS VChargeAmount, 
    a.ReportDate AS VReportDate, 
    a.IsBooked AS VIsBooked, 
    a.IsManualPrinted AS VIsManualPrinted,
    a.ContractID AS VContractID, 
    a.DebitAccountNo AS VDebitAccountNo, 
    a.SafeDepositBoxID AS VSafeDepositBoxID,
    a.TransactionID As VTransactionID
FROM dbo.PrSafeDepositChargeSummary a INNER JOIN
    (SELECT ContractID, MAX(PeriodEnd) AS PeriodEnd 
        FROM PrSafeDepositChargeSummary
        GROUP BY ContractID, ChargeType) b ON a.ContractID = b.ContractID AND a.PeriodEnd = b.PeriodEnd
        WHERE (a.HdVersionNo < 999999999) AND (a.IsBooked = 1) And a.ChargeType<>2

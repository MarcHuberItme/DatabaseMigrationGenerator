--liquibase formatted sql

--changeset system:create-alter-procedure-GetEbankingPendingVisumCounter context:any labels:c-any,o-stored-procedure,ot-schema,on-GetEbankingPendingVisumCounter,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetEbankingPendingVisumCounter
CREATE OR ALTER PROCEDURE dbo.GetEbankingPendingVisumCounter
@EbankingAgrId uniqueidentifier,
@HideSuspendedPaymentsAfterDays AS int
 
AS

-- added usage of Common Table Expression (CTE)
-- CTE works better than temp table for contracts with more than 1000 accounts, with less accounts its better to use temp table.
with AccountList_CTE as (
						   SELECT Acc.AccountNo, AgrDet.AccountId, AgrDet.DTAVisumNo, AgrDet.PaymentVisumNo, AgrDet.StandingOrderVisumNo
						   FROM PtAgrEBankingDetail AS AgrDet WITH (NOLOCK) 
						   INNER JOIN PtAgrEBanking AS Agr WITH (NOLOCK) ON AgrDet.AgrEBankingId = Agr.Id 
						   INNER JOIN PtAccountBase as Acc WITH (NOLOCK) ON AgrDet.AccountId = Acc.Id
						   WHERE AgrDet.AgrEBankingId = @EbankingAgrId
										 AND AgrDet.AccountId IS NOT NULL
										 AND AgrDet.ValidFrom < GETDATE()
										 AND AgrDet.ValidTo > GETDATE()
										 AND AgrDet.HasAccess = 1
										 AND AgrDet.InternetbankingAllowed = 1
										 AND AgrDet.HdVersionNo BETWEEN 1 AND 999999998
										 AND Agr.BeginDate < GETDATE()
										 AND Agr.ExpirationDate > GETDATE()
										 AND Agr.HdVersionNo BETWEEN 1 AND 999999998	
							)
						  


--Filetransfer
SELECT 'CMFileConfirmation' AS Source, 
COUNT(id) as Count
FROM
    CmPainFileOverview
WHERE
    (
        (EBankingId = @EbankingAgrId)
        AND (
            (MinStatus < 4)
            OR (MaxStatus IS NULL)
            OR (MaxStatus > 4)
        )
        AND (ProcessingStatus = 1)
        AND (
            (FileUploaderId <> @EbankingAgrId)
            OR (FileUploaderId IS NULL)
        )
        AND (
            (FirstApprovalId <> @EbankingAgrId)
            OR (FirstApprovalId IS NULL)
        )
        OR (
            (
                DebitAccountCheckMethod = 'BLink'
            )
            AND (EBankingId = @EbankingAgrId)
            AND (ProcessingStatus = 1)
            AND (
                (DTAVisumNo = 2)
                OR (FirstApprovalId <> @EbankingAgrId)
                AND (DTAVisumNo >= 1)
            )
        )
    )



UNION ALL 
-- PaymentOrder
SELECT 'PtPaymentOrder', COUNT(*)  FROM PtPaymentOrder AS PO WITH (NOLOCK) 
INNER JOIN PtPaymentOrderType as PT WITH (NOLOCK) ON PO.OrderType = PT.OrderTypeNo
WHERE PT.EBankingPermission = 31 -- Only editable payment orders  (63,64)
AND PO.ScheduledDate > DATEADD(d,-45,GETDATE()) -- nur die letzten 45 Tage berücksichtigen, nur zur Performance Optimierung
AND PO.HdVersionNo BETWEEN 1 AND 999999998
AND Status < 2
AND PO.FileImportProcessId IS NULL
AND PO.EBankingId IS NOT NULL
AND PO.EBankingId <> @EbankingAgrId
AND (PO.EBankingIdVisum1 IS NULL OR PO.EBankingIdVisum1 <> @EbankingAgrId)
AND PO.EBankingIdVisum2 IS NULL
AND PO.SenderAccountNo IN (SELECT AccountNo From AccountList_CTE WHERE PaymentVisumNo IN (1,2))
AND PO.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

-- Standing Order 
SELECT 'PtStandingOrder', COUNT(*)  FROM PtStandingOrder AS SO WITH (NOLOCK) 
WHERE SO.HdVersionNo BETWEEN 1 AND 999999998
AND SO.EBankingId IS NOT NULL
AND SO.EBankingId <> @EbankingAgrId
AND (SO.EBankingIdVisum1 IS NULL OR SO.EBankingIdVisum1 <> @EbankingAgrId)
AND SO.EBankingIdVisum2 IS NULL
AND SO.AccountId IN (SELECT AccountId From AccountList_CTE WHERE StandingOrderVisumNo IN (1,2))

UNION ALL

-- Suspended Payments
SELECT 'SuspendedPayments', COUNT(*)  FROM PtPaymentOrder AS PO WITH (NOLOCK) 
INNER JOIN PtPaymentOrderType AS PT WITH (NOLOCK)  ON PT.OrderTypeNo = PO.OrderType
INNER JOIN PtPaymentOrderDetail AS POD WITH (NOLOCK) ON POD.OrderId = PO.Id 
WHERE PO.EBankingId IS NOT NULL
AND PO.ScheduledDate > 
    CASE 
        WHEN @HideSuspendedPaymentsAfterDays = 0 THEN 0
        ELSE DATEADD(DAY, -@HideSuspendedPaymentsAfterDays, GETDATE())
    END
AND PO.HdVersionNo BETWEEN 1 AND 999999998
AND PO.EBankingId IS NOT NULL
AND PO.Status = 13
AND PO.SenderAccountNo IN
(	
	SELECT AccountNo From AccountList_CTE 
)
AND PO.ScheduledDate > '2024-01-01'
AND PT.EBankingPermission > 0

--liquibase formatted sql

--changeset system:create-alter-view-CmPainFileOverview context:any labels:c-any,o-view,ot-schema,on-CmPainFileOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CmPainFileOverview
CREATE OR ALTER VIEW dbo.CmPainFileOverview AS
SELECT DISTINCT fip.Id,
	fip.MessageId,
	fip.FileName,
	fip.CanBeProcessed,
	fip.FileStatus,
	fip.ImportDate AS UploadDate,
	fip.EBankingId AS FileUploaderId,
	fip.HdChangeDate,
	MIN(fid.DTAVisumNo) DTAVisumNo,
	ISNULL(ps.DebitAccountCheckMethod, 'EBanking') as DebitAccountCheckMethod,
	MAX(DATEADD(dd, DATEDIFF(dd, 0, fip.FileImportReleaseTime), 0)) AS ProcessedDate,
	FaultyPayments = CASE 
		WHEN (
				SELECT COUNT(Id)
				FROM CMFileImportPaymentError
				WHERE FileImportProcessId = fip.Id
				) > 0
			THEN (
					SELECT COUNT(Id)
					FROM CMFileImportPaymentError
					WHERE FileImportProcessId = fip.Id
					)
		ELSE 0
		END,
	(
		SELECT SUM(PtPaymentOrder.TotalReportedTransactions)
		FROM PtPaymentOrder
		WHERE FileImportProcessId = fip.Id
			AND (
				PtPaymentOrder.HdVersionNo BETWEEN 1
					AND 999999998
				)
		) AS TotalPayments,
	(
		SELECT SUM(PtPaymentOrder.TotalReportedAmount)
		FROM PtPaymentOrder
		WHERE FileImportProcessId = fip.Id
			AND (
				PtPaymentOrder.HdVersionNo BETWEEN 1
					AND 999999998
				)
		) AS TotalAmount,
	MAX(po.STATUS) AS MaxStatus,
	MIN(po.STATUS) AS MinStatus,
	upload.MgVTNo AS FileUploaderName,
	(
		SELECT TOP 1 fc.EbankingIdVisum1
		FROM CMFileConfirmation fc
		WHERE fc.FileImportProcessId = fip.Id
		ORDER BY Id
		) AS FirstApprovalId,
	MAX(DATEADD(dd, DATEDIFF(dd, 0, fip.FileImportConfirmationTime), 0)) AS ApprovalDate,
	(
		SELECT TOP 1 aeb.MgVTNo
		FROM PtAgrEBanking aeb
		INNER JOIN CMFileConfirmation fc ON fc.EbankingIdVisum1 = aeb.Id
		WHERE fc.FileImportProcessId = fip.Id
		ORDER BY fc.Id
		) AS FirstApprovalName,
	aeb.Id AS EBankingId,
	ProcessingStatus = CASE 
		WHEN fip.FileStatus = 0
			THEN 0 -- ToBeImported -> Importing 
		WHEN fip.FileStatus = 1
			THEN 0 -- Processing -> Importing
		WHEN fip.FileStatus = 2
			THEN 1 -- MissingConfirmation -> ApprovalPending 
		WHEN fip.FileStatus = 4
			THEN 3 -- Processing
		WHEN fip.FileStatus = 90
			THEN 5 -- ReadError -> ErrorUploading 
		WHEN fip.FileStatus = 91
			THEN 6 -- ProcessingError -> ErrorInFile 
		WHEN (
				min(po.STATUS) = 0
				OR max(po.STATUS) = 0
				)
			AND fip.FileStatus = 3
			THEN 0 -- Importing
		WHEN max(po.STATUS) <= 4
			AND min(po.STATUS) >= 4
			AND fip.FileStatus = 3
			THEN 4 --Processed 
		WHEN (
				SELECT COUNT(Id)
				FROM PtPaymentOrder po
				WHERE STATUS = 4
					AND FileImportProcessId = fip.Id
					AND HdVersionNo BETWEEN 1
						AND 999999998
				) > 0
			THEN 7 -- Partially Processed 
		WHEN min(po.STATUS) >= 2
			AND max(po.STATUS) <= 4
			AND fip.FileStatus = 3
			THEN 3 --Processing
		WHEN fip.CanBeProcessed = 1
			AND fip.FileStatus = 3
			THEN 3 -- Processing
		WHEN (
				min(po.STATUS) = 1
				AND max(po.STATUS) = 2
				)
			AND fip.FileStatus = 3
			THEN 2 --ReadyForProcessing 	
		WHEN (
				min(po.STATUS) = 1
				AND max(po.STATUS) = 1
				)
			AND fip.FileStatus = 3
			THEN 2 --ReadyForProcessing 
		ELSE 3
			--when min(O.Status) = 12 and F.FileStatus = 3 then 5 --Pendent über Ausführungsdatum hinaus
		END
FROM PtAgrEBanking aeb
INNER JOIN (
	SELECT DISTINCT fip.Id,
		aeb.Id AS EBankingId,
		aebd.DTAVisumNo
	FROM PtAgrEBanking aeb
	INNER JOIN PtAgrEBankingDetail aebd ON aebd.AgrEBankingId = aeb.Id
	INNER JOIN CMFileConfirmation fc ON fc.AccountId = aebd.AccountId
	INNER JOIN CMFileImportProcess fip ON fip.Id = fc.FileImportProcessId
	WHERE aeb.HdVersionNo BETWEEN 1
			AND 999999998
		AND aebd.HdVersionNo BETWEEN 1
			AND 999999998
		AND fc.HdVersionNo BETWEEN 1
			AND 999999998
		AND fip.HdVersionNo BETWEEN 1
			AND 999999998
		AND fip.SystemCode = 'PAIN001'
		AND (aebd.HasAccess = 1)
		AND (aebd.InternetbankingAllowed = 1)
		AND (aebd.ValidFrom < GETDATE())
		AND (aebd.ValidTo > GETDATE())
	) fid ON fid.EBankingId = aeb.Id
INNER JOIN CMFileImportProcess fip ON fip.id = fid.id
LEFT OUTER JOIN CMPainImportStatus pis on pis.FileImportProcessId = fip.Id
LEFT OUTER JOIN PtPainImportSettings ps on ps.Id = pis.PainImportSettingId
LEFT OUTER JOIN PtAgrEBanking AS upload ON (upload.Id = fip.EBankingId)
	AND (
		upload.HdVersionNo BETWEEN 1
			AND 999999998
		)
LEFT OUTER JOIN PtPaymentOrder po ON po.FileImportProcessId = fip.id
	AND po.Status != 13
	AND po.HdVersionNo BETWEEN 1
		AND 999999998
GROUP BY fip.Id,
	fip.MessageId,
	fip.FileName,
	fip.ImportDate,
	fip.CanBeProcessed,
	fip.FileStatus,
	fip.EBankingId,
	fip.HdChangeDate,
	aeb.Id,
	upload.MgVTNo,
	ps.DebitAccountCheckMethod

--liquibase formatted sql

--changeset system:create-alter-view-PtCamtExport context:any labels:c-any,o-view,ot-schema,on-PtCamtExport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCamtExport
CREATE OR ALTER VIEW dbo.PtCamtExport AS
SELECT * FROM (
	(SELECT [InitialDownloadAgr].[MgVTNo],
		[PtAccountBase].[Id] AS [AccountId],
		[PtAccountBase].[AccountNo],
		[PtAccountBase].[AccountNoEdited],
		[PrReference].[Currency],
		[PtTransEsrFile].[HdCreateDate],
		[PtTransEsrFile].[Id],
		[PtTransEsrFile].[UserFilename],
		[PtTransEsrFile].[DateFrom],
		[PtTransEsrFile].[DateTo],
		[PtTransEsrFile].[NumberOfPayments],
		[PtTransEsrFile].[TransferTime],
		[PtTransEsrFile].[TotalAmount],
		[PtAgrEBanking].[Id] AS EBankingId,
		NULL AS [FileType]
	FROM [PtAgrEBanking]
	INNER JOIN [PtAgrEBankingDetail] ON ([PtAgrEBankingDetail].[AgrEBankingId] = [PtAgrEBanking].[Id])
	INNER JOIN [PtAccountBase] ON ([PtAccountBase].[Id] = [PtAgrEBankingDetail].[AccountId])
	INNER JOIN [PtTransEsrFile] ON ([PtTransEsrFile].[AccountId] = [PtAccountBase].[Id])
	INNER JOIN [PrReference] ON ([PrReference].[AccountId] = [PtAccountBase].[Id])
	LEFT OUTER JOIN [PtAgrEBanking] AS [InitialDownloadAgr] ON ([InitialDownloadAgr].[Id] = [PtTransEsrFile].[EbankingId])
	WHERE ([PtAgrEBankingDetail].[HasAccess] = 1)
		AND ([PtAgrEBankingDetail].[InternetbankingAllowed] = 1)
		AND ([PtAgrEBankingDetail].[ValidFrom] < GETDATE())
		AND ([PtAgrEBankingDetail].[ValidTo] > GETDATE())
	)
UNION
	(SELECT [InitialDownloadAgr].[MgVTNo],
		[PtAccountBase].[Id] AS [AccountId],
		[PtAccountBase].[AccountNo],
		[PtAccountBase].[AccountNoEdited],
		[PrReference].[Currency],
		[IfCamtDownloadHistory].[HdCreateDate],
		[IfCamtDownloadHistory].[Id],
		[IfCamtDownloadHistory].[Filename],
		[IfCamtDownloadHistory].[DateFrom],
		[IfCamtDownloadHistory].[DateTo],
		[IfCamtDownloadHistory].[NumberOfEntries],
		[IfCamtDownloadHistory].[DownloadDate],
		(
			SELECT CASE [IfDeliverySetting].[Type] 
				WHEN 'camt053' 
					THEN NULL 
					ELSE SUM(Amount) 
				END 
				FROM (
				(
					SELECT SUM(Amount) Amount FROM IfCamtEntryDetailDelivery WHERE TransformId IN (
						SELECT h.Id 
						FROM IfDeliveryHistory h 
						Inner join IfDeliveryItem d on d.RefItemid = [PtAccountBase].[Id] 
						WHERE h.DeliverySettingId = IfDeliverySetting.Id 
						and h.DeliveryItemId = d.Id
						AND h.StartDateTime between [IfCamtDownloadHistory].[DateFrom] and [IfCamtDownloadHistory].[DateTo]
						AND h.EndDateTime between [IfCamtDownloadHistory].[DateFrom] and [IfCamtDownloadHistory].[DateTo]
						AND [IfDeliverySetting].[Type] = 'camt054esr'
						AND [IfDeliverySetting].IsEbankingVisible = 1
					)
				)
				UNION
				(
					select sum(Amount) 
					from PtTransEsrData ted
					where AccountId = [PtAccountBase].[Id] 
					AND ted.TransDate between [IfCamtDownloadHistory].[DateFrom] and [IfCamtDownloadHistory].[DateTo]
					AND ted.TransDate between [IfCamtDownloadHistory].[DateFrom] and [IfCamtDownloadHistory].[DateTo]
					AND NOT EXISTS(
						SELECT * 
						FROM IfDeliveryHistory h 
						Inner join IfDeliveryItem d on d.RefItemid = [PtAccountBase].[Id] 
						WHERE h.DeliverySettingId = IfDeliverySetting.Id 
						and h.DeliveryItemId = d.Id
						AND h.StartDateTime >= ted.TransDate 
						AND h.EndDateTime <= ted.TransDate 
						AND [IfDeliverySetting].[Type] = 'camt054esr'
						AND [IfDeliverySetting].IsEbankingVisible = 1
					)
					group by TransDate 
				) 
			) 
			AS [Amount]),
		[PtAgrEBanking].[Id] AS EBankingId,
		[IfDeliverySetting].[Type] AS [FileType]
	FROM [PtAgrEBanking]
	INNER JOIN [PtAgrEBankingDetail] ON ([PtAgrEBankingDetail].[AgrEBankingId] = [PtAgrEBanking].[Id])
	INNER JOIN [PtAccountBase] ON ([PtAccountBase].[Id] = [PtAgrEBankingDetail].[AccountId])
	INNER JOIN [IfCamtDownloadHistory] ON ([IfCamtDownloadHistory].[AccountId] = [PtAccountBase].[Id])
	INNER JOIN [IfDeliveryHistory] ON ([IfDeliveryHistory].Id = [IfCamtDownloadHistory].DeliveryHistoryId)
	INNER JOIN [IfDeliverySetting] ON ([IfDeliverySetting].Id = [IfDeliveryHistory].DeliverySettingId)
	INNER JOIN [PrReference] ON ([PrReference].[AccountId] = [PtAccountBase].[Id])
	LEFT OUTER JOIN [PtAgrEBanking] AS [InitialDownloadAgr] ON ([InitialDownloadAgr].[Id] = [IfCamtDownloadHistory].[DownloadEBankingId])
	WHERE ([IfCamtDownloadHistory].[DownloadDate] IS NOT NULL)
			AND ([PtAgrEBankingDetail].[HasAccess] = 1)
			AND ([PtAgrEBankingDetail].[InternetbankingAllowed] = 1)
			AND ([PtAgrEBankingDetail].[ValidFrom] < GETDATE())
			AND ([PtAgrEBankingDetail].[ValidTo] > GETDATE())
	)) D


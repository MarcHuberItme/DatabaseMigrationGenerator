--liquibase formatted sql

--changeset system:create-alter-procedure-GetCamt054EsrDataWithDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCamt054EsrDataWithDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCamt054EsrDataWithDate
CREATE OR ALTER PROCEDURE dbo.GetCamt054EsrDataWithDate
@AccountId uniqueidentifier,
@DateFrom DATETIME,
@DateTo DATETIME
AS
SELECT AccountId, AccountNoIbanElect, AccountNoEdited, AccountNo, Currency, SUM(NumberOfEntries) AS NumberOfEntries, SUM(Amount) AS Amount
FROM (
SELECT
	ab.Id as AccountId,
	ab.AccountNoIbanElect,
	ab.AccountNoEdited,
	ab.AccountNo,
	R.Currency,
	COUNT(cedd.Id) AS NumberOfEntries, 
	SUM(cedd.Amount) AS Amount
from IfDeliveryItem idi  
left outer join IfDeliverySetting ds on ds.Id = idi.DeliverySettingId and ds.HdVersionNo between 1 and 999999998
left outer join IfDeliveryHistory idh on idh.DeliveryItemId = idi.id and idh.HdVersionNo between 1 and 999999998
left outer join PtAccountBase ab on ab.Id = idi.RefItemId and ab.HdVersionNo between 1 and 999999998
INNER JOIN IfCamtEntryDetailDelivery cedd ON cedd.TransformId = idh.Id AND cedd.HdVersionNo BETWEEN 1 AND 999999998
JOIN PrReference as R ON ab.Id = R.AccountId and R.HdVersionNo between 1 and 999999998
JOIN PrPrivate as P ON R.ProductId = P.ProductId and P.HdVersionNo between 1 and 999999998
where idi.RefItemId = @AccountId
and idi.HdVersionNo between 1 and 999999998
and ds.IsEbankingVisible = 1
and idh.StartDateTime >= @DateFrom
and idh.EndDateTime <= @DateTo
and ds.Type = 'camt054esr'
AND ds.Name = 'camt-esr-ebanking'
GROUP BY ab.Id, ab.AccountNoIbanElect, ab.AccountNo, ab.AccountNoEdited, R.Currency
UNION
SELECT [PtTransEsrData].[AccountId]
	,[PtTransEsrData].[AccountNoIban]
	,[PtAccountBase].[AccountNoEdited]
	,[PtAccountBase].[AccountNo]
	,[PtTransEsrData].[Currency],
	COUNT([PtTransEsrData].[Id]),
	SUM([PtTransEsrData].[Amount])
FROM [PtTransEsrData]
INNER JOIN [PtAccountBase] ON ([PtAccountBase].[Id] = [PtTransEsrData].[AccountId])
	AND ([PtAccountBase].[Id] = @AccountId)
	AND (
		[PtTransEsrData].[TransDate] BETWEEN @DateFrom
			AND @DateTo
		)
LEFT OUTER JOIN [PtTransMessage] ON ([PtTransMessage].[Id] = [PtTransEsrData].[TransMessageId])
	AND (
		[PtTransMessage].[HdVersionNo] BETWEEN 1
			AND 999999998
		)
WHERE (
		[PtTransEsrData].[HdVersionNo] BETWEEN 0
			AND 999999998
		)
	AND (
		[PtAccountBase].[HdVersionNo] BETWEEN 1
			AND 999999998
		)
	AND [PtTransEsrData].TransDate < (SELECT ISNULL(MIN(StartDateTime), '2199-12-31')
		FROM IfDeliveryHistory idh
		INNER JOIN IfDeliveryItem di ON di.Id = idh.DeliveryItemId
		INNER JOIN IfDeliverySetting ds ON ds.Id = di.DeliverySettingId
		WHERE di.RefItemId = @AccountId
        AND idh.HdVersionNo BETWEEN 1 AND 999999998
		AND ds.Name = 'camt-esr-ebanking')
GROUP BY [PtTransEsrData].[AccountId], [PtTransEsrData].[AccountNoIban], [PtAccountBase].[AccountNoEdited], [PtAccountBase].[AccountNo],[PtTransEsrData].[Currency]
) as Data
GROUP BY AccountId, AccountNoIbanElect, AccountNoEdited, AccountNo, Currency

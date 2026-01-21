--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingCamt053DataForAgreement context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingCamt053DataForAgreement,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingCamt053DataForAgreement
CREATE OR ALTER PROCEDURE dbo.GetPendingCamt053DataForAgreement
@AgreementId UNIQUEIDENTIFIER,
@LanguageNo int   

AS
SELECT ab.Id AS AccountId
	,ab.AccountNo
	,ab.AccountNoEdited
	,R.Currency
	,IsNull(ab.CustomerReference, IsNull(Acc_AsText.TextShort, Prod_AsText.TextShort)) AS TextShort
	,NULL AS Amount
	,Count(cedd.id) AS NumberOfEntries
	,idh.StartDateTime AS DateFrom
	,idh.EndDateTime AS DateTo
	,idh.State
	,idh.Id
	,1 AS ProcessingStatus
FROM ptagrebanking pae
LEFT OUTER JOIN ptagrebankingdetail paed ON paed.AgrEBankingId = pae.id
	AND paed.HdVersionNo BETWEEN 1
		AND 999999998
LEFT OUTER JOIN IfDeliveryItem idi ON (
		(
			paed.AccountId = idi.RefItemId
			AND idi.RefTableName = 'PtAccountBase'
			)
		OR (
			paed.Id = idi.RefItemId
			AND idi.RefTableName = 'PtAgrEBankingDetail'
			)
		)
	AND idi.HdVersionNo BETWEEN 1
		AND 999999998
LEFT OUTER JOIN IfDeliverySetting ds ON ds.Id = idi.DeliverySettingId
	AND ds.HdVersionNo BETWEEN 1
		AND 999999998
LEFT OUTER JOIN IfDeliveryHistory idh ON idh.DeliveryItemId = idi.id
	AND idh.HdVersionNo BETWEEN 1
		AND 999999998
LEFT OUTER JOIN PtAccountBase ab ON paed.AccountId = ab.Id
	AND ab.HdVersionNo BETWEEN 1
		AND 999999998
INNER JOIN IfCamtEntryDetailDelivery cedd ON cedd.TransformId = idh.Id
	AND cedd.HdVersionNo BETWEEN 1
		AND 999999998
JOIN PrReference AS R ON ab.Id = R.AccountId
	AND R.HdVersionNo BETWEEN 1
		AND 999999998
JOIN PrPrivate AS P ON R.ProductId = P.ProductId
	AND P.HdVersionNo BETWEEN 1
		AND 999999998
LEFT OUTER JOIN PrPrivateCharacteristic Prod_char ON P.ProductNo = Prod_char.ProductNo
	AND Prod_char.IsDefault = 1
LEFT OUTER JOIN AsText Prod_AsText ON Prod_char.Id = Prod_AsText.MasterId
	AND Prod_AsText.LanguageNo = @LanguageNo
LEFT OUTER JOIN PrPrivateCharacteristic Acc_char ON ab.CharacteristicNo = Acc_char.CharacteristicNo
LEFT OUTER JOIN AsText Acc_AsText ON Acc_char.Id = Acc_AsText.MasterId
	AND Acc_AsText.LanguageNo = @LanguageNo
WHERE pae.id = @AgreementId
	AND ds.IsEbankingVisible = 1
	AND paed.HasAccess = 1
	AND paed.InternetbankingAllowed = 1
	AND paed.ValidFrom < GETDATE()
	AND paed.ValidTo > GETDATE()
	AND idh.STATE = 128
	AND ds.Name = 'camt-ebanking'
	AND pae.HdVersionNo BETWEEN 1
		AND 99999998
GROUP BY ab.Id
	,ab.AccountNo
	,ab.AccountNoEdited
	,R.Currency
	,ab.CustomerReference
	,Acc_AsText.TextShort
	,Prod_AsText.TextShort
	,idh.StartDateTime
	,idh.EndDateTime
	,idh.STATE
	,idh.Id


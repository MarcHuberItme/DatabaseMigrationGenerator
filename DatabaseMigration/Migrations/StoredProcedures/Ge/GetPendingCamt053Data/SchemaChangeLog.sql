--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingCamt053Data context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingCamt053Data,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingCamt053Data
CREATE OR ALTER PROCEDURE dbo.GetPendingCamt053Data
@AgreementId UNIQUEIDENTIFIER,
@AccountId UNIQUEIDENTIFIER,
@LanguageNo int   

AS
SELECT
	ab.Id as AccountId,
	ab.AccountNo,
	ab.AccountNoEdited,
	R.Currency,
	IsNull(ab.CustomerReference, IsNull(Acc_AsText.TextShort, Prod_AsText.TextShort)) as TextShort, 
	null as Amount, 	
	Count(cedd.id) as NumberOfEntries,
	idh.StartDateTime as DateFrom, 
	idh.EndDateTime as DateTo,
	idh.State,
	idh.Id,
	1 as ProcessingStatus
from ptagrebanking pae
left outer join ptagrebankingdetail paed on paed.AgrEBankingId = pae.id and paed.HdVersionNo between 1 and 999999998
left outer join IfDeliveryItem idi on ((paed.AccountId = idi.RefItemId and idi.RefTableName = 'PtAccountBase') or (paed.Id = idi.RefItemId and idi.RefTableName = 'PtAgrEBankingDetail')) and idi.HdVersionNo between 1 and 999999998
left outer join IfDeliverySetting ds on ds.Id = idi.DeliverySettingId and ds.HdVersionNo between 1 and 999999998
left outer join IfDeliveryHistory idh on idh.DeliveryItemId = idi.id and idh.HdVersionNo between 1 and 999999998
left outer join PtAccountBase ab on paed.AccountId = ab.Id and ab.HdVersionNo between 1 and 999999998
inner join IfCamtEntryDetailDelivery cedd on cedd.TransformId = idh.Id and cedd.HdVersionNo between 1 AND 999999998
JOIN PrReference as R ON ab.Id = R.AccountId and R.HdVersionNo between 1 and 999999998
JOIN PrPrivate as P ON R.ProductId = P.ProductId and P.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PrPrivateCharacteristic Prod_char ON P.ProductNo = Prod_char.ProductNo
     AND Prod_char.IsDefault = 1
LEFT OUTER JOIN AsText Prod_AsText ON Prod_char.Id = Prod_AsText.MasterId
     AND Prod_AsText.LanguageNo = @LanguageNo
LEFT OUTER JOIN PrPrivateCharacteristic Acc_char ON ab.CharacteristicNo = Acc_char.CharacteristicNo
LEFT OUTER JOIN AsText Acc_AsText ON Acc_char.Id = Acc_AsText.MasterId
     AND Acc_AsText.LanguageNo = @LanguageNo
where pae.id = @AgreementId
and paed.accountid = @AccountId
and ds.IsEbankingVisible = 1
AND idh.STATE = 128
AND ds.Name = 'camt-ebanking'
and pae.HdVersionNo between 1 and 99999998 
GROUP BY ab.Id, ab.AccountNo, ab.AccountNoEdited, R.Currency, ab.CustomerReference, Acc_AsText.TextShort, Prod_AsText.TextShort, idh.StartDateTime, idh.EndDateTime, idh.State, idh.Id


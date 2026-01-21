--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingCamt054EsrDataForAgreement context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingCamt054EsrDataForAgreement,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingCamt054EsrDataForAgreement
CREATE OR ALTER PROCEDURE dbo.GetPendingCamt054EsrDataForAgreement
@AgreementId UNIQUEIDENTIFIER,
@LanguageNo int     
AS
DECLARE @AccountIds Table(Id uniqueidentifier)

INSERT INTO @AccountIds
select aebd.AccountId 
FROM PtAgrEBanking aeb 
INNER JOIN PtAgrEBankingDetail aebd ON aebd.AgrEBankingId = aeb.Id AND aebd.HdVersionNo BETWEEN 1 AND 999999998
WHERE aeb.Id = @AgreementId 
AND aebd.HasAccess = 1
AND aebd.InternetbankingAllowed = 1
AND aebd.ValidFrom < GETDATE()
AND aebd.ValidTo > GETDATE()
AND aeb.HdVersionNo BETWEEN 1 AND 999999998

SELECT  
 ab.Id as AccountId,  
 ab.AccountNo,  
 ab.AccountNoEdited,  
 R.Currency,  
 IsNull(ab.CustomerReference, IsNull(Acc_AsText.TextShort, Prod_AsText.TextShort)) as TextShort,   
 COUNT(cedd.Id) as NumberOfEntries,   
 SUM(cedd.Amount) as Amount,   
 MIN(idh.StartDateTime) as DateFrom,   
 MAX(idh.EndDateTime) as DateTo,  
 1 as ProcessingStatus  
from ptagrebanking pae  
left outer join ptagrebankingdetail paed on paed.AgrEBankingId = pae.id and paed.HdVersionNo between 1 and 999999998  
left outer join IfDeliveryItem idi on ((paed.AccountId = idi.RefItemId and idi.RefTableName = 'PtAccountBase') or (paed.Id = idi.RefItemId and idi.RefTableName = 'PtAgrEBankingDetail')) and idi.HdVersionNo between 1 and 999999998  
left outer join IfDeliverySetting ds on ds.Id = idi.DeliverySettingId and ds.Name = 'camt-esr-ebanking' and ds.HdVersionNo between 1 and 999999998  
left outer join IfDeliveryHistory idh on idh.DeliveryItemId = idi.id and idh.HdVersionNo between 1 and 999999998  
left outer join PtAccountBase ab on paed.AccountId = ab.Id and ab.HdVersionNo between 1 and 999999998  
INNER JOIN IfCamtEntryDetailDelivery cedd ON cedd.TransformId = idh.Id AND cedd.HdVersionNo BETWEEN 1 AND 999999998  
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
and paed.accountid IN(SELECT Id FROM @AccountIds)
and ds.IsEbankingVisible = 1  
AND ds.Name = 'camt-esr-ebanking'  
and pae.HdVersionNo between 1 and 99999998  
and idh.State = 128  
GROUP BY ab.Id, ab.AccountNo, ab.AccountNoEdited, R.Currency, ab.CustomerReference, Acc_AsText.TextShort, Prod_AsText.TextShort  
UNION  
SELECT  
 B.Id as AccountId,  
 B.AccountNo,   
 B.AccountNoEdited,  
 R.Currency,  
 IsNull(B.CustomerReference, IsNull(Acc_AsText.TextShort, Prod_AsText.TextShort)) as TextShort,   
 Count(B.AccountNo) as NumberOfEntries,   
 Sum(D.Amount) Amount,   
 Min(D.TransDate) as DateFrom,   
 Max(D.TransDate) as DateTo,  
 1 as ProcessingStatus  
FROM PtTransEsrData as D  
INNER JOIN PtAccountBase as B on D.AccountId = B.Id   
JOIN PrReference as R ON B.Id = R.AccountId  
JOIN PrPrivate as P ON R.ProductId = P.ProductId  
LEFT OUTER JOIN PrPrivateCharacteristic Prod_char ON P.ProductNo = Prod_char.ProductNo  
     AND Prod_char.IsDefault = 1  
LEFT OUTER JOIN AsText Prod_AsText ON Prod_char.Id = Prod_AsText.MasterId  
     AND Prod_AsText.LanguageNo = @LanguageNo  
LEFT OUTER JOIN PrPrivateCharacteristic Acc_char ON B.CharacteristicNo = Acc_char.CharacteristicNo  
LEFT OUTER JOIN AsText Acc_AsText ON Acc_char.Id = Acc_AsText.MasterId  
     AND Acc_AsText.LanguageNo = @LanguageNo  
WHERE D.AccountId IN(SELECT Id FROM @AccountIds)  
AND NOT EXISTS (SELECT * FROM PtTransEsrFetched WHERE TransEsrDataId = D.Id)  
                AND d.TransDate > DATEADD(year, -1, GETDATE())  
AND d.TransDate < (SELECT ISNULL(MIN(StartDateTime), '2199-12-31')  
 FROM IfDeliveryHistory idh  
 INNER JOIN IfDeliveryItem di ON di.Id = idh.DeliveryItemId  
 INNER JOIN IfDeliverySetting ds ON ds.Id = di.DeliverySettingId  
 WHERE di.RefItemId IN(SELECT Id FROM @AccountIds)  
                AND idh.HdVersionNo BETWEEN 1 AND 999999998  
 AND ds.Name = 'camt-esr-ebanking')  
GROUP BY B.Id, B.AccountNo, B.AccountNoEdited, B.CustomerReference, R.Currency, Acc_AsText.TextShort, Prod_AsText.TextShort  
OPTION (maxdop 1) -- is used to handle this Errormessage: Intra-query parallelism caused your server command (process ID #51) to deadlock. Rerun the query without intra-query parallelism by using the query hint option (maxdop 1).

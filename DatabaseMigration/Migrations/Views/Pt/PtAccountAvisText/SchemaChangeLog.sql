--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAvisText context:any labels:c-any,o-view,ot-schema,on-PtAccountAvisText,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAvisText
CREATE OR ALTER VIEW dbo.PtAccountAvisText AS
SELECT acc.Id As AccountId, acc.AccountNo As AccountNo, 
   prod_text.LanguageNo As LanguageNo,
   IsNull(acc_text.TextShort, prod_text.TextShort) As TextShort
FROM PtAccountBase acc
   JOIN PrReference ref ON acc.Id = ref.AccountId
   JOIN PrPrivate pri ON ref.ProductId = pri.ProductId
   LEFT OUTER JOIN PrPrivateCharacteristic prod_char ON pri.ProductNo = prod_char.ProductNo 
      AND prod_char.IsDefault=1
   LEFT OUTER JOIN AsText prod_text ON prod_char.Id = prod_text.MasterId 
   LEFT OUTER JOIN PrPrivateCharacteristic acc_char ON acc.CharacteristicNo = acc_char.CharacteristicNo
   LEFT OUTER JOIN AsText acc_text ON acc_char.Id = acc_text.MasterId 
      AND acc_text.LanguageNo = prod_text.LanguageNo


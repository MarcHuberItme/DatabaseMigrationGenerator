--liquibase formatted sql

--changeset system:create-alter-procedure-GetHistoryOfAssignedComponents context:any labels:c-any,o-stored-procedure,ot-schema,on-GetHistoryOfAssignedComponents,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetHistoryOfAssignedComponents
CREATE OR ALTER PROCEDURE dbo.GetHistoryOfAssignedComponents
@AccountId uniqueidentifier,
@LanguageNo tinyint

As

Select AC.Id As AccountComponentId, AC.PrivateCompCharacteristicNo, T.*, A.collclean, Pri.Possiblecredit,
X.TextShort As CompTypeNoTx, LX.TextShort As SecurityLevelNoTx, Ref.Currency
From PtAccountComponent AC Join PrPrivateCompType T On AC.PrivateCompTypeId = T.Id
Join PtAccountBase A On AC.AccountBaseId = A.Id
Join PrReference Ref On Ref.AccountId = A.Id
Join PrPrivate Pri On Pri.ProductId = Ref.ProductId
Left Outer Join AsText X On T.Id = X.MasterId And X.LanguageNo = @LanguageNo
Left Outer Join PrPrivateSecurityLevel L On L.SecurityLevelNo = T.SecurityLevelNo
Left Outer Join AsText LX On L.Id = LX.MasterId And LX.LanguageNo = @LanguageNo
Where AC.HdVersionNo > 0 And AC.HdVersionNo < 999999999 And AccountBaseId = @AccountId


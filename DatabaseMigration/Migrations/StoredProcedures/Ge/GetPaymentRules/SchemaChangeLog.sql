--liquibase formatted sql

--changeset system:create-alter-procedure-GetPaymentRules context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPaymentRules,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPaymentRules
CREATE OR ALTER PROCEDURE dbo.GetPaymentRules
@AccountBaseId as uniqueidentifier,
@LanguageNo as TinyInt

AS

Select AB1.AccountnoEdited AS AccountNo, ''as PortfolioNo, TXT1.TextShort AS ProductId, TXT.TextShort AS PaymentType 
from PtAccountPaymentRule APR 
Inner Join      PtAccountBase AB on APR.PayeeAccountID = AB.id 
Inner Join      PtAccountBase AB1 on APR.AccountBaseID = AB1.id 
Inner Join      PrReference REF ON AB1.Id = REF.AccountId 
Inner Join      PrPrivate PRI ON REF.ProductId = PRI.ProductId 
Left Outer Join AsText TXT1 on PRI.ID = TXT1.MasterID AND TXT1.LanguageNo = @LanguageNo 
Inner Join      AsPaymentType PT on APR.PaymentTypeNo = PT.PaymentTypeNo 
Left Outer Join AsText TXT on PT.Id = TXT.MasterId AND TXT.LanguageNo = @LanguageNo 
Where AB.Id = @AccountBaseId
AND APR.HdVersionNo Between 1 AND 999999998 
Union 
Select '' AS AccountNo, PO.PortfolioNoEdited as PortfolioNo, TXT1.TextShort as ProductId, TXT.TextShort AS PaymentType 
from            PtPortfolioPaymentRule PPR 
Inner join      PtAccountBase AB on PPR.PayeeAccountID = AB.id 
Inner join      PtPortfolio PO on PPR.PortfolioId = PO.Id 
Inner join      AsPaymentType PT on PPR.PaymentTypeNo = PT.PaymentTypeNo 
Left Outer Join AsText TXT on PT.Id = TXT.MasterId AND TXT.LanguageNo = @LanguageNo  
Inner Join      PtPortfolioType PTN on PTN.PortfolioTypeNo = PO.PortfolioTypeNo 
Left Outer Join AsText TXT1 on PTN.Id = TXT1.MasterId AND TXT1.LanguageNo = @LanguageNo  
Where AB.Id = @AccountBaseId 
AND PPR.HdVersionNo Between 1 AND 999999998 
Union
Select '' AS AccountNo, '' as PortfolioNo, TXT1.TextShort as ProductId, TXT.TextShort AS PaymentType
from            PtAgrRetainedMail RM
Inner Join      MdTable M on 'PtAgrRetainedMail' = M.TableName
Left Outer Join AsText TXT1 on M.Id = TXT1.MasterId and TXT1.LanguageNo = @LanguageNo  
Inner Join      AsPaymentType PT on 0 = PT.PaymentTypeNo 
Left Outer Join AsText TXT on PT.Id = TXT.MasterId AND TXT.LanguageNo = @LanguageNo  
Where RM.DebitAccountId = @AccountBaseId 
AND   RM.ExpirationDate Is Null
AND   RM.HdVersionNo Between 1 AND 999999998 
Union
Select '' AS AccountNo, '' as PortfolioNo, TXT1.TextShort + ': ' + convert(nvarchar,DV.BoxNo) + ' (' + DV.TypeText + ')' as ProductId, TXT.TextShort AS PaymentType
from	     PtAgrSafeDepositBox DB
Inner Join      PrSafeDepositView DV on DB.SafeDepositBoxId = DV.Id
Inner Join      MdTable M on 'PtAgrSafeDepositBox' = M.TableName
Left Outer Join AsText TXT1 on M.Id = TXT1.MasterId and TXT1.LanguageNo = @LanguageNo  
Inner Join      AsPaymentType PT on 0 = PT.PaymentTypeNo 
Left Outer Join AsText TXT on PT.Id = TXT.MasterId AND TXT.LanguageNo = @LanguageNo  
Where DB.DebitAccountId = @AccountBaseId 
AND   DB.ExpirationDate Is Null
AND   DB.HdVersionNo Between 1 AND 999999998 
Union
Select '' AS AccountNo, '' as PortfolioNo, TXT1.TextShort as ProductId, TXT.TextShort AS PaymentType
from	        PtAgrNightCashBox CB
Inner Join      MdTable M on 'PtAgrNightCashBox' = M.TableName
Left Outer Join AsText TXT1 on M.Id = TXT1.MasterId and TXT1.LanguageNo = @LanguageNo  
Inner Join      AsPaymentType PT on 0 = PT.PaymentTypeNo 
Left Outer Join AsText TXT on PT.Id = TXT.MasterId AND TXT.LanguageNo = @LanguageNo  
Where CB.DebitAccountId = @AccountBaseId 
AND   CB.ExpirationDate Is Null
AND   CB.HdVersionNo Between 1 AND 999999998 


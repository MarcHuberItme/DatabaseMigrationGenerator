--liquibase formatted sql

--changeset system:create-alter-procedure-GetStandingOrders context:any labels:c-any,o-stored-procedure,ot-schema,on-GetStandingOrders,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetStandingOrders
CREATE OR ALTER PROCEDURE dbo.GetStandingOrders

@AccountBaseId as uniqueidentifier,
@LanguageNo as TinyInt 

AS

Select AB.AccountnoEdited AS AccountNo, TXT.TextShort AS PeriodRuleNo, convert(char,SO.NextSelectionDate,104) AS NextSelectionDate, SO.PaymentAmount AS PaymentAmount, SO.PaymentCurrency AS PaymentCurrency, SO.PaymentInformation AS PaymentInformation 
from            PtStandingOrder SO 
Inner Join      PtAccountBase AB ON SO.AccountID = AB.Id 
Inner Join      PrReference REF ON SO.CreditReferenceID = REF.id 
Inner Join      PtAccountBase AB1 ON REF.AccountId = AB1.Id 
Inner Join      asPeriodRule PR on SO.PeriodRuleNo = PR.PeriodRuleNo 
Left outer Join asText TXT on PR.ID = TXT.MasterId AND TXT.LanguageNo = @LanguageNo 
Where AB1.Id = @AccountBaseId
AND SO.HdVersionNo BETWEEN 1 AND 999999998

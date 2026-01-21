--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountPayInPayOutInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountPayInPayOutInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountPayInPayOutInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountPayInPayOutInfo
@PrReferenceId as uniqueidentifier,

@blnIsPayOutAllowed as bit OUTPUT,
@blnIsPayOutBooklet as bit OUTPUT,
@blnIsPayInAllowed as bit OUTPUT,
@blnIsPayInBooklet as bit OUTPUT,
@blnIsPayOutNeedsBooklet as bit OUTPUT,
@blnIsPayInNeedsBooklet as bit OUTPUT


AS

SELECT
 @blnIsPayOutAllowed = ISNULL(PrPrivatePayRule.AllowsCashPayment,0),
 @blnIsPayOutBooklet = ISNULL(PrPrivatePayRule.IsBooklet,0),
 @blnIsPayOutNeedsBooklet= ISNULL(PrPrivatePayRule.NeedsBooklet,0)
FROM 
 PrPrivate RIGHT OUTER JOIN
 PrBase ON PrPrivate.ProductId = PrBase.Id RIGHT OUTER JOIN
 PrReference ON PrBase.Id = PrReference.ProductId LEFT OUTER JOIN
 PrPrivatePayRule ON PrPrivate.PayOutRuleNo = PrPrivatePayRule.PayRuleNo
Where PrReference.Id = @PrReferenceId


SELECT
 @blnIsPayInAllowed = ISNULL(PrPrivatePayRule.AllowsCashPayment,0),
 @blnIsPayInBooklet = ISNULL(PrPrivatePayRule.IsBooklet,0),
 @blnIsPayInNeedsBooklet = ISNULL(PrPrivatePayRule.NeedsBooklet,0)
FROM PrPrivate RIGHT OUTER JOIN
 PrBase ON PrPrivate.ProductId = PrBase.Id RIGHT OUTER JOIN
 PrReference ON PrBase.Id = PrReference.ProductId LEFT OUTER JOIN
 PrPrivatePayRule ON PrPrivate.PayInRuleNo = PrPrivatePayRule.PayRuleNo
Where
 PrReference.Id = @PrReferenceId


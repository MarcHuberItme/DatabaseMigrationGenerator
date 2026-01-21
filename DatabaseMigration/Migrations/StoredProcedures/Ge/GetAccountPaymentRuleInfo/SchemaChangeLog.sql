--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountPaymentRuleInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountPaymentRuleInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountPaymentRuleInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountPaymentRuleInfo
@PositionId uniqueidentifier    

AS

SELECT TOP 1 Pos.ProdReferenceId, Ref.AccountId AS PayeeAccountId, Ref.Id AS PayeePrReferenceId, 
Rul.PaymentTypeNo, Rul.OverdrawAllowed
FROM PtPosition AS Pos 
INNER JOIN PrReference AS PosRef ON Pos.ProdReferenceId = PosRef.Id
INNER JOIN PtAccountPaymentRule AS Rul ON PosRef.AccountId = Rul.AccountBaseId
INNER JOIN PtAccountBase AS Acc ON Acc.Id = Rul.PayeeAccountId
INNER JOIN PrReference AS Ref ON Ref.AccountId = Acc.Id
WHERE Pos.Id = @PositionId 
AND Acc.TerminationDate IS NULL
AND Rul.PaymentTypeNo IN(3,1,0)
AND Rul.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY PaymentTypeNo DESC

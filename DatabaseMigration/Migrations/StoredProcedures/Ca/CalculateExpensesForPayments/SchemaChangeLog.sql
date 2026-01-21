--liquibase formatted sql

--changeset system:create-alter-procedure-CalculateExpensesForPayments context:any labels:c-any,o-stored-procedure,ot-schema,on-CalculateExpensesForPayments,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CalculateExpensesForPayments
CREATE OR ALTER PROCEDURE dbo.CalculateExpensesForPayments
@PositionId uniqueidentifier,    
@ValueDateBegin datetime,    
@ValueDateEnd datetime   
As
Select Sum(Case When M.PaymentAmount>0 Then 1 When M.PaymentAmount<0 Then -1 Else 0 End) As NumPayments
From (
  Select Distinct M.Id
  From PtTransItem I Join PtPosition Pos On I.PositionId=Pos.Id
  Join PtTransMessage M On I.MessageId=M.Id And M.DebitPrReferenceId=Pos.ProdReferenceId 
  Join PtPortfolio DO On M.DebitPortfolioId=DO.Id
  Join PtPortfolio CO On M.CreditPortfolioId=CO.Id
  Where I.PositionId=@PositionId
    And I.ValueDate>@ValueDateBegin And I.ValueDate<=@ValueDateEnd
    And DO.PartnerId<>CO.PartnerId
    And I.DetailCounter<2
    And I.HdVersionNo between 1 and 999999998

  UNION
  Select Distinct M.Id
  From PtTransItem I Join PtPosition Pos On I.PositionId=Pos.Id
  Join PtTransItemDetail D On D.TransItemId=I.Id
  Join PtTransMessage M On D.MessageId=M.Id And M.DebitPrReferenceId=Pos.ProdReferenceId 
  Join PtPortfolio DO On M.DebitPortfolioId=DO.Id
  Join PtPortfolio CO On M.CreditPortfolioId =CO.Id
  Where I.PositionId=@PositionId
    And I.ValueDate>@ValueDateBegin And I.ValueDate<=@ValueDateEnd
    And DO.PartnerId<>CO.PartnerId
    And I.DetailCounter>1 
    And I.HdVersionNo between 1 and 999999998

) A Join PtTransMessage M On A.Id=M.Id And M.HdVersionNo<999999999
Join PtTransaction T On M.TransactionId=T.Id And T.HdVersionNo<999999999
Join PtTransType TT On T.TransTypeNo=TT.TransTypeNo And TT.AsChargeablePayment=1

--liquibase formatted sql

--changeset system:create-alter-procedure-GetReportAccountBalanceByDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetReportAccountBalanceByDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetReportAccountBalanceByDate
CREATE OR ALTER PROCEDURE dbo.GetReportAccountBalanceByDate
@PtPositionId UniqueIdentifier,
@ByDate datetime

AS

SELECT TI.IsDueRelevant, PO.ValueProductCurrency, 
               Sum(TI.DebitAmount) AS SumDebitAmount, SUM(TI.CreditAmount) AS SumCreditAmount,
               PO.ValueProductCurrency - SUM(TI.CreditAmount) + SUM(TI.DebitAmount) AS BalanceByDate,
               DueBalanceByDate = Case When TI.IsDueRelevant = 1 Then
                                                           PO.DueValueProductCurrency - SUM(TI.CreditAmount) + SUM(TI.DebitAmount) 
                                                  End
FROM   PtPosition PO JOIN PtTransItem TI 
             ON PO.Id = TI.PositionId  AND TI.DetailCounter > 0 AND TI.HdVersionNo between 1 and 999999998
 
WHERE  PO.Id = @PtPositionId
AND       (TI.TransDate > @ByDate  AND TI.RealDate > @ByDate)
GROUP BY TI.IsDueRelevant,PO.ValueProductCurrency,PO.DueValueProductCurrency

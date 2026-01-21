--liquibase formatted sql

--changeset system:create-alter-view-RePfBCheckOverview context:any labels:c-any,o-view,ot-schema,on-RePfBCheckOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePfBCheckOverview
CREATE OR ALTER VIEW dbo.RePfBCheckOverview AS
SELECT     
RePfBRelBC.GroupNo, RePfBRelBC.BCNo, (SUM(ISNULL(RePfBLoanBC.TotalAllocation, 0))) AS AllocationSum, 
                      SUM(ISNULL(RePledgeRegister.ValueAmountAdjusted, RePledgeRegister.ValueAmount)) AS ValueAmountSum, AsText.TextLong AS Bank, 
                      (SUM(ISNULL(RePledgeRegister.ValueAmountAdjusted, RePledgeRegister.ValueAmount))) / (SUM(ISNULL(RePfBLoanBC.TotalAllocation, 0))/Count(*))
                      * 100 AS Result
FROM         RePfBLoan INNER JOIN
                      RePfBLoanBC ON RePfBLoan.Id = RePfBLoanBC.LoanId INNER JOIN
                      RePfBRelBC ON RePfBLoanBC.BcId = RePfBRelBC.Id INNER JOIN
                      RePledgeRegister ON RePfBRelBC.PfBNo = RePledgeRegister.PfBNo INNER JOIN
                      AsText ON RePfBRelBC.Id = AsText.MasterId
WHERE     (AsText.LanguageNo = 2) AND (RePfBLoanBC.HdVersionNo BETWEEN 1 AND 999999998) AND (RePledgeRegister.HdVersionNo BETWEEN 1 AND 999999998)
GROUP BY RePfBRelBC.GroupNo, RePfBRelBC.BCNo, AsText.TextLong


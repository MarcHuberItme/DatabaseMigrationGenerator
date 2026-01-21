--liquibase formatted sql

--changeset system:create-alter-view-RePfBLoanView context:any labels:c-any,o-view,ot-schema,on-RePfBLoanView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePfBLoanView
CREATE OR ALTER VIEW dbo.RePfBLoanView AS
SELECT TOP 100 PERCENT
               RePfBRelLoan.Id,
               RePfBRelLoan.HdCreateDate,
               RePfBRelLoan.HdCreator,
               RePfBRelLoan.HdChangeDate,
               RePfBRelLoan.HdChangeUser,
               RePfBRelLoan.HdEditStamp,
               RePfBRelLoan.HdVersionNo,
               RePfBRelLoan.HdProcessId,
               RePfBRelLoan.HdStatusFlag,
               RePfBRelLoan.HdNoUpdateFlag,
               RePfBRelLoan.HdPendingChanges,
               RePfBRelLoan.HdPendingSubChanges,
               RePfBRelLoan.HdTriggerControl,
               RePfBRelLoan.Allocation, 
               RePfBLoan.SerieDesc,
               RePfBLoan.SerNo,
               RePfBLoan.Tranche,
               RePfBLoan.InterestRate,
               RePfBLoan.PaymentDate, 
               RePfBLoan.ValidFrom, 
               RePfBLoan.ValidTo,
               AsText.TextLong,
               RePfBRelBC.PfBNo,
               RePfBRelBC.BCNo,
               RePfBRelBC.GroupNo,
               RePfBRelBC.ModAllocation,
               RePfBRelBC.IsDirectMember,
               RePfBRelBC.IsBranch
FROM     AsText INNER JOIN
               RePfBRelBC INNER JOIN
               RePfBRelLoan INNER JOIN
               RePfBLoan ON RePfBRelLoan.LoanId = RePfBLoan.Id ON
               RePfBRelBC.Id = RePfBRelLoan.BcId ON AsText.MasterId = RePfBRelBC.Id
WHERE     (AsText.LanguageNo = 2)

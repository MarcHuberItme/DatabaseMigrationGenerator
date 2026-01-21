--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemBookingsView context:any labels:c-any,o-view,ot-schema,on-PtTransItemBookingsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemBookingsView
CREATE OR ALTER VIEW dbo.PtTransItemBookingsView AS
SELECT TI.Id, TI.HdVersionNo, TI.TransDate, TI.TransDateTime, DATEPART(ms, TI.TransDateTime) AS Ms, TI.ValueDate, 
   TI.DebitAmount, TI.CreditAmount, TI.TextNo, TI.TransText, TI.DetailCounter, TI.IsDueRelevant, TI.IsInactive, 
   TI.PositionId, IsNull(TMS.SalaryFlag, 0) As SalaryFlag 
FROM PtTransItem AS TI
LEFT OUTER JOIN PtTransMessage TMS ON TMS.Id = TI.MessageId
WHERE TI.HdVersionNo between 1 and 999999998

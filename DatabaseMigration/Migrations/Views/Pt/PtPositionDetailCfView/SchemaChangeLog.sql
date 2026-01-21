--liquibase formatted sql

--changeset system:create-alter-view-PtPositionDetailCfView context:any labels:c-any,o-view,ot-schema,on-PtPositionDetailCfView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionDetailCfView
CREATE OR ALTER VIEW dbo.PtPositionDetailCfView AS
SELECT     
dbo.PtPositionDetailCf.Id, 
dbo.PtPositionDetailCf.HdPendingChanges,
dbo.PtPositionDetailCf.HdPendingSubChanges,
dbo.PtPositionDetailCf.HdVersionNo,
dbo.PtPositionDetailCf.HdProcessId,
dbo.PtPositionDetailCf.HdCreateDate,
dbo.PtPositionDetailCf.HdEditStamp,
dbo.PtPositionDetailCf.PaymentDate, 
dbo.PtPositionDetailCf.PositionDetailId, 
dbo.PtPositionDetailCf.PublicCfId, 
dbo.PrPublicCf.PublicId, 
dbo.PrPublicCf.Amount,
dbo.PrPublicCf.Currency,
dbo.PrPublicCf.DueDate,
dbo.PrPublicCf.CashFlowFuncNo,
dbo.PrPublicCf.PaymentFuncNo,
dbo.PrPublicCf.PaymentTypeNo
FROM         dbo.PtPositionDetailCf INNER JOIN
                      dbo.PrPublicCf ON dbo.PtPositionDetailCf.PublicCfId = dbo.PrPublicCf.Id

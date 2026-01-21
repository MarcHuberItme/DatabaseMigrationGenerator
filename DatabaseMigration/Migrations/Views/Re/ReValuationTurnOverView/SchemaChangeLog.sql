--liquibase formatted sql

--changeset system:create-alter-view-ReValuationTurnOverView context:any labels:c-any,o-view,ot-schema,on-ReValuationTurnOverView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReValuationTurnOverView
CREATE OR ALTER VIEW dbo.ReValuationTurnOverView AS
SELECT 
   RVT.Id,
   RVT.HdCreateDate,
   RVT.HdCreator,
   RVT.HdChangeDate,
   RVT.HdChangeUser,
   RVT.HdEditStamp,
   RVT.HdVersionNo,
   RVT.HdProcessId,
   RVT.HdStatusFlag,
   RVT.HdNoUpdateFlag,
   RVT.HdPendingChanges,
   RVT.HdPendingSubChanges,
   RVT.HdTriggerControl,
   RVT.ValuationId,
   RVT.BusinessTypeNo,
   RVT.TurnOver,
   RVT.TurnOverRentRate,
   RVT.Designation,
   round((RVT.TurnOver * RVT.TurnOverRentRate / 100),0) as TurnOverRentAmount
FROM ReValuationTurnOver RVT


--liquibase formatted sql

--changeset system:create-alter-view-PrPublicRelationView context:any labels:c-any,o-view,ot-schema,on-PrPublicRelationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicRelationView
CREATE OR ALTER VIEW dbo.PrPublicRelationView AS
SELECT TOP 100 PERCENT
   Id,
   HdCreateDate,
   HdCreator,
   HdChangeDate,
   HdChangeUser,
   HdEditStamp,
   HdVersionNo,
   HdProcessId,
   HdStatusFlag,
   HdNoUpdateFlag,
   HdPendingChanges,
   HdPendingSubChanges,
   HdTriggerControl,
   VdfDocType,
   VdfDocGen,
   VdfDocStatusNo,
   SourcePublicId,
   TargetPublicId,
   NumberSource,
   NumberTarget,
   DependencyTypeNo,
   AssimilationDate,
   IsAssimilDateAssumed,
   SeparationFromDate,
   SeparationToDate,
   UnderlyingRoleNo,
   IsPrincipal,
   IsIncome,
   IsPaymentLeg,
   UnderlyingCoverRatio,
   CurrentWeight,
   CurrentAmount,
   CurrentAmountUnitNo,
   DeltaAtIssuance,
   InstrInInitialHedge,
   EffDateDeltaHedge   
  
FROM PrPublicRelation 



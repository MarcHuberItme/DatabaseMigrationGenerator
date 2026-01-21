--liquibase formatted sql

--changeset system:create-alter-view-PtBlockingView context:any labels:c-any,o-view,ot-schema,on-PtBlockingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtBlockingView
CREATE OR ALTER VIEW dbo.PtBlockingView AS
SELECT
    PrPublicBlocking.Id,  
    PrPublicBlocking.HdCreateDate,
    PrPublicBlocking.HdCreator,
    PrPublicBlocking.HdChangeDate,
    PrPublicBlocking.HdChangeUser,
    PrPublicBlocking.HdEditStamp,
    PrPublicBlocking.HdVersionNo,
    PrPublicBlocking.HdProcessId,
    PrPublicBlocking.HdStatusFlag,
    PrPublicBlocking.HdNoUpdateFlag, 
    PrPublicBlocking.HdPendingChanges,
    PrPublicBlocking.HdPendingSubChanges,
    PrPublicBlocking.HdTriggerControl, 
    'PrPublicBlocking' as TableName,
    ParentTableName, 
    ParentId,
    PublicId as PartnerId, 
    BlockDate,
    BlockIssuer, 
    BlockReason, 
    BlockComment, 
    ReleaseDate,   
    ReleaseIssuer, 
    ReleaseReason,
    ReleaseComment,
    IsPermanent,
    PtBlockReason.IsWarning,
    ReleaseDateEstimated, 
    Null as BlockedQuantity, 
    ReleaseComment as OverrideComment,
    PrPublicBlocking.Id as OverrideUserId
FROM
PrPublicBlocking
JOIN PtBlockReason on PtBlockReason.Id = PrPublicBlocking.BlockReason
and PtBlockReason.HdVersionNo between 1 and 999999998
union
SELECT
    PtBlocking.Id,  
    PtBlocking.HdCreateDate,
    PtBlocking.HdCreator,
    PtBlocking.HdChangeDate,
    PtBlocking.HdChangeUser,
    PtBlocking.HdEditStamp,
    PtBlocking.HdVersionNo,
    PtBlocking.HdProcessId,
    PtBlocking.HdStatusFlag,
    PtBlocking.HdNoUpdateFlag, 
    PtBlocking.HdPendingChanges,
    PtBlocking.HdPendingSubChanges,
    PtBlocking.HdTriggerControl, 
    'PtBlocking' as TableName,
    ParentTableName, 
    ParentId,
    PartnerId, 
    BlockDate,
    BlockIssuer, 
    BlockReason, 
    BlockComment, 
    ReleaseDate,   
    ReleaseIssuer, 
    ReleaseReason,
    ReleaseComment,
    IsPermanent,
    PtBlockReason.IsWarning,
    ReleaseDateEstimated, 
    BlockedQuantity,
    ReleaseComment as OverrideComment,
    PtBlocking.Id as OverrideUserId
FROM 
PtBlocking
JOIN PtBlockReason on PtBlockReason.Id = PtBlocking.BlockReason
and PtBlockReason.HdVersionNo between 1 and 999999998



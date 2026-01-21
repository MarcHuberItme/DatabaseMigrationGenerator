--liquibase formatted sql

--changeset system:generated-update-data-MdCacheLevel context:any labels:c-any,o-table,ot-data,on-MdCacheLevel,fin-13659 runOnChange:true
--comment: Update data for table MdCacheLevel
DELETE FROM MdCacheLevel;

INSERT INTO MdCacheLevel (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, CacheLevel, Description
) VALUES (
  '4a4c27e2-1e32-8e31-a482-26145f4c10e1', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '4a4c27e2-1e32-8e31-a482-26145f4c10e1', 1, NULL, NULL, NULL, 0, 0, NULL, 1, N'No caching'
);

INSERT INTO MdCacheLevel (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, CacheLevel, Description
) VALUES (
  'ac85b5ac-009d-c235-b278-066df30b646e', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, 'ac85b5ac-009d-c235-b278-066df30b646e', 1, NULL, NULL, NULL, 0, 0, NULL, 2, N'One day'
);

INSERT INTO MdCacheLevel (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, CacheLevel, Description
) VALUES (
  '9a0ed8e3-21fb-923a-8e3a-dbc4b90769fa', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '9a0ed8e3-21fb-923a-8e3a-dbc4b90769fa', 1, NULL, NULL, NULL, 0, 0, NULL, 3, N'Til midnight'
);

INSERT INTO MdCacheLevel (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, CacheLevel, Description
) VALUES (
  'd797084c-e48e-683f-a968-e89b01cc56d0', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, 'd797084c-e48e-683f-a968-e89b01cc56d0', 1, NULL, NULL, NULL, 0, 0, NULL, 4, N'One hour'
);


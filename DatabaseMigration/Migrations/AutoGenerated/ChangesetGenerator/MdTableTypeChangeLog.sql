--liquibase formatted sql

--changeset system:generated-update-data-MdTableType context:any labels:c-any,o-table,ot-data,on-MdTableType,fin-13659 runOnChange:true
--comment: Update data for table MdTableType
DELETE FROM MdTableType;

INSERT INTO MdTableType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TableType, Description
) VALUES (
  'f6fb003c-a544-613f-b529-2e34279eb7a6', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, 'f6fb003c-a544-613f-b529-2e34279eb7a6', 1, NULL, NULL, NULL, 0, 0, NULL, 1, N'Editable w. generic editor'
);

INSERT INTO MdTableType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TableType, Description
) VALUES (
  '04b338e5-32be-2a38-968c-86858ece70c7', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '04b338e5-32be-2a38-968c-86858ece70c7', 1, NULL, NULL, NULL, 0, 0, NULL, 2, N'Editable'
);

INSERT INTO MdTableType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TableType, Description
) VALUES (
  '6d8402e1-a8cd-5732-8f7a-6fc3054bade1', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '6d8402e1-a8cd-5732-8f7a-6fc3054bade1', 1, NULL, NULL, NULL, 0, 0, NULL, 3, N'No editor'
);

INSERT INTO MdTableType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TableType, Description
) VALUES (
  '1ae1bc83-be2f-e833-b5e2-3497430d784c', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '1ae1bc83-be2f-e833-b5e2-3497430d784c', 1, NULL, NULL, NULL, 0, 0, NULL, 4, N'Header Table'
);

INSERT INTO MdTableType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TableType, Description
) VALUES (
  '3d608ab0-3140-8636-a08f-f9552d6ba0d8', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '3d608ab0-3140-8636-a08f-f9552d6ba0d8', 1, NULL, NULL, NULL, 0, 0, NULL, 5, N'View FrontEnd'
);

INSERT INTO MdTableType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, TableType, Description
) VALUES (
  '83234c01-5958-b931-9b1b-f10e5852360d', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '83234c01-5958-b931-9b1b-f10e5852360d', 1, NULL, NULL, NULL, 0, 0, NULL, 6, N'Message Store Table'
);


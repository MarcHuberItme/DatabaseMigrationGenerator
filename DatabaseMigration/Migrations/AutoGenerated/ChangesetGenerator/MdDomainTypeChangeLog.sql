--liquibase formatted sql

--changeset system:generated-update-data-MdDomainType context:any labels:c-any,o-table,ot-data,on-MdDomainType,fin-13659 runOnChange:true
--comment: Update data for table MdDomainType
DELETE FROM MdDomainType;

INSERT INTO MdDomainType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DomainType, Description
) VALUES (
  '5f511c0e-dc4c-dd33-b74b-ad64d714050b', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '5f511c0e-dc4c-dd33-b74b-ad64d714050b', 1, NULL, NULL, NULL, 0, 0, NULL, 10, N'NOT a Code Table'
);

INSERT INTO MdDomainType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DomainType, Description
) VALUES (
  'df5f494d-69f3-033e-bf10-f5bdd6ca0bf6', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, 'df5f494d-69f3-033e-bf10-f5bdd6ca0bf6', 1, NULL, NULL, NULL, 0, 0, NULL, 20, N'Bank Specific Codes'
);

INSERT INTO MdDomainType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DomainType, Description
) VALUES (
  'ec5110cf-dec1-0735-b8a4-238b3803d0e3', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, 'ec5110cf-dec1-0735-b8a4-238b3803d0e3', 1, NULL, NULL, NULL, 0, 0, NULL, 30, N'General Codes'
);

INSERT INTO MdDomainType (
  Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
  HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DomainType, Description
) VALUES (
  '92318fee-3bae-a63d-8e26-ebf8374056f8', '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, '92318fee-3bae-a63d-8e26-ebf8374056f8', 1, NULL, NULL, NULL, 0, 0, NULL, 40, N'Static Application Codes'
);


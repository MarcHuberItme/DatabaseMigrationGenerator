--liquibase formatted sql

--changeset system:generated-update-data-MdVisumLevel context:any labels:c-any,o-table,ot-data,on-MdVisumLevel,fin-13659 runOnChange:true
--comment: Update data for table MdVisumLevel
WITH src AS (
    SELECT *
    FROM (VALUES
        ('50448aa9-fdd7-de34-8cf3-eae77c3cdd2d', 1, N'No confirmation'),
        ('538865d9-9dd8-7336-9112-2b2bedd8b7ec', 2, N'Process group'),
        ('292f3392-d737-2f3b-8def-2ca2d270be3f', 4, N'Single row'),
        ('f5ef87ed-bebe-5934-896b-860baa1687ce', 8, N'None, group activation')
    ) v(Id, VisumLevel, Description)
)
MERGE INTO MdVisumLevel AS t
USING src AS s
ON t.VisumLevel = s.VisumLevel
WHEN MATCHED THEN
    UPDATE SET
        t.Description   = s.Description,
        t.HdChangeDate  = '2026-01-12 00:00:00.000',
        t.HdChangeUser  = NULL,
        t.HdEditStamp   = s.Id,
        t.HdVersionNo   = 1,
        t.HdPendingChanges    = 0,
        t.HdPendingSubChanges = 0
WHEN NOT MATCHED BY TARGET THEN
    INSERT (
        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo,
        HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl,
        VisumLevel, Description
    )
    VALUES (
        s.Id, '2026-01-12 00:00:00.000', NULL, '2026-01-12 00:00:00.000', NULL, s.Id, 1,
        NULL, NULL, NULL, 0, 0, NULL,
        s.VisumLevel, s.Description
    )
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
;

--liquibase formatted sql

--changeset system:create-alter-view-AsDocumentData-any context:any labels:c-any,o-view,ot-schema,on-AsDocumentData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentData for all banks and environments
CREATE OR ALTER VIEW dbo.AsDocumentData AS
SELECT        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, 
                      DocumentId, Format, RecordDate, Location, StatusNo, Comments, Datastring, Replaceable, ExpirationStart, Sign, PublicKeyId, SignStatusNo
FROM            AsDocumentData_O
-- FROM         FsXxxArch.dbo.AsDocumentData_All

--changeset system:create-alter-view-AsDocumentData-hbl context:prd labels:c-hbl,o-view,ot-schema,on-AsDocumentData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentData for hbl and environment(s) prd
CREATE OR ALTER VIEW dbo.AsDocumentData AS
SELECT        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DocumentId, Format, RecordDate, Location, StatusNo, Comments, Datastring, Replaceable, ExpirationStart, Sign, PublicKeyId, SignStatusNo
FROM            FsHblArch.dbo.AsDocumentData_All

--changeset system:create-alter-view-AsDocumentData-bsz context:prd labels:c-bsz,o-view,ot-schema,on-AsDocumentData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentData for bsz and environment(s) prd
CREATE OR ALTER VIEW dbo.AsDocumentData AS
SELECT        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DocumentId, Format, RecordDate, Location, StatusNo, Comments, Datastring, Replaceable, ExpirationStart, Sign, PublicKeyId, SignStatusNo
FROM            FsBszArch.dbo.AsDocumentData_All

--changeset system:create-alter-view-AsDocumentData-cer context:prd labels:c-cer,o-view,ot-schema,on-AsDocumentData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentData for cer and environment(s) prd
CREATE OR ALTER VIEW dbo.AsDocumentData AS
SELECT        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DocumentId, Format, RecordDate, Location, StatusNo, Comments, Datastring, Replaceable, ExpirationStart, Sign, PublicKeyId, SignStatusNo
FROM            FsCerArch.dbo.AsDocumentData_All

--changeset system:create-alter-view-AsDocumentData-fgb context:prd labels:c-fgb,o-view,ot-schema,on-AsDocumentData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentData for fgb and environment(s) prd
CREATE OR ALTER VIEW dbo.AsDocumentData AS
SELECT        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DocumentId, Format, RecordDate, Location, StatusNo, Comments, Datastring, Replaceable, ExpirationStart, Sign, PublicKeyId, SignStatusNo
FROM            FsFgbArch.dbo.AsDocumentData_All

--changeset system:create-alter-view-AsDocumentData-slw context:prd labels:c-slw,o-view,ot-schema,on-AsDocumentData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsDocumentData for slw and environment(s) prd
CREATE OR ALTER VIEW dbo.AsDocumentData AS
SELECT        Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, DocumentId, Format, RecordDate, Location, StatusNo, Comments, Datastring, Replaceable, ExpirationStart, Sign, PublicKeyId, SignStatusNo
FROM            FsSlwArch.dbo.AsDocumentData_All


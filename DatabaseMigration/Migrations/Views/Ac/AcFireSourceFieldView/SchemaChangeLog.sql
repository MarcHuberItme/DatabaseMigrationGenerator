--liquibase formatted sql

--changeset system:create-alter-view-AcFireSourceFieldView context:any labels:c-any,o-view,ot-schema,on-AcFireSourceFieldView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFireSourceFieldView
CREATE OR ALTER VIEW dbo.AcFireSourceFieldView AS
SELECT TOP 100 PERCENT
Id,
HdCreator,
HdChangeUser,
HdCreateDate,
HdChangeDate,
HdEditStamp,
HdPendingChanges,
HdPendingSubChanges,
HdProcessId,
HdVersionNo,
FieldName,
'Datatype:' + DataType AS DataType,
TableName
FROM MdField
WHERE FieldName NOT LIKE 'Hd%' 
AND HdVersionNo BETWEEN 1 AND 999999998

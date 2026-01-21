--liquibase formatted sql

--changeset system:create-alter-view-AcFireFieldView context:any labels:c-any,o-view,ot-schema,on-AcFireFieldView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFireFieldView
CREATE OR ALTER VIEW dbo.AcFireFieldView AS
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
'DB Default: ' + ISNULL(DefaultValue, '<NULL>') AS DefaultValue
FROM MdField
WHERE TableName = 'AcFireRecord' 
AND  HdVersionNo BETWEEN 1 AND 999999998
AND
(
    (  FieldName LIKE 'C%' AND LEN(FieldName) = 4)
	OR FieldName = 'NOGA'
	OR FieldName LIKE 'USER%'
)


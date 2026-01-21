--liquibase formatted sql

--changeset system:create-alter-procedure-MdField_GetMetaData context:any labels:c-any,o-stored-procedure,ot-schema,on-MdField_GetMetaData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MdField_GetMetaData
CREATE OR ALTER PROCEDURE dbo.MdField_GetMetaData
    @TableName varchar(30)  AS
   SELECT FieldName + '|'+ Ltrim(Str(VisNumber)) + '|' + Ltrim(Str(IsNotNull)) AS List
      FROM MdField WITH (READCOMMITTED)
      WHERE TableName = @TableName
         AND FieldName NOT IN('Id','HdCreateDate','HdCreator','HdChangeDate','HdChangeUser','HdVersionNo',
        'HdProcessId', 'HdEditStamp','HdPendingChanges','HdTriggerControl',
        'MasterId','MasterTableName')

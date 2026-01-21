--liquibase formatted sql

--changeset system:create-alter-view-MdField context:any labels:c-any,o-view,ot-schema,on-MdField,fin-13659 runOnChange:true splitStatements:false stripComments:false
--comment: Create view MdField

CREATE OR ALTER VIEW [dbo].[MdField] AS
SELECT MdFieldData.Id,
       MdFieldData.HdCreateDate,
       MdFieldData.HdCreator,
       MdFieldData.HdChangeDate,
       MdFieldData.HdChangeUser,
       MdFieldData.HdEditStamp,
       MdFieldData.HdVersionNo,
       MdFieldData.HdProcessId,
       MdFieldData.HdStatusFlag,
       MdFieldData.HdNoUpdateFlag,
       MdFieldData.HdPendingChanges,
       MdFieldData.HdPendingSubChanges,
       MdFieldData.HdTriggerControl,
       MdFieldData.TableId,
       MdFieldData.TableName,
       MdFieldData.FieldName,
       CASE
           WHEN MdTableDataDef.TableType = 5 THEN
               MdFieldData.DataType
           ELSE
               SystemSchema.DATA_TYPE
       END AS DataType,
       CASE
           WHEN MdTableDataDef.TableType = 5 THEN
               MdFieldData.IsNotNull
           ELSE
               CASE
                   WHEN SystemSchema.IS_NULLABLE = 'NO' THEN
                       'True'
                   ELSE
                       'False'
               END
       END AS IsNotNull,
       CASE
           WHEN MdTableDataDef.TableType = 5 THEN
               MdFieldData.IsUnique
           ELSE
               CASE
                   WHEN EXISTS
                        (
                            SELECT 1
                            FROM sys.index_columns IndexColumns
                                JOIN sys.indexes SysIndexes
                                    ON IndexColumns.object_id = SysIndexes.object_id
                                       AND IndexColumns.index_id = SysIndexes.index_id
                                JOIN sys.columns SysColumns
                                    ON SysColumns.object_id = IndexColumns.object_id
                                       AND SysColumns.column_id = IndexColumns.column_id
                            WHERE IndexColumns.object_id = OBJECT_ID('dbo.' + MdFieldData.TableName)
                                  AND SysColumns.name = MdFieldData.FieldName
                                  AND SysIndexes.is_unique_constraint = 1
                        ) THEN
                       'True'
                   ELSE
                       'False'
               END
       END AS IsUnique,
       CASE
           WHEN MdTableDataDef.TableType = 5 THEN
               MdFieldData.Prec
           ELSE
               CASE
                   WHEN SystemSchema.DATA_TYPE IN ( 'varchar', 'varbinary', 'binary', 'char', 'nchar', 'nvarchar' ) THEN
                       SystemSchema.CHARACTER_MAXIMUM_LENGTH
                   WHEN SystemSchema.DATA_TYPE = 'decimal' THEN
                       SystemSchema.NUMERIC_PRECISION
                   ELSE
                       0
               END
       END AS Prec,
       CASE
           WHEN MdTableDataDef.TableType = 5 THEN
               MdFieldData.Scale
           ELSE
               CASE
                   WHEN SystemSchema.DATA_TYPE IN ( 'decimal', 'money', 'smallmoney' ) THEN
                       SystemSchema.NUMERIC_SCALE
                   ELSE
                       0
               END
       END AS Scale,
       MdFieldData.MinValue,
       MdFieldData.MaxValue,
       CASE
           WHEN MdTableDataDef.TableType = 5 THEN
               MdFieldData.DefaultValue
           ELSE
               CASE
                   WHEN DefaultContraints.definition LIKE '%(0)%'
                        AND DefaultContraints.definition NOT LIKE '%[^0()]%' THEN
                       REPLACE(REPLACE(DefaultContraints.definition, '(', ''), ')', '')
                   ELSE
                       DefaultContraints.definition
               END
       END AS DefaultValue,
       MdFieldData.MultiLine,
       MdFieldData.RefTable,
       MdFieldData.RefField,
       MdFieldData.HasDetailBtn,
       MdFieldData.VisNumber,
       MdFieldData.DefSizeX,
       MdFieldData.DefSizeY,
       MdFieldData.DefPosX,
       MdFieldData.DefPosY,
       MdFieldData.TabOrder,
       MdFieldData.DefColumnPos,
       MdFieldData.DefColumnWidth,
       MdFieldData.NoUpdatePos,
       MdFieldData.IsOnlyForMig,
       MdFieldData.IsNoUpdate,
       MdFieldData.IsIdentity
FROM dbo.MdFieldData AS MdFieldData
    INNER JOIN dbo.MdTableDataDef AS MdTableDataDef
        ON MdTableDataDef.TableName = MdFieldData.TableName
    LEFT JOIN INFORMATION_SCHEMA.COLUMNS AS SystemSchema
        ON SystemSchema.TABLE_NAME = MdFieldData.TableName
           AND SystemSchema.COLUMN_NAME = MdFieldData.FieldName
    LEFT JOIN sys.columns AS SysColumns
        ON SysColumns.object_id = OBJECT_ID(MdTableDataDef.TableName)
           AND SysColumns.name = MdFieldData.FieldName
    LEFT JOIN sys.default_constraints DefaultContraints
        ON DefaultContraints.parent_object_id = SysColumns.object_id
           AND DefaultContraints.parent_column_id = SysColumns.column_id

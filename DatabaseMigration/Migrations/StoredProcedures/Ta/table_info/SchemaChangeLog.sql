--liquibase formatted sql

--changeset system:create-alter-procedure-table_info context:any labels:c-any,o-stored-procedure,ot-schema,on-table_info,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure table_info
CREATE OR ALTER PROCEDURE dbo.table_info
@table_name varchar(30)
AS
SELECT  TableName, FieldName, DataType, IsNotNull, IsUnique
                , Prec, Scale, MinValue, MaxValue, RefTable, RefField
FROM    MdField
WHERE   TableName Like @table_name
AND     FieldName NOT Like 'Hd%'
ORDER BY TableName, FieldName

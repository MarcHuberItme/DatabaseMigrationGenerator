--liquibase formatted sql

--changeset system:create-alter-procedure-MdTable_GetMetaData context:any labels:c-any,o-stored-procedure,ot-schema,on-MdTable_GetMetaData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MdTable_GetMetaData
CREATE OR ALTER PROCEDURE dbo.MdTable_GetMetaData
   @TableName varchar(30)  AS
   SELECT TableType, DefArchive, VisumLevel, VisumNumber, HasAsText, 
                  CacheLevel,PhysicalDelete,DescField,ApplicationKey,ParentTable,
                  ParentRelationField,ParentIdField,DoBackMigrate,IsNavigationRoot,
                  NavigationConditionField,IsSharedNode,IsHiddenNode,RootTable
      FROM MdTable WITH (READCOMMITTED)
      WHERE TableName = @TableName

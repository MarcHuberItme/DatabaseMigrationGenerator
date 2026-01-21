--liquibase formatted sql

--changeset system:create-alter-view-MdTable context:any labels:c-any,o-view,ot-schema,on-MdTable,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MdTable
CREATE OR ALTER VIEW dbo.MdTable AS
SELECT TOP 100 PERCENT 
T.Id,
T.HdCreateDate,
T.HdCreator,
T.HdChangeDate,
T.HdChangeUser,
T.HdEditStamp,
T.HdVersionNo,
T.HdProcessId,
T.HdStatusFlag,
T.HdNoUpdateFlag,
T.HdPendingChanges,
T.HdPendingSubChanges,
T.HdTriggerControl,
T.TableName,
T.TableType,
T.GroupId,
T.DefArchive,
ISNULL(TB.VisumLevel,T.VisumLevel) As VisumLevel,
T.VisumNumber,
T.HasAsText,
T.CacheLevel,
T.PhysicalDelete,
T.IsGroupable,
T.TableUsageNo,
T.DomainType,
T.DescField,
T.IsNavigationRoot,
T.ApplicationKey,
T.NavigationConditionField,
T.RootTable,
T.ParentTable,
T.ParentRelationField,
T.ParentIdField,
T.IsSharedNode,
T.IsHiddenNode,
T.DoBackMigrate,
TB.FunctionGroupNo,
isnull(TB.ChangeNoticeLevel,T.ChangeNoticeLevel) as ChangeNoticeLevel
FROM  MdTableDataDef T
      LEFT OUTER JOIN MdTableDeviationBank TB ON T.TableName = TB.TableName AND (TB.HdVersionNo BETWEEN 1 AND 999999998 OR TB.HdVersionNo IS NULL)


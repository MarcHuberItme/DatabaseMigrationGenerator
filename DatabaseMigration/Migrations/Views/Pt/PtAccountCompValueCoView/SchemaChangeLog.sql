--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCompValueCoView context:any labels:c-any,o-view,ot-schema,on-PtAccountCompValueCoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCompValueCoView
CREATE OR ALTER VIEW dbo.PtAccountCompValueCoView AS
select 
a1.Id,
a1.HdCreateDate, 
a1.HdEditStamp,
a1.HdStatusFlag, 
a1.HdPendingChanges, 
a1.HdPendingSubChanges, 
a1.HdVersionNo,
a1.HdProcessId,
k1.collclean,
a1.accountComponentId,
a1.ValidFrom,
a1.Value,
a1.IsFixed,
a1.IsDurationRecord,
a1.StartRecordId
from ptaccountcompvalue a1,ptaccountbase k1 where 
k1.collclean = 0 and
k1.id = (select top 1 accountbaseid from ptaccountcomponent where ptaccountcomponent.id = a1.accountcomponentid)
union all
select 
a2.Id,
a2.HdCreateDate, 
a2.HdEditStamp,
a2.HdStatusFlag, 
a2.HdPendingChanges, 
a2.HdPendingSubChanges, 
a2.HdVersionNo,
a2.HdProcessId,
k2.collclean,
a2.accountComponentId,
a2.ValidFrom,
a2.Value,
a2.IsFixed,
a2.IsDurationRecord,
a2.StartRecordId
 from coptaccountcompvalue a2,ptaccountbase k2 where 
k2.collclean = 1 and
 k2.id = (select top 1 accountbaseid from coptaccountcomponent where coptaccountcomponent.id = a2.accountcomponentid)

--liquibase formatted sql

--changeset system:create-alter-view-CoEngCliSameView context:any labels:c-any,o-view,ot-schema,on-CoEngCliSameView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEngCliSameView
CREATE OR ALTER VIEW dbo.CoEngCliSameView AS
SELECT
     c.Id,
     c.HdCreateDate, 
     c.HdEditStamp,
     c.HdStatusFlag, 
     c.HdPendingChanges, 
     c.HdPendingSubChanges, 
     c.HdVersionNo,
     c.HdProcessId,
     a.id as Ptrelationmasterid,ptbase.id as Memberid, ptbase.Partnerno,ptbase.Partnernoedited,ptbase.sexstatusno, ptbase.Firstname,ptbase.Name,
     d.id as Masterid,d.partnerno as MasterPartnerno,d.Partnernoedited as MasterPartnernoedited,d.firstname as MasterFirstname,
     d.name as MasterName,
     a.Relationtypeno,Null as LastCheckDate,c.RelationRoleNo ,a.Copartnership,Isjointheirexclude,c.Instruction
     from ptrelationmaster a, ptrelationslave c,ptbase d, ptbase where 
     c.masterid = a.id
     and a.relationtypeno = 90
     and ptbase.id = c.partnerid 
     and c.RelationRoleNo = 7
     and d.id      = a.partnerid 
     and d.Terminationdate is null
     and ptbase.Terminationdate is null
     and a.HdVersionNo < 999999999
     and c.HdVersionNo < 999999999
     and d.HdVersionNo < 999999999
union 
SELECT
     a.Id,
     a.HdCreateDate, 
     a.HdEditStamp,
     a.HdStatusFlag, 
     a.HdPendingChanges, 
     a.HdPendingSubChanges, 
     a.HdVersionNo,
     a.HdProcessId,
     a.id as Ptrelationmasterid,ptbase.id as Memberid, Partnerno, Partnernoedited,sexstatusno, Firstname, Name,
     ptbase.id as Masterid, partnerno  as MasterPartnerno,partnernoedited as MasterPartnernoedited,firstname as MasterFirstname,
     name as MasterName,
     a.Relationtypeno,Null As LastCheckDate,NULL as RelationRoleNo,a.Copartnership,Isjointheirexclude,NULL as Instruction
     from ptrelationmaster a, ptrelationslave c,ptbase where 
     c.masterid = a.id
     and a.relationtypeno = 90
     and ptbase.id = a.partnerid 
     and ptbase.Terminationdate is null
     and a.HdVersionNo < 999999999
     and c.HdVersionNo < 999999999

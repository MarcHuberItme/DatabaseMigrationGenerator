--liquibase formatted sql

--changeset system:create-alter-view-CoEngcliView context:any labels:c-any,o-view,ot-schema,on-CoEngcliView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEngcliView
CREATE OR ALTER VIEW dbo.CoEngcliView AS
SELECT		
     c.Id,
     c.HdCreateDate, 
     c.HdEditStamp,
     c.HdStatusFlag, 
     c.HdPendingChanges, 
     c.HdPendingSubChanges, 
     c.HdVersionNo,
     c.HdProcessId,
     a.Id as Ptrelationmasterid, ptbase.id as Memberid, ptbase.Partnerno,ptbase.Partnernoedited,ptbase.sexstatusno, ptbase.Firstname, ptbase.Name,
     d.Id as Masterid,d.partnerno as MasterPartnerno,d.partnernoedited as MasterPartnernoedited,d.firstname as MasterFirstname,
     d.name as MasterName,
     a.Relationtypeno,Null as LastCheckDate, c.RelationRoleNo ,a.Copartnership,Isjointheirexclude,c.Instruction
     from ptrelationmaster a, ptrelationslave c,ptbase d, ptbase where 
      c.masterid = a.id
     and ((c.RelationRoleNo in (6,7) and a.copartnership = 1 and a.IsJointHeirExclude = 1) or 
          (c.RelationRoleNo in (6,7,18) and a.copartnership = 1 and a.IsJointHeirExclude = 0))
     and a.relationtypeno = 10
     and ptbase.id = c.partnerid 
     and d.id      = a.partnerid 
     and ptbase.Terminationdate is null
     and d.Terminationdate is null
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
     a.id as Ptrelationmasterid ,ptbase.id as Memberid, ptbase.Partnerno,ptbase.Partnernoedited,ptbase.sexstatusno, ptbase.Firstname, ptbase.Name,
     ptbase.id as Masterid, partnerno  as MasterPartnerno,partnernoedited as MasterPartnernoedited,firstname as MasterFirstname,  
     name as MasterName,
     a.Relationtypeno,Null As LastCheckDate, NULL as RelationRoleNo ,a.Copartnership,Isjointheirexclude,NULL as Instruction
     from ptrelationmaster a, ptrelationslave c,ptbase where 
          c.masterid = a.id
     and ((c.RelationRoleNo in (6,7) and a.copartnership = 1 and a.IsJointHeirExclude = 1) or 
          (c.RelationRoleNo in (6,7,18) and a.copartnership = 1 and a.IsJointHeirExclude = 0))
     and a.relationtypeno = 10
     and ptbase.id = a.partnerid 
     and ptbase.Terminationdate is null
     and a.HdVersionNo < 999999999
     and c.HdVersionNo < 999999999
union
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
     a.Relationtypeno,a.LastCheckDate, c.RelationRoleNo ,a.Copartnership,Isjointheirexclude,c.Instruction
     from ptrelationmaster a, ptrelationslave c,ptbase d, ptbase where 
     c.masterid = a.id
     and a.relationtypeno = 92
     and ptbase.id = c.partnerid 
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
     a.Relationtypeno,a.LastCheckDate, NULL as RelationRoleNo,a.Copartnership,Isjointheirexclude,NULL as Instruction
     from ptrelationmaster a, ptrelationslave c,ptbase where 
     c.masterid = a.id
     and a.relationtypeno = 92
     and ptbase.id = a.partnerid 
     and ptbase.Terminationdate is null
     and a.HdVersionNo < 999999999
     and c.HdVersionNo < 999999999
union
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
     and a.relationtypeno = 94
     and ptbase.id = c.partnerid 
     and c.RelationRoleNo = 25
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
     and a.relationtypeno = 94
     and ptbase.id = a.partnerid 
     and ptbase.Terminationdate is null
     and a.HdVersionNo < 999999999
     and c.HdVersionNo < 999999999


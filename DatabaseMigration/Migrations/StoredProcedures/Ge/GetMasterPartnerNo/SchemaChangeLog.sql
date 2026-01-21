--liquibase formatted sql

--changeset system:create-alter-procedure-GetMasterPartnerNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMasterPartnerNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMasterPartnerNo
CREATE OR ALTER PROCEDURE dbo.GetMasterPartnerNo
@SlaveId UniqueIdentifier
As
Select Master.PartnerNo as MasterPartnerNo from PtRelationSlave
inner join PtRelationMaster on PtRelationSlave.MasterId = PtRelationMaster.Id
inner join PtBase Master on Master.Id = PtRelationMaster.PartnerId
Where PtRelationSlave.PartnerId = @SlaveId and PtRelationSlave.HdVersionNo between 1 and 999999998 and RelationRoleNo = 7

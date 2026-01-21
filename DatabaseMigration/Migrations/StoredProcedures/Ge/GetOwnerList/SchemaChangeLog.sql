--liquibase formatted sql

--changeset system:create-alter-procedure-GetOwnerList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetOwnerList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetOwnerList
CREATE OR ALTER PROCEDURE dbo.GetOwnerList

@PartnerId uniqueidentifier

AS

SELECT Id AS PartnerId, PartnerNo, PartnerNoEdited, Name, FirstName, DateOfBirth, 0 AS RelationTypeNo, 0 AS CoPartnership
FROM PtBase WHERE Id = @PartnerId AND SexStatusNo IN (1,2)

UNION ALL 

select S.PartnerId, Base.PartnerNo, Base.PartnerNoEdited, Base.Name, Base.FirstName, Base.DateOfBirth, M.RelationTypeNo, M.CoPartnership  
FROM PtRelationMaster AS M  
INNER JOIN PtRelationSlave AS S ON M.Id = S.MasterId  
INNER JOIN PtBase AS Base ON Base.Id = S.PartnerId  
WHERE M.PartnerId = @PartnerId 
AND M.RelationTypeNo = 10  
--AND M.CoPartnership = 1  
AND S.RelationRoleNo = 6  
AND M.HdVersionNo BETWEEN 1 AND 999999998  
AND S.HdVersionNo BETWEEN 1 AND 999999998 


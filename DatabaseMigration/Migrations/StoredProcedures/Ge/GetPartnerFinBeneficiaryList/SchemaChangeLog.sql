--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerFinBeneficiaryList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerFinBeneficiaryList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerFinBeneficiaryList
CREATE OR ALTER PROCEDURE dbo.GetPartnerFinBeneficiaryList

@PartnerId uniqueidentifier

AS

SELECT S.PartnerId, Rs.TerminationDate 
FROM PtRelationMaster AS M
INNER JOIN PtRelationSlave AS S ON M.Id = S.MasterId
INNER JOIN PtBase AS Rs ON S.PartnerId = Rs.Id
WHERE M.PartnerId = @PartnerId 
AND M.RelationTypeNo = 20


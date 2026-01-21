--liquibase formatted sql

--changeset system:create-alter-procedure-NcKdBatchFullShabHrNM2 context:any labels:c-any,o-stored-procedure,ot-schema,on-NcKdBatchFullShabHrNM2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcKdBatchFullShabHrNM2
CREATE OR ALTER PROCEDURE dbo.NcKdBatchFullShabHrNM2
@LastPartnerNo int, 
@LastExecutionDate DateTime	
AS
BEGIN
SET NOCOUNT ON;	
SELECT top 500 p.Id,
           p.Name,
           p.FirstName,
           p.NameCont,
           p.MaidenName,
           p.MiddleName,
           p.PartnerNo,
           p.SexStatusNo,
           p.LegalStatusNo,
           p.DateOfBirth,
           n.Nationlist,
           a.Addresslist
FROM PtBase p
LEFT JOIN
  (SELECT STRING_AGG(CountryCode, ';') Nationlist,
          PartnerId
   FROM PtNationality
   WHERE HdVersionNo < 999999999
   GROUP BY PartnerId) n ON n.PartnerId = p.Id
LEFT JOIN
  (SELECT STRING_AGG(CountryCode, ';') Addresslist,
          PartnerId
   FROM PtAddress
   WHERE HdVersionNo < 999999999
     AND CountryCode IS NOT NULL
   GROUP BY PartnerId) a ON a.PartnerId = p.Id
LEFT OUTER JOIN PtIdentification uids ON uids.PartnerId = p.Id
AND uids.HdVersionNo < 999999999
AND uids.ReferenceNo LIKE 'CHE%'
WHERE p.PartnerNo > @LastPartnerNo
  AND p.HdVersionNo < 999999999
  AND p.ServiceLevelNo NOT IN(10,
                              11,
                              15,
                              20,
                              24)
  AND p.TerminationDate IS NULL
  AND uids.ReferenceNo IS NULL
  AND p.DateOfBirth IS NOT NULL
ORDER BY p.PartnerNo
END

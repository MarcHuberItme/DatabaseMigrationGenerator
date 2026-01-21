--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditCoPartners context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditCoPartners,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditCoPartners
CREATE OR ALTER PROCEDURE dbo.GetConsCreditCoPartners

@PartnerId uniqueidentifier

AS

SELECT Pt.Id, Pt.Name, Pt.FirstName, Pt.MaidenName, Pt.ChangeNameOrder, Pt.DateOfBirth, Pt.SexStatusNo, Pt.LegalStatusNo, Pt.NogaCode2008, Pt.OpeningDate, 
Adr.Zip, Adr.Town, Adr.Street, Adr.HouseNo, Pt.TerminationDate, Adr.CountryCode, Adr.HdChangeDate AS AddressChangeDate 
FROM PtRelationMaster AS Rm 
INNER JOIN PtRelationSlave AS Rs ON Rm.Id = Rs.MasterId AND Rs.RelationRoleNo = 6 
INNER JOIN PtBase AS Pt ON Rs.PartnerId = Pt.Id 
LEFT OUTER JOIN PtAddress AS Adr ON Pt.Id = Adr.PartnerId AND AddressTypeNo = 11
WHERE Rm.PartnerId = @PartnerId
AND Rm.RelationTypeNo = 10 
AND Rs.HdVersionNo BETWEEN 1 AND 999999998 
ORDER BY Pt.SexStatusNo DESC, Pt.DateOfBirth ASC, Pt.PartnerNo ASC


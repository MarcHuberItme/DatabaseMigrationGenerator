--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetContractsByCertWithContactPerson context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetContractsByCertWithContactPerson,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetContractsByCertWithContactPerson
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetContractsByCertWithContactPerson
@PartnerId UNIQUEIDENTIFIER,
@ContactPersonId UNIQUEIDENTIFIER
AS

SELECT PAE.MgVtNo As AgreementNumber, ISNULL(PAE.CustomerReference, PB.Name) AS Name
FROM PtAgrEBanking as PAE
LEFT OUTER JOIN PtBase as PB on PB.Id = PAE.PartnerId
WHERE PAE.PartnerId = @PartnerId
AND (PAE.BeginDate IS NULL OR PAE.BeginDate <= GETDATE())
AND (PAE.ExpirationDate IS NULL OR PAE.ExpirationDate > GETDATE())
AND (PAE.HdVersionNo BETWEEN 1 AND 999999998)
AND PAE.ContactPersonId = @ContactPersonId

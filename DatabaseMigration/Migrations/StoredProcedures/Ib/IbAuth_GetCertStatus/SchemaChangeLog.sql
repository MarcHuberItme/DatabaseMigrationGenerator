--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetCertStatus context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetCertStatus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetCertStatus
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetCertStatus
@CertRef varchar(38)
AS
SELECT ptb.Id AS PartnerId, pta.ContactPersonId, ptc.CertStatus, ptc.SHA1Fingerprint, ptc.ExpirationDate, pta.ExpirationDate AS AgrPkiExpiration
FROM PtAgrPki pta
JOIN PtPkiCert ptc ON pta.Id = ptc.AgrPkiId
JOIN PtBase ptb ON pta.PartnerId = ptb.Id  
WHERE ptc.CertificateReference = @CertRef
AND (pta.HdVersionNo BETWEEN 1 AND 999999998) AND (ptc.HdVersionNo BETWEEN 1 AND 999999998)

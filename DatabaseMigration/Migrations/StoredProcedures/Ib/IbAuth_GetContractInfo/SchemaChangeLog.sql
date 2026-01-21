--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetContractInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetContractInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetContractInfo
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetContractInfo
@AgrNo varchar(10)
AS

SELECT PAE.ContactPersonId, PAE.Id AS AgrEbankingId, PB.Id AS CustomerId, PB.FirstName AS CustomerFirstName, PB.Name AS CustomerName, PCP.FirstName AS ContactPersonFirstName, PCP.Name AS ContactPersonName, PAE.AGBacceptedByCustomer, PAE.ExpirationDate
FROM PtAgrEbanking PAE
JOIN PtBase PB ON PAE.PartnerId = PB.Id
LEFT OUTER JOIN PtAgrSecureList PASL ON PAE.PartnerId = PASL.PartnerId AND PASL.PrevEBankingNo = @AgrNo AND PASL.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtContactPersonView PCP ON PCP.Id = PAE.ContactPersonId
WHERE PAE.MgVtNo = @AgrNo AND PAE.HdVersionNo BETWEEN 1 AND 999999998

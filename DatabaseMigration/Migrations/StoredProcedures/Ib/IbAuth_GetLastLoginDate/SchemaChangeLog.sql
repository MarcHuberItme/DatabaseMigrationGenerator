--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetLastLoginDate context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetLastLoginDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetLastLoginDate
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetLastLoginDate
@AgrEbankingId UNIQUEIDENTIFIER
AS

SELECT TOP 1 LoginDate FROM PtLogin
WHERE EbankingId = @AgrEbankingId
ORDER BY LoginDate DESC

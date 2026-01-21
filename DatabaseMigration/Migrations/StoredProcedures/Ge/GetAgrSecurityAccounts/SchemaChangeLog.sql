--liquibase formatted sql

--changeset system:create-alter-procedure-GetAgrSecurityAccounts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAgrSecurityAccounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAgrSecurityAccounts
CREATE OR ALTER PROCEDURE dbo.GetAgrSecurityAccounts

@AgrSecurityId UNIQUEIDENTIFIER,
@LanguageNo TINYINT

AS

select distinct Partner , Account, AccountNo
FROM PtAgrSecurityAccountView
WHERE AgrSecurityId = @AgrSecurityId
AND (LanguageNo IS NULL OR LanguageNo = @LanguageNo)
ORDER BY AccountNo ASC

--liquibase formatted sql

--changeset system:create-alter-procedure-GetAgrSecurityInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAgrSecurityInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAgrSecurityInfo
CREATE OR ALTER PROCEDURE dbo.GetAgrSecurityInfo

@AccountSecurityId uniqueidentifier,
@LanguageNo tinyint

AS

SELECT AgrDescription FROM PtAgrSecurityView
WHERE Id = @AccountSecurityId AND LanguageNo = @LanguageNo 

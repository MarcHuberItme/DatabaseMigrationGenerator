--liquibase formatted sql

--changeset system:create-alter-procedure-GetAuthUseCaseInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAuthUseCaseInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAuthUseCaseInfo
CREATE OR ALTER PROCEDURE dbo.GetAuthUseCaseInfo
@UseCaseName varchar(40),
@LanguageNo tinyint

AS

-- GetAuthUseCaseInfo
SELECT TX.TextLong as FuturaeType, IsTriggeredByFinstar
FROM OaAuthUseCase UC
INNER JOIN AsText AS TX ON UC.Id = TX.MasterId AND TX.MasterTableName = 'OaAuthUseCase'
WHERE UC.UseCaseName = @UseCaseName
AND TX.LanguageNo = @LanguageNo
AND UC.HdVersionNo BETWEEN 1 AND 999999998


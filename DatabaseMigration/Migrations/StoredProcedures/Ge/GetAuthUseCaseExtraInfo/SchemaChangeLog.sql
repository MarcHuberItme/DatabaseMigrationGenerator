--liquibase formatted sql

--changeset system:create-alter-procedure-GetAuthUseCaseExtraInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAuthUseCaseExtraInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAuthUseCaseExtraInfo
CREATE OR ALTER PROCEDURE dbo.GetAuthUseCaseExtraInfo
@UseCaseName varchar(40),
@LanguageNo tinyint

AS

-- GetAuthUseCaseExtraInfo
SELECT ROW_NUMBER() OVER (ORDER BY SortNo, ObjectKey ASC) as Position, ObjectKey as ExtraInfoKey, ObjectValue as ExtraInfoValue
FROM OaAuthUCExtraInfo EI
INNER JOIN OaAuthUseCase as UC ON UC.UseCaseNo = EI.UseCaseNo
LEFT OUTER JOIN AsText as TX ON EI.Id = TX.MasterId AND TX.MasterTableName = 'OaAuthUCExtraInfo'
WHERE UC.UseCaseName = @UseCaseName
AND TX.LanguageNo = @LanguageNo
AND EI.HdVersionNo BETWEEN 1 AND 999999998

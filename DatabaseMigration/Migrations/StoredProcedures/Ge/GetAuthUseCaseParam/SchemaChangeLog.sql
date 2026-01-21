--liquibase formatted sql

--changeset system:create-alter-procedure-GetAuthUseCaseParam context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAuthUseCaseParam,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAuthUseCaseParam
CREATE OR ALTER PROCEDURE dbo.GetAuthUseCaseParam
@UseCaseName varchar(40)

AS

-- GetAuthUseCaseParam
SELECT ParamName, IsOptional
FROM OaAuthUcParam Param
INNER JOIN OaAuthUseCase as UC ON UC.UseCaseNo = Param.UseCaseNo
WHERE UC.UseCaseName = @UseCaseName
AND Param.HdVersionNo BETWEEN 1 AND 999999998

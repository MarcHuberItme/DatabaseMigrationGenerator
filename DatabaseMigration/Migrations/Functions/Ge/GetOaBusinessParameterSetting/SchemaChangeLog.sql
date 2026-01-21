--liquibase formatted sql

--changeset system:create-alter-function-GetOaBusinessParameterSetting context:any labels:c-any,o-function,ot-schema,on-GetOaBusinessParameterSetting,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetOaBusinessParameterSetting
CREATE OR ALTER FUNCTION dbo.GetOaBusinessParameterSetting
(
    @ApplicationCode VARCHAR(50),
    @FullyQualifiedName VARCHAR(400)
)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 *
    FROM (
        SELECT * FROM OaBusinessParameterSetting
        WHERE FullyQualifiedName = @FullyQualifiedName
          AND ApplicationCode = @ApplicationCode
          AND HdVersionNo BETWEEN 1 AND 999999998

        UNION ALL

        SELECT * FROM OaBusinessParameterSetting
        WHERE FullyQualifiedName = @FullyQualifiedName
          AND ApplicationCode = 'Default'
          AND HdVersionNo BETWEEN 1 AND 999999998
    ) AS Combined
);

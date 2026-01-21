--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrivateComponent context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrivateComponent,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrivateComponent
CREATE OR ALTER PROCEDURE dbo.GetPrivateComponent
    @AccountComponentId UniqueIdentifier
AS 

SELECT P.* FROM PtAccountComponent AS A
JOIN PrPrivateComponent AS P
ON A.PrivateComponentId = P.Id
WHERE A.Id = @AccountComponentId


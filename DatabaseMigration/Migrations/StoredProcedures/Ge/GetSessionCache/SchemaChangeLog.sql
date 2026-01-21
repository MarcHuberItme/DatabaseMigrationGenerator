--liquibase formatted sql

--changeset system:create-alter-procedure-GetSessionCache context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSessionCache,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSessionCache
CREATE OR ALTER PROCEDURE dbo.GetSessionCache
    @SessionKey nVarChar(50)
    AS
/*
DELETE FROM OaSessionCache
WHERE LastAccessTime < DATEADD(HH, -2, GETDATE());
*/
SELECT Id, SessionKey, Session, SessionCache, LastAccessTime, LastRefreshTime
FROM OaSessionCache
WHERE SessionKey = @SessionKey AND HdVersionNo BETWEEN 1 AND 999999998;
UPDATE OaSessionCache
SET LastAccessTime = GETDATE()
WHERE SessionKey = @SessionKey;

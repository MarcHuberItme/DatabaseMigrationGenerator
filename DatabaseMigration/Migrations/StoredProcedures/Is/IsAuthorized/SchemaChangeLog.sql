--liquibase formatted sql

--changeset system:create-alter-procedure-IsAuthorized context:any labels:c-any,o-stored-procedure,ot-schema,on-IsAuthorized,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsAuthorized
CREATE OR ALTER PROCEDURE dbo.IsAuthorized
    @UserId UniqueIdentifier,
    @PrivacyLock int,
    @GroupTypeId UniqueIdentifier,
    @Result TINYINT OUTPUT

AS 

SET @Result = 0

IF EXISTS (SELECT G.Id
              FROM AsGroup As G
                JOIN AsGroupMember As M
                   ON G.Id = M.GroupId
                JOIN AsUserAccess As U
                   ON G.Id = U.UserGroupId
              WHERE M.TargetRowId = @UserId
                AND G.GroupTypeId = @GroupTypeId
                AND U.PrivacyLock = @PrivacyLock)
BEGIN
SET @Result = 1
END


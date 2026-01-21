--liquibase formatted sql

--changeset system:create-alter-procedure-GetUserProfile context:any labels:c-any,o-stored-procedure,ot-schema,on-GetUserProfile,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetUserProfile
CREATE OR ALTER PROCEDURE dbo.GetUserProfile
    @userprofileid  uniqueidentifier AS
    SELECT  UserProfileId, ControlName, PropertyName, PropertyValue 
        FROM AsProfileValue WITH (READCOMMITTED)
        WHERE UserProfileId = @userprofileid
            AND HdVersionNo > 0 AND HdVersionNo < 999999999
        ORDER BY UserProfileId, ControlName, PropertyName    

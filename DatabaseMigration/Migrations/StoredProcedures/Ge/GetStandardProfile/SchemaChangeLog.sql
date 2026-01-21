--liquibase formatted sql

--changeset system:create-alter-procedure-GetStandardProfile context:any labels:c-any,o-stored-procedure,ot-schema,on-GetStandardProfile,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetStandardProfile
CREATE OR ALTER PROCEDURE dbo.GetStandardProfile
@formname varchar(30), @username varchar(15) AS
    DECLARE @SystemProfileId uniqueidentifier, @UserProfileId uniqueidentifier
    -- Retrieve UserProfileId of the standard system profile
    SET @UserProfileId = 
        (Select Id FROM AsProfileUser WITH (READCOMMITTED)
            WHERE FormName = @formname
                 AND SystemProfile = 'Standard'
                 AND UserName = 'System'
                 AND UserProfile = 'Standard'
                 AND HdVersionNo > 0 AND HdVersionNo < 999999999)
 
   -- Get all possible system profiles for that form 
   SELECT SystemProfile FROM AsProfileSystem WITH (READCOMMITTED)
        WHERE FormName = @formname
            AND HdVersionNo > 0 AND HdVersionNo < 999999999
        ORDER BY SystemProfile
    
    -- Get all possible user profiles for that form and user
    SELECT Id, HdEditStamp, SystemProfile, UserProfile, UserName 
        FROM AsProfileUser WITH (READCOMMITTED)
        WHERE FormName = @formname 
            And (UserName = @username OR UserName = 'System')
            AND HdVersionNo > 0 AND HdVersionNo < 999999999
        ORDER BY SystemProfile, UserProfile

    -- Get all propery values to initialize the form
    SELECT UserProfileId, ControlName, PropertyName, PropertyValue 
        FROM AsProfileValue WITH (READCOMMITTED)
        WHERE UserProfileId = @UserProfileId
            AND HdVersionNo > 0 AND HdVersionNo < 999999999
        ORDER BY UserProfileId, ControlName, PropertyName    


--liquibase formatted sql

--changeset system:create-alter-procedure-LookUpSystemProfile context:any labels:c-any,o-stored-procedure,ot-schema,on-LookUpSystemProfile,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure LookUpSystemProfile
CREATE OR ALTER PROCEDURE dbo.LookUpSystemProfile
        @formname varchar(30), 
        @systemprofile varchar(30),
        @existresult smallint OUT AS
      
    IF EXISTS(SELECT * FROM AsProfileUser 
                               WHERE FormName = @formname
                               AND SystemProfile = @systemprofile
                               AND UserName = 'System'
                               AND UserProfile = 'Standard')
        SET @existresult = 1
    ELSE
        SET @existresult = 0


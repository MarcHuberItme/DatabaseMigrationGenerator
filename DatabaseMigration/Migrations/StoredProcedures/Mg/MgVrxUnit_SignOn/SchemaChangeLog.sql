--liquibase formatted sql

--changeset system:create-alter-procedure-MgVrxUnit_SignOn context:any labels:c-any,o-stored-procedure,ot-schema,on-MgVrxUnit_SignOn,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgVrxUnit_SignOn
CREATE OR ALTER PROCEDURE dbo.MgVrxUnit_SignOn
    @Workstation VARCHAR(50),
    @UserName VARCHAR(50),
    @Session TINYINT

AS

    DECLARE @SunNoId UNIQUEIDENTIFIER

    SELECT TOP 1 @SunNoId = Id
        FROM MgVrxUnit
    WHERE (SignOnDate IS NULL OR DATEDIFF(day, SignOnDate,getdate()) >= 1)
        AND HdVersionNo > 0 AND HdVersionNo < 999999999
    ORDER BY SunNo ASC
    
    IF NOT @SunNoId IS NULL
        UPDATE MgVrxUnit
        SET SignOnDate = getdate(), 
            Workstation = @Workstation, 
            UserName = @UserName, 
            SessionNo = @Session
        WHERE ID = @SunNoId

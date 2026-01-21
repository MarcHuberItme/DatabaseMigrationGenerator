--liquibase formatted sql

--changeset system:create-alter-procedure-MgVrxUnit_GetSunNo context:any labels:c-any,o-stored-procedure,ot-schema,on-MgVrxUnit_GetSunNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgVrxUnit_GetSunNo
CREATE OR ALTER PROCEDURE dbo.MgVrxUnit_GetSunNo
    @Workstation VARCHAR(50),
    @UserName VARCHAR(50),
    @Session TINYINT

AS

    SELECT SunNo 
        FROM MgVrxUnit
    WHERE Workstation = @Workstation
        AND UserName = @UserName
        AND SessionNo = @Session
        AND datediff (day, SignOnDate, GetDate()) < 1
        AND HdVersionNo > 0 AND HdVersionNo < 999999999

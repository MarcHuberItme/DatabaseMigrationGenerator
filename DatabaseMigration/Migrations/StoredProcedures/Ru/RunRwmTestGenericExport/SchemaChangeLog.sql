--liquibase formatted sql

--changeset system:create-alter-procedure-RunRwmTestGenericExport context:any labels:c-any,o-stored-procedure,ot-schema,on-RunRwmTestGenericExport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunRwmTestGenericExport
CREATE OR ALTER PROCEDURE dbo.RunRwmTestGenericExport
AS
BEGIN
	SELECT TOP(50) FileName, StatusNo, ErrorInfo FROM PtLibertyRun
END

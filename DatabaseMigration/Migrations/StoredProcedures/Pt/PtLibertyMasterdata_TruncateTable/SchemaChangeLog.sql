--liquibase formatted sql

--changeset system:create-alter-procedure-PtLibertyMasterdata_TruncateTable context:any labels:c-any,o-stored-procedure,ot-schema,on-PtLibertyMasterdata_TruncateTable,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtLibertyMasterdata_TruncateTable
CREATE OR ALTER PROCEDURE dbo.PtLibertyMasterdata_TruncateTable
AS
BEGIN
TRUNCATE TABLE [dbo].[PtLibertyMasterdata];
END

--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteRoTransactionProcessForUnitTests context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteRoTransactionProcessForUnitTests,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteRoTransactionProcessForUnitTests
CREATE OR ALTER PROCEDURE dbo.DeleteRoTransactionProcessForUnitTests
AS
DELETE FROM RoTransactionProcess

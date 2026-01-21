--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteTypedCustomers context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteTypedCustomers,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteTypedCustomers
CREATE OR ALTER PROCEDURE dbo.DeleteTypedCustomers
AS
TRUNCATE TABLE PtMLTypedCustomers

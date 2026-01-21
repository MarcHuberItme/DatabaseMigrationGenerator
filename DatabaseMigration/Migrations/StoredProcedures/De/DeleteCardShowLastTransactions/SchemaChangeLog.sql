--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteCardShowLastTransactions context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteCardShowLastTransactions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteCardShowLastTransactions
CREATE OR ALTER PROCEDURE dbo.DeleteCardShowLastTransactions
AS
TRUNCATE TABLE PtCardShowLastTransactions

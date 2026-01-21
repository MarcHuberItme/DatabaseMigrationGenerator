--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteCardShowLastFoTransactions context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteCardShowLastFoTransactions,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteCardShowLastFoTransactions
CREATE OR ALTER PROCEDURE dbo.DeleteCardShowLastFoTransactions
AS
TRUNCATE TABLE PtCardShowLastFoTransactions

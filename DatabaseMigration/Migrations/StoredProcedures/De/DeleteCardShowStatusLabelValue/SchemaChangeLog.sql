--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteCardShowStatusLabelValue context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteCardShowStatusLabelValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteCardShowStatusLabelValue
CREATE OR ALTER PROCEDURE dbo.DeleteCardShowStatusLabelValue
AS
TRUNCATE TABLE PtCardShowStatusLabelValue

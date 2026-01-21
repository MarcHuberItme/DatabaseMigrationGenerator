--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteCardShowJournal context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteCardShowJournal,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteCardShowJournal
CREATE OR ALTER PROCEDURE dbo.DeleteCardShowJournal
as
TRUNCATE TABLE PtCardShowJournal

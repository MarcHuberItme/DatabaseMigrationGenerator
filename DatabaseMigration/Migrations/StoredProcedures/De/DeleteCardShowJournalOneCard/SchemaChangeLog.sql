--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteCardShowJournalOneCard context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteCardShowJournalOneCard,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteCardShowJournalOneCard
CREATE OR ALTER PROCEDURE dbo.DeleteCardShowJournalOneCard
AS 
TRUNCATE TABLE PtCardShowJournalOneCard

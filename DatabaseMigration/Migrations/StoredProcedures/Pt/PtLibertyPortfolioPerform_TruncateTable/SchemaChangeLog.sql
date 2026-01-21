--liquibase formatted sql

--changeset system:create-alter-procedure-PtLibertyPortfolioPerform_TruncateTable context:any labels:c-any,o-stored-procedure,ot-schema,on-PtLibertyPortfolioPerform_TruncateTable,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtLibertyPortfolioPerform_TruncateTable
CREATE OR ALTER PROCEDURE dbo.PtLibertyPortfolioPerform_TruncateTable
AS
BEGIN
TRUNCATE TABLE [dbo].[PtLibertyPortfolioPerform];
END

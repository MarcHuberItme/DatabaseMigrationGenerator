--liquibase formatted sql

--changeset system:create-alter-procedure-GetClosedAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetClosedAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetClosedAccount
CREATE OR ALTER PROCEDURE dbo.GetClosedAccount
    @PortfolioId UniqueIdentifier

AS 

SELECT TOP 1 TerminationDate FROM PtAccountBase
WHERE PortfolioId = @PortfolioId
ORDER BY TerminationDate ASC


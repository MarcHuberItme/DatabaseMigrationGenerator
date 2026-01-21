--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorrItemInfoPortfolio context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorrItemInfoPortfolio,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorrItemInfoPortfolio
CREATE OR ALTER PROCEDURE dbo.GetCorrItemInfoPortfolio

@PortfolioId UniqueIdentifier,
@CorrItemId UniqueIdentifier AS

SELECT * FROM PtCorrPortfolioView 
WHERE PortfolioId = @PortfolioId AND CorrItemId = @CorrItemId

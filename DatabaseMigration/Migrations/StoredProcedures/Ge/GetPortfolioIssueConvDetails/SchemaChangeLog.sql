--liquibase formatted sql

--changeset system:create-alter-procedure-GetPortfolioIssueConvDetails context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPortfolioIssueConvDetails,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPortfolioIssueConvDetails
CREATE OR ALTER PROCEDURE dbo.GetPortfolioIssueConvDetails

@PortfolioConversionId uniqueidentifier

AS

SELECT Id, OpenIssueId
FROM PtPortfolioConversionDetail
WHERE PortfolioConversionId = @PortfolioConversionId 
AND OpenIssueId IS NOT NULL AND OpenIssueUpdated = 0
AND HdVersionNo BETWEEN 1 AND 999999998

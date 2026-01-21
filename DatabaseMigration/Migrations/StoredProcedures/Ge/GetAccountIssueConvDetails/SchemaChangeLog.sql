--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountIssueConvDetails context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountIssueConvDetails,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountIssueConvDetails
CREATE OR ALTER PROCEDURE dbo.GetAccountIssueConvDetails

@AccountConversionId uniqueidentifier

AS

SELECT Id, OpenIssueId
FROM PtAccountConversionDetail
WHERE AccountConversionId = @AccountConversionId
AND OpenIssueId IS NOT NULL AND OpenIssueUpdated = 0
AND HdVersionNo BETWEEN 1 AND 999999998

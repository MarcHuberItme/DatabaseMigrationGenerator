--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerOpenIssues context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerOpenIssues,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerOpenIssues
CREATE OR ALTER PROCEDURE dbo.GetPartnerOpenIssues
@PartnerId	 uniqueidentifier,
@OpenIssuesCount int OUTPUT

AS

Select @OpenIssuesCount = IsNull(Count(*),0)  From PtOpenIssue
Where PtOpenIssue.Alert = 1 and (PtOpenIssue.CompletionDate is NULL or PtOpenIssue.CompletionDate > GetDate())
and partnerID = @PartnerId and Statusno = 5
and PtOpenIssue.HdVersionNo between 1 and 999999998

--Print 'Open Issues = ' + str(@OpenIssuesCount)

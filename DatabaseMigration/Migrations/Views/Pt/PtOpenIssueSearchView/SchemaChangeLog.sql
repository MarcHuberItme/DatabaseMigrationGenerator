--liquibase formatted sql

--changeset system:create-alter-view-PtOpenIssueSearchView context:any labels:c-any,o-view,ot-schema,on-PtOpenIssueSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOpenIssueSearchView
CREATE OR ALTER VIEW dbo.PtOpenIssueSearchView AS
select
OI.Id as Id,
OI.AccountId as AccountId,
OI.ActivationDate as ActivationDate,
OI.TargetDate as TargetDate,
OI.CompletionDate as CompletionDate,
OI.Alert as IsPrioritized,
OI.ContactPersonId as ContactPersonId,
OI.PartnerId as PartnerId,
OI.PortfolioId as PortfolioId,
OI.TypeNo as TypeNo,
OI.StatusNo as StatusNo,
OI.Remark as Remark,
OI.RemarkDate1 as RemarkDate1,
OI.RemarkDate2 as RemarkDate2,
OI.RemarkDate3 as RemarkDate3,
OI.HdVersionNo as HdVersionNo,
U.FullName as InitiatorFullName,
U.Department as InitiatorDepartment,
U.PartnerId as InitiatorPartnerId,
U.UserName as InitiatorUsername,
U.Id as InitiatorId,
P.FirstName as PartnerFirstName,
P.Name as PartnerLastName,
P.MiddleName as PartnerMiddleName,
P.PartnerNo as PartnerNo,
PF.PortfolioNo as PortfolioNo,
case when OIT.EndStatusNo = OI.StatusNo then 1 else 0 end as IsCompleted
from PtOpenIssue OI
left join AsUser U on U.Id = OI.InitiatorId
left join PtBase P on P.Id = OI.PartnerId
left join PtOpenIssueType OIT on OIT.TypeNo = OI.TypeNo
left join PtPortfolio PF on PF.Id = OI.PortfolioId

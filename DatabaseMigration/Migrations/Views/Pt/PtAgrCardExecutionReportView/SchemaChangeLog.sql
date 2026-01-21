--liquibase formatted sql

--changeset system:create-alter-view-PtAgrCardExecutionReportView context:any labels:c-any,o-view,ot-schema,on-PtAgrCardExecutionReportView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrCardExecutionReportView
CREATE OR ALTER VIEW dbo.PtAgrCardExecutionReportView AS
select
	r.ExecType,
	r.ExecStatus,
	r.ErrorText,
	r.Reported,
	r.TaskId,
	r.Params,
	r.FullAddressDelivery,
	r.CountryCodeDelivery,
	a.AccountNo,
	a.AccountNoEdited,
	b.CardNo,
	b.CardType,
	tct.TextShort as TextShortCardType,
	tct.TextLong as TextLongCardType,
	c.SerialNo,
	cp.SerialNo as SerialNoPrev,
	cp.ExpirationDate as ExpirationDatePrev,
	ch.Id as CardholderId,
	ch.PartnerNo,
	ch.PartnerNoEdited,
	ch.Name,
	ch.MiddleName,
	ch.FirstName,
	ch.BranchNo,
	c.CardStatus,
	cp.CardStatus as CardStatusPrev,
	c.MailCode
from
	PtAgrCardExecutionReport r
	inner join PtAgrCard c on c.Id = r.CardId
	inner join PtAgrCardBase b on b.Id = c.CardId
	inner join PtAccountBase a on a.Id = b.AccountId
	inner join PtBase ch on ch.Id = b.PartnerId
	inner join PtCardType ct on ct.CardType = b.CardType
	left outer join AsText tct on tct.MasterTableName = 'PtCardType' and tct.MasterId = ct.Id and tct.LanguageNo = 2
	left outer join PtAgrCard cp on cp.Id = c.IdPrevious

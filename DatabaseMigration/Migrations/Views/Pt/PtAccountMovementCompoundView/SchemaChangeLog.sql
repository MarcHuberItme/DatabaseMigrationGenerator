--liquibase formatted sql

--changeset system:create-alter-view-PtAccountMovementCompoundView context:any labels:c-any,o-view,ot-schema,on-PtAccountMovementCompoundView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountMovementCompoundView
CREATE OR ALTER VIEW dbo.PtAccountMovementCompoundView AS
-- single booking and compound bookings (differenting with Type)
select
	i.Id,
	i.ValueDate,
	i.TransDateTime,
	tx.TextShort TransactionType,
	tx.LanguageNo,
	t.TextNo,
	i.TransText TransactionText,
	i.DebitAmount,
	i.CreditAmount,
	r.AccountId,
	pab.AccountNo,
	i.DetailCounter,
	i.TransDate,
	msg.CreditPaymentInformation,
	msg.DebitPaymentInformation,
                msg.DebitOrderingName,
	agrd.SalaryPaymentRestriction,
	agrd.BalanceRestriction,
	agrd.QueryRestriction,
	agrd.QueryDetailRestriction,
	agrd.HasAccess,
	agrd.InternetbankingAllowed,
	agrd.ValidFrom,
	agrd.ValidTo,
	Isnull(msg.SalaryFlag, 0) AS SalaryFlag,
	agrd.AgrEBankingId as eBankingId,
	i.PositionId,
	PtPaymentOrderDetail.PersonalNote,
	PtPaymentOrderDetail.OriginalSenderAddress,
	PtPaymentOrderDetail.OriginalSenderName,
	PtPaymentOrderDetail.OriginalSenderStreetName,
	PtPaymentOrderDetail.OriginalSenderBuildingNo,
	PtPaymentOrderDetail.OriginalSenderTownName,
	PtPaymentOrderDetail.OriginalSenderCountry
from
	PtTransItem i inner join
	PtPosition p on p.Id = i.PositionId and p.HdVersionNo between 1 and 999999998 inner join
	PrReference r on r.Id = p.ProdReferenceId and r.HdVersionNo between 1 and 999999998 inner join 
	PtAccountBase pab on pab.Id = r.AccountId and pab.HdVersionNo between 1 and 999999998 inner join
	PtTransItemText t on t.TextNo = i.TextNo and t.HdVersionNo between 1 and 999999998 left join
	AsText tx on tx.MasterId = t.Id and tx.MasterTableName = 'pttransitemtext' left join
	PtTransMessage msg ON  msg.Id = i.MessageId and msg.HdVersionNo between 1 and 999999998 inner join 
	PtAgrEbankingDetail agrd ON agrd.AccountId = pab.Id and agrd.HdVersionNo between 1 and 999999998 left join 
                PtPaymentOrderDetail on PtPaymentOrderDetail.Id = msg.SourceRecId and msg.SourceTableName = 'PtPaymentOrderDetail'
where 
                i.HdVersionNo between 1 and 999999998

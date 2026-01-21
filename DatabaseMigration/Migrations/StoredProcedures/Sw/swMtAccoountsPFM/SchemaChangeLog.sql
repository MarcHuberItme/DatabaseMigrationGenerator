--liquibase formatted sql

--changeset system:create-alter-procedure-swMtAccoountsPFM context:any labels:c-any,o-stored-procedure,ot-schema,on-swMtAccoountsPFM,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure swMtAccoountsPFM
CREATE OR ALTER PROCEDURE dbo.swMtAccoountsPFM
@SettingId uniqueidentifier, @PFMSeqNo int, @AccountNo decimal (11,0)
AS
Select MA.SWIFT_ADR
	, MA.AccountMessageNumber
	, MA.LastTransDate, MA.MessageType
	, REF.Currency, CB.MinorUnit
	, POS.ValueProductCurrency
	, MA.ID as MtAccountId
	, AB.AccountNo
                , AB.ID as AccountId
                , MA.IsToSendSummary
	, AGR.PFMSequenceNo
               , MA.DateFrom
               , MA.LastAdhocTransDateTime
From swMtAccount MA
	Inner Join ptAccountBase AB on AB.ID = MA.AccountId And MA.HdVersionNo<999999999
	Inner Join prReference REF on REF.AccountId = AB.Id 
	Inner Join ptPosition POS on POS.ProdReferenceId = REF.Id
	Inner Join CyBase CB On REF.Currency=CB.Symbol
	Inner join PtAgrEBankingDetail AGRD on MA.EbankingDetailId = AGRD.Id and AGRD.HdVersionNo between 1 and 999999998
	Inner join PtAgrEBAnking AGR on AGR.Id = AGRD.AgrEBankingId and AGR.HdVersionNo between 1 and 999999998
			and AGR.PFMSequenceNo is not null
			and AGR.PFMSequenceNo > 0
Where (DateTo is Null or DateTo >=  CONVERT(varchar(8), GetDate(), 112))
	AND DateFrom <  CONVERT(varchar(8), GetDate(), 112)
                AND SwSettingId = @SettingId
		And (AGR.PFMSequenceNo = @PFMSeqNo or @PFMSeqNo =0)
		And (AB.AccountNo = @AccountNo or @AccountNo =0)
	AND AGRD.ValidFrom < GetDate()
	AND AGRD.ValidTo > GetDate()
	AND AGRD.InternetBankingAllowed = 1 
	AND AGRD.HasAccess = 1
	AND AGRD.QueryRestriction = 0
	AND AGRD.QueryDetailRestriction = 0
	AND AGRD.BalanceRestriction = 0
	AND AGRD.SalaryPaymentRestriction = 0


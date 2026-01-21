--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderSingleOrderView context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderSingleOrderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderSingleOrderView
CREATE OR ALTER VIEW dbo.PtPaymentOrderSingleOrderView AS
SELECT
    OrderDetail.Id,
    OrderDetail.OrderId as PaymentOrderId,
    OrderDetail.HdCreateDate, -- Created at
    OrderDetail.HdChangeDate, -- Last modified (can be the job that modifies it)
    OrderDetail.HdVersionNo,
    DebtorAccountBase.AccountNoIbanElect as DebtorIban,
    DebtorAccountBase.Id as DebtorAccountId,
    DebtorAccountBase.PortfolioId as DebtorPortfolioId,
-- OrderDetail.AccountNo as InternalCreditorAccountNo,
    InternalCreditorAccountBase.AccountNoIbanElect as InternalCreditorIban,
    InternalCreditorAccountBase.QrIban as InternalCreditorQrIban,
    OrderDetail.AccountNoExt as ExternalCreditorAccountNo,
    OrderDetail.AccountNoExtIBAN as ExternalCreditorIban,
    OrderDetail.ESRParticipantNo,
    OrderDetail.PaymentAmount,
    OrderDetail.PaymentCurrency,
    OrderDetail.BeneficiaryName,
    OrderDetail.BeneficiaryStreetName,
    OrderDetail.BeneficiaryBuildingNo,
    OrderDetail.BeneficiaryPostCode,
    OrderDetail.BeneficiaryTownName,
    OrderDetail.BeneficiaryCountry,
    OrderDetail.OriginalSenderName,
    OrderDetail.OriginalSenderStreetName,
    OrderDetail.OriginalSenderBuildingNo,
    OrderDetail.OriginalSenderPostCode,
    OrderDetail.OriginalSenderTownName,
    OrderDetail.OriginalSenderCountry,
    OrderDetail.EndBeneficiaryName,
    OrderDetail.EndBeneficiaryStreetName,
    OrderDetail.EndBeneficiaryBuildingNo,
    OrderDetail.EndBeneficiaryPostCode,
    OrderDetail.EndBeneficiaryTownName,
    OrderDetail.EndBeneficiaryCountry,
    OrderDetail.InitiatingPartyId,
    OrderDetail.OrderingPartyReference, --EndToEndId
    PaymentOrder.ScheduledDate, -- Date when execution starts
    OrderDetail.NotificationCode, -- PurposeCode -> when = 1 then its SALA or PENS
    OrderDetail.BeneficiaryMessage, -- RemittanceInformation
    OrderDetail.ReferenceNo as QrOrEsrReferenceNo, -- QR Reference Number or ESR
    OrderDetail.StructuredCreditorReference as ScoReferenceNo, -- SCO Reference Number
    OrderDetail.SlipType, -- Not always filled
    OrderDetail.StandingOrderId,
    OrderDetail.AccountNoPost,
    OrderDetail.BeneficiaryBIC,
    OrderDetail.BeneficiaryFinalBIC,
    OrderDetail.ChargeOptionCode as ChargeBearerCode,
    OrderDetail.CustomerConfirmationPending as IsCustomerConfirmationPending,
    OrderDetail.SenderRemarks as DebtorRemark,
    PaymentOrder.HdVersionNo as PaymentOrderHdVersionNo,
    PaymentOrder.Status, -- 4 = Executed (Completed), 97 = Cancelled (IP) otherwise Pending
    PaymentOrder.EBankingId as CreatorAgreementId,
    PaymentOrder.EBankingIdVisum1 as AgreementIdThatApproved1,
    PaymentOrder.EBankingIdVisum2 as AgreementIdThatApproved2
from PtPaymentOrderDetail as OrderDetail
         inner join PtPaymentOrder as PaymentOrder on OrderDetail.OrderId = PaymentOrder.Id
         left join PtAccountBase as DebtorAccountBase on OrderDetail.SenderAccountNo = DebtorAccountBase.AccountNo
         left join PtAccountBase as InternalCreditorAccountBase on OrderDetail.AccountNo = InternalCreditorAccountBase.AccountNo

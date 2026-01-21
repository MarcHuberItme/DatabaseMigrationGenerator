--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderExecutedView context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderExecutedView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderExecutedView
CREATE OR ALTER VIEW dbo.PtPaymentOrderExecutedView AS
SELECT PtPaymentOrderDetail.Id,
                                 AgrEBankingDetail.AgrEBankingId,
                                 PtPaymentOrderDetail.EBankingTemplate,
                                 PtPaymentOrderDetail.NotificationCode,
                                 PtPaymentOrderDetail.EndBeneficiaryAddress,
                                 PtPaymentOrderDetail.BeneficiaryAddress,
                                 PtPaymentOrderDetail.SequenceNo,
                                 PtPaymentOrderDetail.PaymentCurrency,
                                 PtPaymentOrderDetail.PaymentAmount,
                                 PtPaymentOrderDetail.IsLockedForCustomer,
                                 PtPaymentOrderDetail.BCNrBenBank,
                                 PtPaymentOrderDetail.RejectFlag,
                                 PtPaymentOrderDetail.HdCreateDate,
                                 PtPaymentOrderDetail.HdChangeDate,
                                 PtPaymentOrderDetail.BeneficiaryMessage,
                                 PtPaymentOrderDetail.AccountNoPost,
                                 PtPaymentOrderDetail.ReferenceNo,
                                 PtPaymentOrder.SenderAccountNo,
                                 PtPaymentOrder.ScheduledDate,
                                 PtPaymentOrder.Status,
                                 PtPaymentOrder.FileImportProcessId,
                                 PtPaymentOrder.OrderNo,
                                 PtPaymentOrder.OrderType,
                                 PtAccountBase.AccountNoIbanElect,
                                 PtPaymentOrderDetail.ESRParticipantNo,
                                 PtPaymentOrderDetail.AccountNoExtIBAN,
                                 PtPaymentOrderDetail.AccountNoExt,
                                 PtPaymentOrderDetail.AccountNo,
                                 CASE
                                   WHEN ( PtPaymentOrderDetail.SlipType IS
                                          NULL )
                                        AND (
                                   PtPaymentOrderDetail.ReferenceNo IS
                                   NOT NULL ) THEN 1
                                   ELSE PtPaymentOrderDetail.SlipType
                                 END                                  AS
                                 SlipType,
                                 PtPaymentOrderDetail.BeneficiaryName,
                                 PtPaymentOrderDetail.BeneficiaryStreetName,
                                 PtPaymentOrderDetail.BeneficiaryBuildingNo,
                                 PtPaymentOrderDetail.BeneficiaryTownName,
                                 PtPaymentOrderDetail.BeneficiaryPostCode,
                                 PtPaymentOrderDetail.BeneficiaryCountry,
                                 PtPaymentOrderDetail.OriginalSenderAddress,
                                 PtPaymentOrderDetail.PersonalNote,
                                 PtAccountBase.Id                 AS
                                         DebitAccountId,
                                 PtAccountBase.AccountNoIbanElect AS
                                         DebitAccountNo,
                                 PtPaymentOrder.Id                AS
                                 OrderId,
                                 PtPaymentOrder.EBankingId,
                                 PtPaymentOrder.EBankingIdVisum1,
                                 PtPaymentOrder.EBankingIdVisum2,
								 case when PtPaymentOrderDetail.StandingOrderId is null then 0 else 1 end as IsStandingOrder,							 AgrEbankingDetail.AccountId,
								 PtPaymentOrder.TotalReportedAmount,
								 PtPaymentOrder.TotalReportedTransactions, 
								 PAE.MgVTNo as MgVTNoCreator,
								 PAEApproval.MgVTNo as MgVTNoApproval
        FROM   PtAgrEBankingDetail AS AgrEBankingDetail
               INNER JOIN PtAccountBase
                       ON ( PtAccountBase.Id =
                            AgrEBankingDetail.AccountId )
                          AND ( AgrEBankingDetail.AgrEBankingId =
                              AgrEBankingDetail.AgrEBankingId )
                          AND ( PtAccountBase.HdVersionNo BETWEEN 1 AND
                                999999998 )
               INNER JOIN PtPaymentOrder
                       ON ( PtPaymentOrder.SenderAccountNo =
                            PtAccountBase.AccountNo )
                          AND status = 4
                          AND ( PtPaymentOrder.HdVersionNo BETWEEN 1 AND
                                999999998
                              )
               INNER JOIN PtPaymentOrderDetail
                       ON PtPaymentOrderDetail.OrderId = PtPaymentOrder.Id
                          AND
                          ( PtPaymentOrderDetail.HdVersionNo BETWEEN 1 AND
                            999999998
                          )
                          AND ( ( AgrEBankingDetail.SalaryPaymentRestriction
                                  = 0 )
                                 OR ( (
                              AgrEBankingDetail.SalaryPaymentRestriction
                              =
                              1 )
                                      AND ( (
                                    PtPaymentOrderDetail.NotificationCode
                                    <> 1 )
                                             OR (
                                      PtPaymentOrderDetail.NotificationCode
                                      IS
                                      NULL ) ) )
                              )
			left JOIN PtAgrEBanking as PAEApproval on PtPaymentOrder.EBankingIdVisum1 = PAEApproval.Id and PAEApproval.HdVersionNo BETWEEN 1 AND 999999998
			left JOIN PtAgrEBanking as PAE on PtPaymentOrder.EBankingId = PAE.Id and PAE.HdVersionNo BETWEEN 1 AND 999999998
               WHERE ( AgrEBankingDetail.HdVersionNo BETWEEN 1 AND 999999998 ) and AgrEBankingDetail.OrderRestriction = 0

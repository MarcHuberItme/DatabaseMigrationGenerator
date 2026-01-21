--liquibase formatted sql

--changeset system:create-alter-view-PtPaymentOrderPendingView context:any labels:c-any,o-view,ot-schema,on-PtPaymentOrderPendingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaymentOrderPendingView
CREATE OR ALTER VIEW dbo.PtPaymentOrderPendingView AS
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
		0 as IsStandingOrder,
		null as BalanceLimit,
		null as PaymentAmountMin,
		null as TransTypeOrig,
		0 as FullPayment,
		0 as UsageNo,
		AgrEbankingDetail.AccountId,
		AgrEBankingDetail.OrderRestriction,
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
               WHERE ( AgrEBankingDetail.HdVersionNo BETWEEN 1 AND 999999998 )
			   and AgrEBankingDetail.OrderRestriction = 0 and PtPaymentOrderDetail.CustomerConfirmationPending = 0
        UNION ALL

        SELECT PtStandingOrder.Id,
               AgrEBankingDetail.AgrEBankingId,
               0 AS EBankingTemplate,
               NULL AS NotificationCode,
               NULL AS EndBeneficiaryAddress,
               CASE
                 WHEN AsPayee.Beneficary is null 
                  THEN (
                   CASE 
                    WHEN ([PtStandingOrder].[RejectFlag] IS NULL) OR ([PtStandingOrder].[RejectedEbankingAddress] IS NULL) 
                      THEN PtAddress.FullAddress 
                      ELSE [PtStandingOrder].[RejectedEbankingAddress] 
                   END ) 
                   ELSE AsPayee.Beneficary end AS BeneficiaryAddress,
               NULL  AS SequenceNo,
               PtStandingOrder.PaymentCurrency,
               IsNull(PtStandingOrder.PaymentAmount, PtStandingOrderPreDefAmount.PaymentAmount) AS PaymentAmount,
               NULL AS IsLockedForCustomer,
               NULL AS BCNrBenBank,
               PtStandingOrder.RejectFlag,
               PtStandingOrder.HdCreateDate,
               PtStandingOrder.HdChangeDate,
               PtStandingOrder.PaymentInformation AS BeneficiaryMessage,
               NULL  AS AccountNoPost,
               PtStandingOrder.ReferenceNo,
               PtAccountBase.AccountNo AS SenderAccountNo,
               PtStandingOrder.NextSelectionDate AS ScheduleDate,
               1  AS Status,
               NULL AS FileImportProcessId,
               PtStandingOrder.OrderNo,
               CAST(Par.Value AS tinyint) AS OrderType,
               PtAccountBase.AccountNoIbanElect,
               CASE WHEN (PtStandingOrder.PayeeId IS NOT NULL) THEN AsPayee.PCNo else null END AS ESRParticipantNo,
               null AS AccountNo, 
               CASE
                 WHEN PtStandingOrder.PayeeId is not null 
                  THEN AsPayee.AccountNoExt 
                  ELSE pab.AccountNoIbanElect 
                 END AS AccountNoExtIBAN,
               null AS AccountNoExt, 
               null AS SlipType,
               AsPayee.BeneficiaryName,
               AsPayee.BeneficiaryStreetName,
               AsPayee.BeneficiaryBuildingNo,
               AsPayee.BeneficiaryTownName,
               AsPayee.BeneficiaryPostCode,
               AsPayee.BeneficiaryCountry,
               NULL AS OriginalSenderAddress,
               PtStandingOrder.PersonalNote,
               PtAccountBase.Id  AS DebitAccountId,
               PtAccountBase.AccountNoIbanElect AS DebitAccountNo,
               PtStandingOrder.Id  AS OrderId,
               PtStandingOrder.EBankingId,
               PtStandingOrder.EBankingIdVisum1,
               PtStandingOrder.EBankingIdVisum2,
               1 as IsStandingOrder,
               PtStandingOrder.BalanceLimit,
               PtStandingOrder.PaymentAmountMin,
               PtStandingOrder.TransTypeOrig,
               PtStandingOrder.FullPayment,
               PtStandingOrder.UsageNo,
               AgrEbankingDetail.AccountId,
               AgrEBankingDetail.OrderRestriction,
               IsNull(PtStandingOrder.PaymentAmount, IsNull(PtStandingOrderPreDefAmount.PaymentAmount, 0)) as TotalReportedAmount,
               1 as TotalReportedTransactions,
               null as MgVTNoCreator,
               null as MgVTNoApproval

        FROM   PtAgrEBankingDetail AS AgrEBankingDetail
               INNER JOIN PtAccountBase
                       ON PtAccountBase.Id = AgrEBankingDetail.AccountId
                          AND PtAccountBase.HdVersionNo BETWEEN 1 AND
                              999999998
               INNER JOIN PtStandingOrder
                       ON PtStandingOrder.AccountId = PtAccountBase.Id
                          AND ( PtStandingOrder.HdVersionNo BETWEEN 1 AND
                                999999998) and PtStandingOrder.NextSelectionDate < Convert(datetime, '9999-12-31' ) AND ( ( AgrEBankingDetail.SalaryPaymentRestriction
                                  = 0 )
                                 OR ( (
                              AgrEBankingDetail.SalaryPaymentRestriction
                              =
                              1 )
                                      AND ( (
                                    PtStandingOrder.SalaryFlag
                                    <> 1 )
                                             OR (
                                      PtStandingOrder.SalaryFlag
                                      IS
                                      NULL ) ) )
                              )
               INNER JOIN AsParameterGroup as ParGr ON ParGr.GroupName = 'StandingOrder'
               INNER JOIN AsParameter as Par ON ParGr.Id = Par.ParamGroupId AND Par.Name = 'OrderTypeNo' AND ISNUMERIC(Par.Value) = 1
               LEFT JOIN AsPayee
                       ON AsPayee.Id = PtStandingOrder.payeeId
                          AND ( AsPayee.HdVersionNo BETWEEN 1 AND 999999998 )
			   LEFT OUTER JOIN [PtPortfolio] ON ([PtPortfolio].[Id] = [PtAccountBase].[PortfolioId]) and (PtPortfolio.HdVersionNo BETWEEN 1 AND
                                999999998)
			   left join PrReference on PrReference.Id = PtStandingOrder.CreditReferenceId and PrReference.HdVersionNo BETWEEN 1 AND
                                999999998
				left join PtAccountBase pab on pab.Id = PrReference.AccountId and pab.HdVersionNo BETWEEN 1 AND
                                999999998
				left join PtPortfolio ppf on ppf.Id = pab.PortfolioId and ppf.HdVersionNo BETWEEN 1 AND
                                999999998
				LEFT OUTER JOIN [PtAddress] ON ([PtAddress].[PartnerId] = ppf.[PartnerId]) AND (([PtAddress].[AddressTypeNo] = 11) OR ([PtAddress].[AddressTypeNo] IS NULL)) AND PtAddress.HdVersionNo BETWEEN 1 AND
                                999999998 
               LEFT JOIN (SELECT TOP(1) * FROM PtStandingOrderPreDefAmount WHERE PtStandingOrderPreDefAmount.HdVersionNo BETWEEN 1 AND 999999998 ORDER BY PtStandingOrderPreDefAmount.ValidFrom DESC) PtStandingOrderPreDefAmount ON PtStandingOrderPreDefAmount.PreDefTypeNo = PtStandingOrder.PreDefTypeNo
WHERE AgrEBankingDetail.HdVersionNo BETWEEN 1 AND 999999998 and AgrEBankingDetail.OrderRestriction = 0 

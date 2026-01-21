--liquibase formatted sql

--changeset system:create-alter-view-CMPaymentSubmissionStatusView context:any labels:c-any,o-view,ot-schema,on-CMPaymentSubmissionStatusView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CMPaymentSubmissionStatusView
CREATE OR ALTER VIEW dbo.CMPaymentSubmissionStatusView AS
SELECT fileImportProcess.Id                                    AS PaymentSubmissionId,
       fileImportProcess.HdCreateDate                          AS CreateDate,
       fileImportProcess.HdChangeDate                          AS ChangeDate,
       painStatus.Status                                       AS PaymentSubmissionStatus,
       fileImportProcess.MessageId,
       importError.Code                                        AS ReasonCode,
       IIF(importError.Id IS NOT NULL, 'RJCT', 'UKWN')        AS InstructionItemStatus,
       importError.AdditionalInformation                       AS ReasonInformation,
       importError.InstructionId,
       fileConfirmation.AccountId                              AS DebtorAccountId,
       fileConfirmation.EbankingIdVisum1                       AS ApprovingAgreementId1,
       fileConfirmation.EbankingIdVisum2                       AS ApprovingAgreementId2
FROM CMFileImportProcess fileImportProcess
         LEFT JOIN CMPainImportStatus painStatus ON fileImportProcess.Id = painStatus.FileImportProcessId
    AND painStatus.HdVersionNo != '999999999'
         LEFT JOIN CMFileConfirmation fileConfirmation ON fileImportProcess.Id = fileConfirmation.FileImportProcessId
    AND fileConfirmation.HdVersionNo != '999999999'
         LEFT JOIN CMFileImportError importError ON fileImportProcess.Id = importError.FileImportProcessId
    AND importError.HdVersionNo != '999999999'
WHERE fileImportProcess.HdVersionNo != '999999999';


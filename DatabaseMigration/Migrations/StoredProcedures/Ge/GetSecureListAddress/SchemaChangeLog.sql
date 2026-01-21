--liquibase formatted sql

--changeset system:create-alter-procedure-GetSecureListAddress context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSecureListAddress,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSecureListAddress
CREATE OR ALTER PROCEDURE dbo.GetSecureListAddress
   @SecureListId UNIQUEIDENTIFIER,
   @CorrItemId UNIQUEIDENTIFIER
AS


SELECT Top 1 * 
FROM
(
SELECT PtAgrSecureList.SeqNo, PtAgrSecureList.VersionNo,PtAgrSecureList.PrevEbankingNo,
       PtAgrSecureList.AstUserId, PtAgrSecureList.AstActivationCode, PtAgrSecureList.AstCodeValidity, PtAgrSecureList.AstActivationImage,
              PtBase.PartnerNo, 
              PtAddress.AddressTypeNo, PtAddress.FullAddress, PtAddress.FormalAddress, 
              PtAddress.ReportAdrLine, PtAddress.ReducedAddress, PtAddress.SignatureLine,
              PtCorrPartnerView.CopyNumber, 1 AS Orderfield
FROM   PtAgrSecureList
           JOIN PtBase ON PtBase.Id = PtAgrSecureList.PartnerId
           JOIN PtCorrPartnerView ON PtCorrPartnerView.PartnerId = PtBase.Id
           JOIN PtAddress on PtAddress.Id = PtCorrPartnerView.AddressId
WHERE  PtAgrSecureList.Id  = @SecureListId
AND    PtAddress.Undeliverable = 0 
AND    PtBase.TerminationDate Is Null
AND    PtCorrPartnerView.CorrItemId = @CorrItemId
AND    PtCorrPartnerView.CopyNumber > 0 
AND   (PtAddress.HdVersionNo  BETWEEN 1 AND 999999998)

UNION ALL

SELECT PtAgrSecureList.SeqNo, PtAgrSecureList.VersionNo,PtAgrSecureList.PrevEbankingNo,
       PtAgrSecureList.AstUserId, PtAgrSecureList.AstActivationCode, PtAgrSecureList.AstCodeValidity, PtAgrSecureList.AstActivationImage,
       PtBase.PartnerNo, 
       PtAddress.AddressTypeNo, PtAddress.FullAddress, PtAddress.FormalAddress, 
       PtAddress.ReportAdrLine, PtAddress.ReducedAddress, PtAddress.SignatureLine,
       1 AS CopyNumber, 2 AS Orderfield
FROM   PtAgrSecureList
       JOIN PtBase ON PtBase.Id = PtAgrSecureList.PartnerId
       JOIN PtAddress on PtAddress.PartnerId = PtBase.Id
WHERE  PtAgrSecureList.Id  = @SecureListId
AND    PtBase.TerminationDate Is Null
AND    PtAddress.Undeliverable = 0 
AND    PtAddress.AddressTypeNo = 11
AND   (PtAddress.HdVersionNo  BETWEEN 1 AND 999999998)
) As Receiver
ORDER By Orderfield, AddressTypeNo

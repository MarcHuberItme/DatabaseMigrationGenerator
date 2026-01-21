--liquibase formatted sql

--changeset system:create-alter-procedure-IsPortfolioTerminationAllowed context:any labels:c-any,o-stored-procedure,ot-schema,on-IsPortfolioTerminationAllowed,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsPortfolioTerminationAllowed
CREATE OR ALTER PROCEDURE dbo.IsPortfolioTerminationAllowed
@PortfolioNo decimal(11,0)
AS

SELECT TOP 500
  
'CHECK' = (
  
CASE
WHEN (  A.partner_isShareholder = 'true'
        AND A.depotBankIsHBL = 'false'
        )
THEN 'Saldierung OK'
  
  
WHEN (  A.partner_isShareholder = 'true'
        AND A.depotBankIsHBL = 'true'
        AND A.portfolio_hasBookings = 'false'
        )
THEN 'Saldierung OK'
  
  
WHEN (  A.partner_isShareholder = 'true'
        AND A.depotBankIsHBL = 'true'
        AND A.portfolio_hasBookings = 'true'
        AND A.portfolio_debitCreditIsNull = 'true'
        )
THEN 'Saldierung OK'
  
  
WHEN (  A.partner_isShareholder = 'true'
        AND A.depotBankIsHBL = 'true'
        AND A.portfolio_hasBookings = 'true'
        AND A.portfolio_debitCreditIsNull = 'false'
        )
THEN 'Sperrung mit Fehlermeldung'
  
  
WHEN (  A.partner_isShareholder = 'false'
        AND A.portfolio_isFormerSH = 'false'
        )
THEN 'Saldierung OK'
  
  
WHEN (  A.partner_isShareholder = 'false'
        AND A.portfolio_isFormerSH = 'true'
        AND A.portfolio_hasTransferred = 'false'
        )
THEN 'Saldierung OK'
  
  
WHEN (  A.partner_isShareholder = 'false'
        AND A.portfolio_isFormerSH = 'true'
        AND A.portfolio_hasTransferred = 'true'
        AND A.portfolio_rightsTransferZero = 'true'
        )
THEN 'Saldierung OK'
  
  
WHEN (  A.partner_isShareholder = 'false'
        AND A.portfolio_isFormerSH = 'true'
        AND A.portfolio_hasTransferred = 'true'
        AND A.portfolio_rightsTransferZero = 'false'
        )
THEN 'Sperrung mit Fehlermeldung'
  
  
ELSE 'unknown'
END),
A.*
  
  
FROM
   
(
   
SELECT DISTINCT
PP.PortfolioTypeNo AS 'portfolioType_no',
PP.PortfolioNo AS 'portfolio_no_numeric',
PP.PortfolioNoEdited AS 'portfolio_no_formatted',
'partner_isShareholder' = (
CASE
WHEN (PSH.Id IS NOT NULL AND PSH.RemoveDate IS NOT NULL)
THEN 'false'
WHEN (PSH.Id IS NOT NULL AND PSH.RemoveDate IS NULL)
THEN 'true'
ELSE 'false'
END),
PB.PartnerNoEdited AS 'shareholder_partner_no_formatted',
PDV.PtDescription AS 'shareholder_description',
'depotBankIsHBL' = (
CASE
WHEN PSH.DepotbankID = '{A0B962C6-2FCC-4490-AE31-598220EF6D08}' -- HBL
THEN 'true'
ELSE 'false'
END),
PDVDepotBank.PtDescription AS 'depotBank_description',
   
PSH.RemainingQuantity,
   
'portfolio_hasBookings' = (
CASE
WHEN PHB.portfolioHasBookings = 'true'
THEN 'true'
ELSE 'false'
END),
   
'portfolio_debitCreditIsNull' = (
CASE
WHEN PSHBooking.RegisteredShares = 0
THEN 'true'
ELSE 'false'
END),
   
'portfolio_hasTransferred' = (
CASE
WHEN PSH.TransferredQuantity <> 0
THEN 'true'
ELSE 'false'
END),
   
'portfolio_rightsTransferZero' = (
CASE
WHEN PRTZ.portfolio_rightsTransferZero = 'true'
THEN 'true'
ELSE 'false'
END),
  
'portfolio_isFormerSH' = (
CASE
WHEN PSH.RemoveDate IS NOT NULL
THEN 'true'
ELSE 'false'
END)
   
FROM PtPortfolio PP
JOIN PtBase PB ON PB.Id = PP.PartnerId
JOIN PtDescriptionView PDV ON PDV.Id = PB.Id
LEFT JOIN PtShareholder PSH ON PSH.PartnerId = PB.Id
LEFT JOIN PtDescriptionView PDVDepotBank ON PDVDepotBank.Id = PSH.DepotbankID
LEFT JOIN PtSHRegBookingView PSHBooking ON PSHBooking.ShareholderID = PB.Id
AND PSHBooking.PortfolioID = PP.Id
   
LEFT JOIN   (
            SELECT DISTINCT
            PSHV.ID AS 'id',
            'portfolioHasBookings' = 'true'
            FROM PtSHRegBookingView PSHV
            WHERE 1=1
            ) PHB ON PHB.id = PSHBooking.ID
   
LEFT JOIN   (
            SELECT
            PSHV.ID AS 'id',
            'portfolio_rightsTransferDebitSum' = (
            CASE
            WHEN PSHV.DeliveryType = 'RIGHT'
            THEN SUM(PSHV.Debit)
            ELSE NULL
            END),
            'portfolio_rightsTransferCreditSum' = (
            CASE
            WHEN PSHV.DeliveryType = 'RIGHT'
            THEN SUM(PSHV.Credit)
            ELSE NULL
            END),
            'portfolio_rightsTransferZero' = (
            CASE
            WHEN PSHV.DeliveryType = 'RIGHT' AND (SUM(PSHV.Debit) = SUM(PSHV.Credit))
            THEN 'true'
            ELSE 'false'
            END)
            FROM PtSHRegBookingView PSHV
            WHERE 1=1
                AND PSHV.DeliveryType = 'RIGHT'
                GROUP BY PSHV.ID, PSHV.DeliveryType
            ) PRTZ ON PRTZ.id = PSHBooking.ID
   
   
WHERE 1=1
AND PP.TerminationDate IS NULL
AND PP.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY
    PRTZ.portfolio_rightsTransferZero,
    PP.PortfolioTypeNo,
    PP.PortfolioNo,
    PP.PortfolioNoEdited,
    PSH.Id,
    PB.PartnerNoEdited,
    PDV.PtDescription,
    PSH.DepotbankID,
    PDVDepotBank.PtDescription,
    PSH.TransferredQuantity,
    PSH.RemainingQuantity,
    PHB.portfolioHasBookings,
    PSHBooking.RegisteredShares,
    PSHBooking.DeliveryType,
    PSH.RemoveDate
   
) A
   
WHERE 1=1
AND A.portfolio_no_numeric = @portfolioNo

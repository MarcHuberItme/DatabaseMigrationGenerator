--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerTmeRNbrTransInPeriod context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerTmeRNbrTransInPeriod,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerTmeRNbrTransInPeriod
CREATE OR ALTER PROCEDURE dbo.GetPartnerTmeRNbrTransInPeriod
@DateFrom DateTime,
@DateTo DateTime,
@MinTotalAmount decimal(12,0),
@MinNbrTransactions int

As

SELECT Max(A.PaymentDate) as PaymentDate,
       Count(A.PaymentAmount) as NbrTransactions,
	   A.PaymentCurrency as Currency,
       Sum(A.PaymentAmountCHF) as TotalAmount,
	   A.PartnerNo
FROM
(
--Details Eingänge
SELECT msg.PaymentDate,
	   msg.PaymentCurrency,
       msg.PaymentAmount,
       msg.PaymentAmount * IsNull(msg.CreditRate, 1) as PaymentAmountCHF,
	   pbc.PartnerNo
FROM PtTransMessage msg
LEFT JOIN PtPortfolio ppc on ppc.Id = msg.CreditPortfolioId
LEFT JOIN PtBase pbc on pbc.Id = ppc.PartnerId
JOIN PtAddress ad on ad.PartnerId = pbc.Id and ad.AddressTypeNo = 11
LEFT JOIN PtPortfolio ppd on ppd.Id = msg.DebitPortfolioId
LEFT JOIN PtBase pbd on pbd.Id = ppd.PartnerId
WHERE 1=1
AND pbc.Servicelevelno not in (10,15,32)  --ohne techn.Partner, VDF, Banken
AND pbc.PartnerNo <> pbd.PartnerNo        --Überträge / Umbuchungen auf dem gleichen Partner werden ausgeschlossen 

Union All        
--Details Ausgänge
SELECT msg.PaymentDate,
	   msg.PaymentCurrency,
       msg.PaymentAmount,
       msg.PaymentAmount * IsNull(msg.DebitRate, 1) as PaymentAmountCHF,
	   pbc.PartnerNo
FROM PtTransMessage msg
LEFT JOIN PtPortfolio ppc on ppc.Id = msg.DebitPortfolioId
LEFT JOIN PtBase pbc on pbc.Id = ppc.PartnerId
JOIN PtAddress ad on ad.PartnerId = pbc.Id and ad.AddressTypeNo = 11
LEFT JOIN PtPortfolio ppd on ppd.Id = msg.CreditPortfolioId
LEFT JOIN PtBase pbd on pbd.Id = ppd.PartnerId
WHERE 1=1
AND pbc.Servicelevelno not in (10,15,32)  --ohne techn.Partner, VDF, Banken
AND pbc.PartnerNo <> pbd.PartnerNo        --Überträge / Umbuchungen auf dem gleichen Partner werden ausgeschlossen 
)A
WHERE 1=1
AND A.PaymentDate Between @DateFrom And @DateTo
GROUP BY A.PartnerNo, A.PaymentDate, A.PaymentCurrency
HAVING SUM(A.PaymentAmount) >= @MinTotalAmount and Count(A.PaymentAmount) > @MinNbrTransactions


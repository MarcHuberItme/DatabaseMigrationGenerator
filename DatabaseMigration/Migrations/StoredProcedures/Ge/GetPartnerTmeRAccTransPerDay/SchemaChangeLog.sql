--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerTmeRAccTransPerDay context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerTmeRAccTransPerDay,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerTmeRAccTransPerDay
CREATE OR ALTER PROCEDURE dbo.GetPartnerTmeRAccTransPerDay
@DateFrom DateTime,
@DateTo DateTime,
@MinTotalAmount decimal(12,0),
@MinNbrTransactions int

As

SELECT msg.PaymentDate as PaymentDate,
       Count(msg.Id) as NbrTransactions,
	   msg.PaymentCurrency as Currency,
       Sum(msg.PaymentAmount * IsNull(msg.CreditRate, 1)) as TotalAmount,
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
AND msg.PaymentDate >= @DateFrom  AND msg.PaymentDate <= @DateTo
GROUP BY msg.PaymentDate, msg.PaymentCurrency, pbc.PartnerNo
HAVING Sum(msg.PaymentAmount) >= @MinTotalAmount and Count(msg.Id) > @MinNbrTransactions


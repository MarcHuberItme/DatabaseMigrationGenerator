--liquibase formatted sql

--changeset system:create-alter-view-PtAccountPaybackLogView context:any labels:c-any,o-view,ot-schema,on-PtAccountPaybackLogView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountPaybackLogView
CREATE OR ALTER VIEW dbo.PtAccountPaybackLogView AS
SELECT

A.AccountNo, 
R.Currency,
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName,
L.Id,
L.MatureDate,
L.AccountPaybackId,
L.DebitAccountNo,
L.InvoiceAmount,
B.Id AS PartnerId,
P.PeriodRuleNo,
1 AS HdVersionNo, 
0 AS HdPendingChanges,
0 AS HdPendingSubChanges,
SUM(ISNULL(C.ReducedAmount,0)) AS TotalReducedAmount

FROM PtAccountPaybackLog AS L
INNER JOIN PtAccountPayback AS P ON L.AccountPaybackId = P.Id
INNER JOIN PtAccountBase AS A ON A.Id = P.AccountBaseId
INNER JOIN PrReference AS R ON R.AccountId = A.Id
INNER JOIN PtPortfolio AS D ON D.Id = A.PortfolioId
INNER JOIN PtBase AS B ON B.Id = D.PartnerId
LEFT OUTER JOIN PtAccountPaybackLogComp AS C ON C.PaybackLogId = L.Id 

GROUP BY A.AccountNo, R.Currency, B.Id, B.Name, B.NameCont, B.FirstName, P.PeriodRuleNo, L.Id, 
L.MatureDate, L.AccountPaybackId, L.DebitAccountNo, L.InvoiceAmount

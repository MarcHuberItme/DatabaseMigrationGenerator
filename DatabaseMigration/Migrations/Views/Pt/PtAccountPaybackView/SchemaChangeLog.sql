--liquibase formatted sql

--changeset system:create-alter-view-PtAccountPaybackView context:any labels:c-any,o-view,ot-schema,on-PtAccountPaybackView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountPaybackView
CREATE OR ALTER VIEW dbo.PtAccountPaybackView AS

SELECT TOP 100 PERCENT 
P.* ,
A.AccountNo, 
A.CustomerReference,
D.PortfolioNo,
D.Id AS PortfolioId,
R.Id AS ReferenceId, 
R.Currency,
Pos.Id AS PositionId,
B.Id AS PartnerId, 
B.Name + IsNull(B.NameCont,'') + ' ' + IsNull(B.FirstName,'') As PartnerName,  
Adr.AdviceAdrLine,
IsNULL(R1.PayeeAccountId,R2.PayeeAccountId) As PayeeAccountId, 
Pr.DebitInstallment,
Pr.IsMoneyMarket

FROM PtAccountPayBack AS P
INNER JOIN PtAccountBase AS A 
	ON A.Id = P.AccountBaseId
INNER JOIN PtPortfolio AS D 
	ON D.Id = A.PortfolioId
INNER JOIN PtBase AS B 
	ON B.Id = D.PartnerId
INNER JOIN PrReference AS R 
	ON R.AccountId = A.Id
INNER JOIN PrPrivate AS Pr 
	ON Pr.ProductId = R.ProductId
INNER JOIN PtAddress AS Adr
	ON Adr.PartnerId = B.Id AND Adr.AddressTypeNo = 11
LEFT OUTER JOIN PtPosition AS Pos
	ON R.Id = Pos.ProdReferenceId
LEFT OUTER JOIN PtAccountComponent AS C 
	ON P.AccountComponentId = C.Id
LEFT OUTER JOIN PrPrivateCompType AS T 
	ON C.PrivateCompTypeId = T.Id
LEFT OUTER JOIN PtAccountPaymentRule AS R1 
	ON A.Id = R1.AccountBaseId AND R1.PaymentTypeNo = 4 AND R1.HdVersionNo BETWEEN 1 AND 999999998 AND R1.PayeeAccountId IS NOT NULL 
LEFT OUTER JOIN PtAccountPaymentRule AS R2 
	ON A.Id = R2.AccountBaseId AND R2.PaymentTypeNo = 0 AND R2.HdVersionNo BETWEEN 1 AND 999999998 AND R2.PayeeAccountId IS NOT NULL 
WHERE P.HdVersionNo BETWEEN 1 AND 999999998
AND ISNULL (P.PaybackTypeNo,10) In (10,50)
AND A.HdVersionNo BETWEEN 1 AND 999999998
AND A.TerminationDate IS NULL
AND P.Installment > 0
AND P.DueAmount > 0
AND (P.AccountComponentId IS NULL OR (	C.IsOldComponent = 0 
					AND C.HdVersionNo BETWEEN 1 AND 999999998 
					AND T.IsDebit = 1 
					AND T.IsLimitRelevant = 1)
	)

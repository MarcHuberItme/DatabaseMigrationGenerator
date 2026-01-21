--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAnnuityView context:any labels:c-any,o-view,ot-schema,on-PtAccountAnnuityView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAnnuityView
CREATE OR ALTER VIEW dbo.PtAccountAnnuityView AS
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
WHERE P.HdVersionNo BETWEEN 1 AND 999999998
AND ISNULL (P.PaybackTypeNo,50) = 10
AND P.IsAnnu = 1
AND A.HdVersionNo BETWEEN 1 AND 999999998
AND A.TerminationDate IS NULL
AND P.Installment > 0
AND P.DueAmount > 0
AND (P.AccountComponentId IS NULL OR (	C.IsOldComponent = 0 
					AND C.HdVersionNo BETWEEN 1 AND 999999998 
					AND T.IsDebit = 1 
					AND T.IsLimitRelevant = 1)
	)

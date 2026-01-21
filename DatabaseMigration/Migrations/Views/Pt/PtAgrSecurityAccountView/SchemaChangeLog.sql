--liquibase formatted sql

--changeset system:create-alter-view-PtAgrSecurityAccountView context:any labels:c-any,o-view,ot-schema,on-PtAgrSecurityAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrSecurityAccountView
CREATE OR ALTER VIEW dbo.PtAgrSecurityAccountView AS

SELECT TOP 100 PERCENT
Cs.AgrSecurityId,
ISNULL(FirstName + ' ','') + ISNULL(B.Name,'') 
+ ISNULL(B.NameCont,'') + ISNULL(', ' + Adr.Town,'') AS Partner ,
A.AccountNoEdited +  ISNULL(' ' + Tex.TextShort,'') + ISNULL(' - ' + A.CustomerReference,'') Account, A.AccountNo,
A.AccountNoEdited, 
Tex.LanguageNo
FROM PtAccountCompSecurity AS Cs 
INNER JOIN PtAccountComponent  AS Comp ON Cs.AccountCompId = Comp.Id
INNER JOIN PtAccountBase       AS A    ON Comp.AccountBaseId = A.Id
INNER JOIN PtPortfolio         AS P    ON A.PortfolioId = P.Id
INNER JOIN PtBase              AS B    ON P.PartnerId = B.Id
INNER JOIN PrReference AS Ref ON Ref.AccountId = A.Id
INNER JOIN PrPrivate AS Prod ON Prod.ProductId = Ref.ProductId
LEFT OUTER JOIN AsText AS Tex ON Prod.Id = Tex.MasterId
LEFT OUTER JOIN PtAddress      AS Adr  ON B.Id = Adr.PartnerId AND Adr.AddressTypeNo = 11
WHERE 
Comp.IsOldComponent = 0 
AND Comp.HdVersionNo BETWEEN 1 AND 999999998
AND A.TerminationDate IS NULL

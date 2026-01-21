--liquibase formatted sql

--changeset system:create-alter-view-PtPositionAllView context:any labels:c-any,o-view,ot-schema,on-PtPositionAllView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionAllView
CREATE OR ALTER VIEW dbo.PtPositionAllView AS
SELECT TOP 100 PERCENT
P.Id, 
P.HdPendingChanges, 
P.HdPendingSubChanges, 
P.HdVersionNo, 
F.PartnerId, 
A.AccountNo, 
A.Id AS AccountId,
F.PortfolioNo, 
P.Quantity,
R.Currency, 
P.ValueProductCurrency,  
B.VdfInstrumentSymbol,
B.SecurityType, 
IsNull(Convert(varchar,R.InterestRate) + ' % ', '') 
+ IsNull(T.SHORTNAME + ' ', '') 
+ IsNull(T.ValidityRange + ' ', '') 
+ IsNull(T.Suffix,'') 
+ IsNULL(A.AccountNoEdited + ' ', '')
+ IsNULL(Tex.TextShort + ' ','')
+ IsNULL('-' + A.CustomerReference, '') AS ShortName, 
F.PortfolioNoEdited + ' ('  
+ IsNull(Convert(varchar,R.InterestRate) + ' % ', '') 
+ IsNull(T.SHORTNAME + ' ', '') 
+ IsNull(T.ValidityRange + ' ', '') 
+ IsNull(T.Suffix,'') 
+ IsNULL(A.AccountNoEdited + ' ', '')
+ IsNULL(Tex.TextShort + ' ','')
+ IsNULL('-' + A.CustomerReference, '')
+ IsNull(' - ' + Convert(varchar,OBJ.ObjectSeqNo), '')
+ IsNull(' - ' + Convert(varchar,OBL.ObjectSeqNo), '')
+ IsNull(' - ' + Convert(varchar,INS.ObjectSeqNo), '') + ')'  AS LongName ,
T.LanguageNo, 
Tex.LanguageNo AS ProdLanguageNo,
+ IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
        + IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
        + IsNull(Convert(varchar,INS.ObjectSeqNo), '') As ReferenceData
from PtPosition AS P
INNER JOIN PtPortfolio AS F ON F.Id = P.PortfolioId
INNER JOIN PrReference AS R ON P.ProdReferenceId = R.Id
LEFT OUTER JOIN PrPrivate AS Pr ON R.ProductId = Pr.ProductId
LEFT OUTER JOIN AsText AS Tex ON Pr.Id = Tex.MasterId
LEFT OUTER JOIN PtAccountBase AS A ON R.AccountId = A.Id
LEFT OUTER JOIN PrPublic AS B ON R.ProductId = B.ProductId
LEFT OUTER JOIN PrPublicText AS T ON B.Id = T.PublicId
LEFT OUTER JOIN PtInstituteName AS I ON B.NamingPartnerId = I.PartnerId
LEFT OUTER JOIN PrInsurancePolice AS Ins On R.InsurancePoliceID=Ins.ID And Ins.HdVersionNo < 999999999
LEFT OUTER JOIN PrObject AS OBJ On R.ObjectId = OBJ.Id
LEFT OUTER JOIN ReObligation AS OBL ON R.ObligationId = OBL.Id
WHERE 
(P.Quantity <> 0 OR A.AccountNo IS NOT NULL)
AND ((T.LanguageNo = I.LanguageNo) OR T.LanguageNo IS NULL OR I.LanguageNo IS NULL)
AND (A.TerminationDate IS NULL)

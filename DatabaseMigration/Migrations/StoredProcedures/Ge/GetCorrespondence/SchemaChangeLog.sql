--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorrespondence context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorrespondence,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorrespondence
CREATE OR ALTER PROCEDURE dbo.GetCorrespondence
  @PartnerId UniqueIdentifier,
  @LanguageNo tinyint AS
Select B.Id AS PartnerId, D.FullAddress, B.PartnerNoEdited, B.Name, B.FirstName, B.NameCont, NULL AS 'PortfolioNo', NULL AS 'AccountNo', T.TextShort from PtAddress D
  LEFT OUTER JOIN PtCorrPartner ON D.Id = PtCorrPartner.AddressId
  JOIN PtBase B ON PtCorrPartner.PartnerId = B.Id
  JOIN PtCorrPartnerItemGroup I ON PtCorrPartner.Id = I.CorrPartnerId
  JOIN AsCorrItemGroup G ON I.CorrItemGroupNo = G.CorrItemGroupNo
  JOIN AsText T ON G.Id = T.MasterId
  WHERE D.PartnerId = @PartnerId
    AND T.LanguageNo = @LanguageNo
    AND PtCorrPartner.HdVersionNo < 999999999
	AND I.HdVersionNo < 999999999
UNION Select B.Id AS PartnerId, D.FullAddress, B.PartnerNoEdited, B.Name, B.FirstName, B.NameCont, P.PortfolioNoEdited AS PortfolioNo, NULL AS 'AccountNo', T.TextShort from PtAddress D
  LEFT OUTER JOIN PtCorrPortfolio ON D.Id = PtCorrPortfolio.AddressId
  JOIN PtPortfolio P ON PtCorrPortfolio.PortfolioId = P.Id
  JOIN PtBase B ON P.PartnerId = B.Id
  JOIN PtCorrPortfolioItemGroup I ON PtCorrPortfolio.Id = I.CorrPortfolioId
  JOIN AsCorrItemGroup G ON I.CorrItemGroupNo = G.CorrItemGroupNo
  JOIN AsText T ON G.Id = T.MasterId
  WHERE D.PartnerId = @PartnerId
    AND T.LanguageNo = @LanguageNo
    AND PtCorrPortfolio.HdVersionNo < 999999999
	AND I.HdVersionNo < 999999999
UNION Select B.Id AS PartnerId, D.FullAddress, B.PartnerNoEdited, B.Name, B.FirstName, B.NameCont, NULL AS 'PortfolioNo', A.AccountNoEdited AS AccountNo, T.TextShort from PtAddress D
  LEFT OUTER JOIN PtCorrAccount ON D.Id = PtCorrAccount.AddressId
  JOIN PtAccountBase A ON PtCorrAccount.AccountId = A.Id
  JOIN PtPortfolio P ON A.PortfolioId = P.Id
  JOIN PtBase B ON P.PartnerId = B.Id
  JOIN PtCorrAccountItemGroup I ON PtCorrAccount.Id = I.CorrAccountId
  JOIN AsCorrItemGroup G ON I.CorrItemGroupNo = G.CorrItemGroupNo
  JOIN AsText T ON G.Id = T.MasterId
  WHERE D.PartnerId = @PartnerId
    AND T.LanguageNo = @LanguageNo
    AND PtCorrAccount.HdVersionNo < 999999999
	AND I.HdVersionNo < 999999999
	AND A.HdVersionNo < 999999999

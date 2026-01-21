--liquibase formatted sql

--changeset system:create-alter-procedure-GetBlockingsListByAccountNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBlockingsListByAccountNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBlockingsListByAccountNo
CREATE OR ALTER PROCEDURE dbo.GetBlockingsListByAccountNo

@AccountNo 	decimal(11),
@LanguageNo 	tinyint

AS

SELECT 
BlockDate, 
BlockIssuer, 
TextShort, 
ParentTableName, 
BlockComment, 
ReleaseDate, 
ReleaseIssuer, 
ReleaseReason, 
ReleaseComment,
ReleasePaymentOrderAllowed,
Warning AS IsWarning,
AllowDebit,
AllowCredit
FROM (
SELECT PtBlocking.*, T.TextShort, Reason.ReleasePaymentOrderAllowed,
Reason.IsWarning AS Warning, Reason.AllowDebit, Reason.AllowCredit
FROM PtAccountBase AS A
INNER JOIN PtPortfolio AS Pf ON A.PortfolioId = Pf.Id
INNER JOIN PtBlocking ON PtBlocking.ParentId = Pf.PartnerId
INNER JOIN PtBlockReason AS Reason ON Reason.Id = PtBlocking.BlockReason
LEFT OUTER JOIN AsText AS T ON Reason.Id = T.MasterId AND T.LanguageNo = @LanguageNo
WHERE A.AccountNo = @AccountNo
AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())

UNION ALL

SELECT PtBlocking.*, T.TextShort, Reason.ReleasePaymentOrderAllowed,
Reason.IsWarning AS Warning, Reason.AllowDebit, Reason.AllowCredit
FROM PtAccountBase AS A
INNER JOIN PtPortfolio AS Pf ON A.PortfolioId = Pf.Id
INNER JOIN PtBlocking ON PtBlocking.ParentId = Pf.Id
INNER JOIN PtBlockReason AS Reason ON Reason.Id = PtBlocking.BlockReason
LEFT OUTER JOIN AsText AS T ON Reason.Id = T.MasterId AND T.LanguageNo = @LanguageNo
WHERE A.AccountNo = @AccountNo
AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())

UNION ALL

SELECT PtBlocking.*, T.TextShort, Reason.ReleasePaymentOrderAllowed,
Reason.IsWarning AS Warning, Reason.AllowDebit, Reason.AllowCredit
FROM PtAccountBase AS A
INNER JOIN PtBlocking ON PtBlocking.ParentId = A.Id
INNER JOIN PtBlockReason AS Reason ON Reason.Id = PtBlocking.BlockReason
LEFT OUTER JOIN AsText AS T ON Reason.Id = T.MasterId AND T.LanguageNo = @LanguageNo
WHERE A.AccountNo = @AccountNo
AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())

UNION ALL

SELECT PtBlocking.*, T.TextShort, Reason.ReleasePaymentOrderAllowed,
Reason.IsWarning AS Warning, Reason.AllowDebit, Reason.AllowCredit
FROM PtAccountBase AS A
INNER JOIN PrReference AS REF ON REF.AccountId = A.Id
INNER JOIN PtPosition AS Pos ON Pos.ProdReferenceId = Ref.Id
INNER JOIN PtBlocking ON PtBlocking.ParentId = Pos.Id
INNER JOIN PtBlockReason AS Reason ON Reason.Id = PtBlocking.BlockReason
LEFT OUTER JOIN AsText AS T ON Reason.Id = T.MasterId AND T.LanguageNo = @LanguageNo
WHERE A.AccountNo = @AccountNo
AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())
) AS Blockings

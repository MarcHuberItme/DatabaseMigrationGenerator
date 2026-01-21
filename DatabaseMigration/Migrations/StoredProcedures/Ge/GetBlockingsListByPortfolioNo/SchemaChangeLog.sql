--liquibase formatted sql

--changeset system:create-alter-procedure-GetBlockingsListByPortfolioNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBlockingsListByPortfolioNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBlockingsListByPortfolioNo
CREATE OR ALTER PROCEDURE dbo.GetBlockingsListByPortfolioNo

@PortfolioNo	decimal(11),
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
FROM PtPortfolio AS Pf 
INNER JOIN PtBlocking ON PtBlocking.ParentId = Pf.PartnerId
INNER JOIN PtBlockReason AS Reason ON Reason.Id = PtBlocking.BlockReason
LEFT OUTER JOIN AsText AS T ON Reason.Id = T.MasterId AND T.LanguageNo = @LanguageNo
WHERE Pf.PortfolioNo = @PortfolioNo
AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())

UNION ALL

SELECT PtBlocking.*, T.TextShort, Reason.ReleasePaymentOrderAllowed,
Reason.IsWarning AS Warning, Reason.AllowDebit, Reason.AllowCredit
FROM PtPortfolio AS Pf 
INNER JOIN PtBlocking ON PtBlocking.ParentId = Pf.Id
INNER JOIN PtBlockReason AS Reason ON Reason.Id = PtBlocking.BlockReason
LEFT OUTER JOIN AsText AS T ON Reason.Id = T.MasterId AND T.LanguageNo = @LanguageNo
WHERE Pf.PortfolioNo = @PortfolioNo
AND PtBlocking.HdVersionNo BETWEEN 1 AND 999999998 
AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE())

) AS Blockings

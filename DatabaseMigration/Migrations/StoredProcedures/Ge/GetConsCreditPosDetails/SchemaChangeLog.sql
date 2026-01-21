--liquibase formatted sql

--changeset system:create-alter-procedure-GetConsCreditPosDetails context:any labels:c-any,o-stored-procedure,ot-schema,on-GetConsCreditPosDetails,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetConsCreditPosDetails
CREATE OR ALTER PROCEDURE dbo.GetConsCreditPosDetails

@ConsCreditMonitorId uniqueidentifier,
@SeqNo tinyint,
@LanguageNo tinyint

AS

select C.Id, C.ConsCreditMonitorId, C.SeqNo, C.PositionId, C.BalanceDate, C.BalanceHoCu, C.MarketValueHoCu, C.PledgedValueHoCu, A.AccountNo AS KeyValue, A.AccountNoEdited + ' ' + Ref.Currency + ' ' + Tx.TextShort AS Description, Tx.LanguageNo
from PtConsCreditAccountDetail AS C
inner join PtPosition AS Pos ON Pos.Id = C.PositionId
inner join PrReference AS Ref ON Pos.ProdReferenceId = Ref.Id
inner join PtAccountBase AS A ON Ref.AccountId = A.Id
inner join PrPrivate AS Pr ON Ref.ProductId = Pr.ProductId
left outer join AsText AS Tx ON Pr.Id = Tx.MasterId AND languageno = @LanguageNo 
where ConsCreditMonitorId = @ConsCreditMonitorId and SeqNo = @SeqNo

union all

select C.Id, ConsCreditMonitorId, SeqNo, PortfolioId, BalanceDate, BalanceHoCu, MarketValueHoCu, PledgedValueHoCu, P.PortfolioNo AS KeyValue, P.PortfolioNoEdited + ' ' + P.Currency + ' ' + Tx.TextShort AS Description, Tx.LanguageNo
from PtConsCreditSecurities AS C
inner join PtPortfolio AS P ON C.PortfolioId = P.Id
inner join PtPortfolioType AS Pt ON P.PortfolioTypeNo = Pt.PortfolioTypeNo
left outer join AsText AS Tx ON Pt.Id = Tx.MasterId AND languageno = @LanguageNo 
where ConsCreditMonitorId = @ConsCreditMonitorId and SeqNo = @SeqNo
Order by ConsCreditMonitorId, KeyValue


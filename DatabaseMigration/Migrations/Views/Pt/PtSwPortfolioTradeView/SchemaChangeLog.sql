--liquibase formatted sql

--changeset system:create-alter-view-PtSwPortfolioTradeView context:any labels:c-any,o-view,ot-schema,on-PtSwPortfolioTradeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSwPortfolioTradeView
CREATE OR ALTER VIEW dbo.PtSwPortfolioTradeView AS
Select Distinct  V.Id, S.SwiftAddress, S.SessionNumber, S.LastMessageNumber, P.MessageTypeCode, P.SWIFT_ADR, P.StatementNo, 
P.MessageTypeCode As ContinuationIndicator, P.StatementNo As PageNumber, P.PortfolioId,
S.AppName As SenderReference, S.AppName As TradeReference, S.AppName As PreparationTime, 
TradeDate, ':TRAD//20170808101010' As TradeTime, T.PaymentDate As SettlementDate, PriceLimit, OrderQuantity, TradePrice, TradeQuantity, 'UNIT' As QuantityType, S.AppName As MarketPrice, SecurityBookingSide, Case When SecurityBookingSide='D' Then 'BUSE//SELL' Else 'BUSE//BUYI' End As BuSeIndicator, S.AppName As AccountOwner, ShortName, O.PortfolioNo, O.PortfolioNoEdited, S.AppName As BookingAccount, V.IsinNo  As IsinDesc, S.AppName As AmountDesc
From SwMTSettings S Join SwMTPortfolio P On P.SettingId=S.Id
Join PtSecurityTradesView T On T.SecurityPortfolioId =P.PortfolioId 
Join PrPublicDescriptionView V On T.PublicId=V.Id And V.SecurityType='1' And LanguageNo=2
Join PtPortfolio O On T.SecurityPortfolioId =O.Id
Where S.AppName ='SwiftServer' And P.MessageTypeCode ='515'
	And T.Type='Traded'
	And T.TradeDate>'2015.11.01'
	And V.IsinNo='CH0002497458'

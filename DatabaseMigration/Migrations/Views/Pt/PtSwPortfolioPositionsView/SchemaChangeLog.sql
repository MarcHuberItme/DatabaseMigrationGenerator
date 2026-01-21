--liquibase formatted sql

--changeset system:create-alter-view-PtSwPortfolioPositionsView context:any labels:c-any,o-view,ot-schema,on-PtSwPortfolioPositionsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSwPortfolioPositionsView
CREATE OR ALTER VIEW dbo.PtSwPortfolioPositionsView AS
Select Distinct  V.Id, S.SwiftAddress, S.SessionNumber, S.LastMessageNumber, P.MessageTypeCode, P.SWIFT_ADR, P.StatementNo, 
P.MessageTypeCode As ContinuationIndicator, P.StatementNo As PageNumber, P.PortfolioId,
PP.PortfolioNo, PP.PortfolioNoEdited, S.AppName As SenderReference, S.AppName As PreparationTime, Pub.UnitNo,
--Pos.SWIFTPortfolioId, Pos.IsinNo, Pos.ValQuantity,
V.MarketValuePrCu, V.MarketValueVaCu, 
V.TotalValueVaCu, V.NominalCurrency, V.ValuationCurrency,
V.PriceCurrency, V.PriceQuoteType, V.Rate, VV.ValuationDate, PubV.LongName
From SwMTSettings S Join SwMTPortfolio P On P.SettingId=S.Id
Join PtPositionValuationView V On V.PortfolioId=P.PortfolioId 
Join VaRun VV On V.VaRunId=VV.Id 
Join PtPortfolio PP On PP.Id=P.PortfolioId 
Join PrPublicDescriptionView PubV On V.PublicID =PubV.Id And PubV.LanguageNo =2
Join PrPublic Pub On V.PublicID=Pub.Id 
--Join PtSWIFTPortfolio SP On SP.PortfolioId=P.PortfolioId And SP.VaRunId=V.VaRunId 
--Join PtSWIFTPortfolioPositions Pos On Pos.SWIFTPortfolioId=SP.Id
Where S.AppName ='SwiftServer' 
	And P.PortfolioId='01A1986E-710C-4A1D-9A00-4F73F0FDB62E'
	And V.ValQuantity<>0
	And V.LanguageNo=2
	And V.VaRunId='4FA5D64B-AFF3-4369-9481-B65D5D390019' And V.IsinNo ='DE0007070088'
	--And V.IsinNo In ('DE0007070088','IT0003007728', 'CH0038863350')

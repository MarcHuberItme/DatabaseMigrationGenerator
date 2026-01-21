--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateRecent_GetFxRates context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateRecent_GetFxRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateRecent_GetFxRates
CREATE OR ALTER PROCEDURE dbo.CyRateRecent_GetFxRates
@LanguageNo  as integer
AS
Select TXT.TextShort as Currency
, B.Symbol as ISO

, (Select Top 1 RR.Rate
From cyRateRecent RR 
Where RR.Validto > getdate() 
            AND RR.ValidFrom <= getdate() 
            AND RR.RateType = 203
            AND RR.CySymbolOriginate = B.Symbol
            AND RR.CySymbolTarget = 'CHF'
            AND RR.HdVersionNo Between 1 AND 99999998
Order by RR.ValidFrom DESC) as Rate

,(select Top 1 (C.SpreadTrader + C.SpreadManager) * isNull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
            Where RP.CySymbolOriginate = B.Symbol
                                    AND RP.CySymbolTarget = 'CHF' 
                                    AND RP.HdVersionNo Between 1 AND 99999998),1) from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo Order by Amount ASC) As SpreadSmall
									

, (select Top 1 (C.SpreadTrader + C.SpreadManager) * isNull((Select isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
            Where RP.CySymbolOriginate = B.Symbol
                                    AND RP.CySymbolTarget = 'CHF' 
                                    AND RP.HdVersionNo Between 1 AND 99999998),1) from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo And C.ID <> 
         (select Top 1 C.Id from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo Order by Amount ASC) Order by Amount ASC) As SpreadBig

,           isNull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
            Where RP.CySymbolOriginate = B.Symbol
                                    AND RP.CySymbolTarget = 'CHF' 
                                    AND RP.HdVersionNo Between 1 AND 99999998),1)as Faktor


, Convert(varchar,getdate() , 104)  as RateDate
/*,  B.Sequence as Sequence */
/*, (Select Date From CyRateImportFixation Where PaymentInstrumentNo = 20) as Date*/
, (Select ValueDate From CyRateImportFixation Where PaymentInstrumentNo = 20) as ValueDate
/*, (Select Id From PtBase where PartnerNo = 211351) As PartnerId*/
/*, (Select PartnerNo From PtBase where PartnerNo = 211351) As PartnerNo
, (Select Id From PtPortfolio where PortfolioNo = 211351008) as PortfolioId */
From CyBase B
Left Outer Join asText TXT on TXT.MasterId = B.Id And TXT.LanguageNo = @LanguageNo
Inner Join CyRateRule RR on  RR.CySymbolOriginate = B.Symbol
            AND RR.CySymbolTarget = 'CHF'
            AND RR.PaymentInstrumentNo = 20
            AND RR.HdVersionNo Between 1 AND 99999998
Where B.HdVersionNo Between 1 AND 99999998
AND B.PortfolioAcceptance = 1
AND B.Symbol <> 'CHF'
Order by B.Sequence

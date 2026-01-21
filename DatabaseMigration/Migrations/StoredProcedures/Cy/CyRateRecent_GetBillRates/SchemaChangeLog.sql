--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateRecent_GetBillRates context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateRecent_GetBillRates,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateRecent_GetBillRates
CREATE OR ALTER PROCEDURE dbo.CyRateRecent_GetBillRates
@LanguageNo as integer
AS
Select TXT.TextShort as CyOriginate
, B.Symbol as CySymbolOriginate

, (Select Top 1 RR.Rate
From cyRateRecent RR  
Where RR.Validto > getdate() 
            AND RR.ValidFrom <= getdate() 
            AND RR.RateType = 103
            AND RR.CySymbolOriginate = B.Symbol
            AND RR.CySymbolTarget = 'CHF'
            AND RR.HdVersionNo Between 1 AND 99999998
Order by RR.ValidFrom DESC) as Rate

, (select Top 1 (C.SpreadTrader + C.SpreadManager) * isNull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
            Where RP.CySymbolOriginate = B.Symbol
                                    AND RP.CySymbolTarget = 'CHF' 
                                    AND RP.HdVersionNo Between 1 AND 99999998),1) from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo Order by Amount ASC) As SpreadSmall

, (select Top 1 (C.SpreadTrader + C.SpreadManager) * isNull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
            Where RP.CySymbolOriginate = B.Symbol
                                    AND RP.CySymbolTarget = 'CHF' 
                                    AND RP.HdVersionNo Between 1 AND 99999998),1) from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo And C.ID <> 
         (select Top 1 C.Id from cyCommission C Where C.Symbol = B.Symbol And C.PaymentInstrumentNo =  RR.PaymentInstrumentNo Order by Amount ASC) Order by Amount ASC) As SpreadBig

,           isNull((Select Isnull(RP.FactorOriginate,1) From cyRatePresentation RP 
            Where RP.CySymbolOriginate = B.Symbol
                                    AND RP.CySymbolTarget = 'CHF' 
                                    AND RP.HdVersionNo Between 1 AND 99999998),1)as Factor

, Convert(varchar,getdate() , 104)  as RateDate
,  B.Sequence as Sequence
, (Select Date From CyRateImportFixation Where PaymentInstrumentNo = 10) as Date
From CyBase B
Left Outer Join asText TXT on TXT.MasterId = B.Id And TXT.LanguageNo = @LanguageNo
Inner Join CyRateRule RR on  RR.CySymbolOriginate = B.Symbol
            AND RR.CySymbolTarget = 'CHF'
            AND RR.PaymentInstrumentNo = 10
            AND RR.HdVersionNo Between 1 AND 99999998
Where B.HdVersionNo Between 1 AND 99999998
AND B.BillAcceptance = 1 
AND B.CategoryNo = 1
AND B.Symbol <> 'CHF'
AND B.Symbol = 'USD' 
OR B.Symbol = 'GBP'
OR B.Symbol = 'EUR'
Order by B.Sequence


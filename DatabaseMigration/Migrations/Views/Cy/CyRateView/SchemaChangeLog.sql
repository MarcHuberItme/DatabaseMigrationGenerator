--liquibase formatted sql

--changeset system:create-alter-view-CyRateView context:any labels:c-any,o-view,ot-schema,on-CyRateView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CyRateView
CREATE OR ALTER VIEW dbo.CyRateView AS
SELECT 	CR.Id,
	CR.HdCreateDate , 
	CR.HdCreator , 
	CR.HdChangeDate ,  
	CR.HdChangeUser , 
	CR.HdEditStamp ,
	CR.HdVersionNo ,
	CR.HdProcessId ,
	CR.HdStatusFlag , 
	CR.HdNoUpdateFlag , 
	CR.HdPendingChanges , 
	CR.HdPendingSubChanges , 
	CR.HdTriggerControl ,
                CB.Sequence , 
                CR.CySymbolTarget, 
                CR.CySymbolOriginate , 
                (CC.Amount*CR.Rate) AS AmountInTargetCurrency ,
                CR.ValidFrom , 
                CR.ValidTo, 
                CRP.FactorOriginate , 
                (CR.Rate * CRP.FactorOriginate) AS RateFactor , 
                CR.RateType , 
                ((CR.Rate - CC.SpreadTrader - CC.SpreadManager)* CRP.FactorOriginate) AS BuyRate ,
                ((CR.Rate + CC.SpreadManager + CC.SpreadTrader)* CRP.FactorOriginate) AS SellRate, 
                CC.SpreadManager , 
                CC.SpreadTrader , 
                CC.Amount AS AmountInOriginCurrency 

FROM    CyRateRecent CR 

INNER JOIN 

( SELECT CRR.CySymbolOriginate , 
                 MAX(CRR.ValidFrom) AS LastDate 
  FROM    CyRateRecent CRR 
  GROUP BY CRR.CySymbolOriginate ) AS A
  ON         CR.CySymbolOriginate = A.CySymbolOriginate 

LEFT OUTER JOIN CyBase AS CB ON CR.CySymbolOriginate = CB.Symbol
LEFT OUTER JOIN CyCommission AS CC ON CR.CySymbolOriginate = CC.Symbol
LEFT OUTER JOIN CyRatePresentation AS CRP ON CR.CySymbolOriginate = CRP.CySymbolOriginate

WHERE CR.ValidFrom = A.LastDate	
      AND CR.HdVersionNo < 999999999 
      AND CC.HdVersionNo < 999999999    
      AND CRP.HdVersionNo < 999999999
      AND CB.HdVersionNo < 999999999

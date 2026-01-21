--liquibase formatted sql

--changeset system:create-alter-view-AcBalanceViewLevel6Compare context:any labels:c-any,o-view,ot-schema,on-AcBalanceViewLevel6Compare,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcBalanceViewLevel6Compare
CREATE OR ALTER VIEW dbo.AcBalanceViewLevel6Compare AS
SELECT DISTINCT 
	VL.AL1, VL.AL2, VL.AL3, VL.AL4, VL.AL5, 
	T1.TextLong AS T1, T2.TextLong AS T2, 
	T3.TextLong AS T3, T4.TextLong AS T4, 
	T5.TextLong AS T5, ST.TextLong AS ST, 
	 CNT.TextLong AS CNT,
	CN.SecurityLevelNo, 
	VL.BalanceAccountNo, VL.Currency, 
	VL.SumProductCurrency, VL.SumBasicCurrency, VL.ComponentNo,
        VL.VirtualDate, VL.EvaluationDate,
	VL.AccountancyPeriod,
	T1.LanguageNo As LanguageNoT1,
	T2.LanguageNo As LanguageNoT2,
	T3.LanguageNo As LanguageNoT3,
	T4.LanguageNo As LanguageNoT4,
	T5.LanguageNo As LanguageNoT5,
	CNT.LanguageNo As LanguageNoCNT
FROM AcBalanceViewLevel6Archive AS VL
INNER JOIN AcBalanceStructure AS BS ON VL.BalanceAccountNo = BS.BalanceAccountNo
LEFT OUTER JOIN AcBalanceStructureAL1 AS L1 ON VL.AL1 = L1.AL1
LEFT OUTER JOIN AcBalanceStructureAL2 AS L2 ON VL.AL2 = L2.AL2
LEFT OUTER JOIN AcBalanceStructureAL3 AS L3 ON VL.AL3 = L3.AL3
LEFT OUTER JOIN AcBalanceStructureAL4 AS L4 ON VL.AL4 = L4.AL4
LEFT OUTER JOIN AcBalanceStructureAL5 AS L5 ON VL.AL5 = L5.AL5
LEFT OUTER JOIN PrPrivateCompType AS CN ON VL.ComponentNo = CN.CompTypeNo
LEFT OUTER JOIN AsText AS ST ON BS.Id = ST.MasterId
LEFT OUTER JOIN AsText AS T1 ON L1.Id = T1.MasterId
LEFT OUTER JOIN AsText AS T2 ON L2.Id = T2.MasterId
LEFT OUTER JOIN AsText AS T3 ON L3.Id = T3.MasterId
LEFT OUTER JOIN AsText AS T4 ON L4.Id = T4.MasterId
LEFT OUTER JOIN AsText AS T5 ON L5.Id = T5.MasterId
LEFT OUTER JOIN AsText AS CNT ON CN.Id = CNT.MasterId


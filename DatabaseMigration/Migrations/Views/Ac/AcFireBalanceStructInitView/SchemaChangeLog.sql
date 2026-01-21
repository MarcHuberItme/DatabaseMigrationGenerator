--liquibase formatted sql

--changeset system:create-alter-view-AcFireBalanceStructInitView context:any labels:c-any,o-view,ot-schema,on-AcFireBalanceStructInitView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFireBalanceStructInitView
CREATE OR ALTER VIEW dbo.AcFireBalanceStructInitView AS
SELECT BS.Id, BS.BalanceAccountNo, BS.FireAccountNo AS ActualFireAccountNo, ISNULL(FBA.FireAccountNo,ISNULL(FBA2.FireAccountNo,ISNULL(FBSA.FireAccountNo,FBSA2.FireAccountNo))) AS NewFireAccountNo,
CASE 
WHEN ISNULL(BS.FireAccountNo,0) <> ISNULL(FBA.FireAccountNo,ISNULL(FBA2.FireAccountNo,ISNULL(FBSA.FireAccountNo,IsNull(FBSA2.FireAccountNo,0)))) THEN 1
ELSE 0
END AS Changed
FROM AcBalanceStructure AS BS
LEFT OUTER JOIN AcFireBalanceStrucAssign AS FBSA ON BS.AL4 = FBSA.AL4 AND ISNULL(BS.AL5,0) = ISNULL(FBSA.AL5,0) AND FBSA.SystemDefault = 0 AND FBSA.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AcFireBalanceStrucAssign AS FBSA2 ON BS.AL4 = FBSA2.AL4 AND ISNULL(BS.AL5,0) = ISNULL(FBSA2.AL5,0) AND FBSA2.SystemDefault = 1 AND FBSA2.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AcFireBalanceAccAssign AS FBA ON BS.BalanceAccountNo = FBA.BalanceAccountNo AND FBA.SystemDefault = 0 AND FBA.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AcFireBalanceAccAssign AS FBA2 ON BS.BalanceAccountNo = FBA2.BalanceAccountNo AND FBA2.SystemDefault = 1 AND FBA2.HdVersionNo BETWEEN 1 AND 999999998
WHERE BS.HdVersionNo BETWEEN 1 AND 999999998
   AND BS.BalanceSheetTypeNo = 20

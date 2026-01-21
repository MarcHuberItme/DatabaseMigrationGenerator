--liquibase formatted sql

--changeset system:create-alter-view-AcFireMappingAccountView context:any labels:c-any,o-view,ot-schema,on-AcFireMappingAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFireMappingAccountView
CREATE OR ALTER VIEW dbo.AcFireMappingAccountView AS
SELECT 
BS.Id, 
BS.HdCreateDate, 
BS.HdCreator, 
BS.HdChangeDate, 
BS.HdChangeUser, 
BS.HdEditStamp, 
BS.HdVersionNo, 
BS.HdProcessId, 
BS.HdStatusFlag, 
BS.HdNoUpdateFlag, 
BS.HdPendingChanges, 
BS.HdPendingSubChanges, 
BS.HdTriggerControl, 
BS.BalanceAccountNo, 
BS.AL4,
BS.AL5,
BAA.PrivateProductNo, 
BAA.ValueSign, 
CASE
WHEN BAA.Id IS NULL THEN 1
ELSE BAA.AmountType
END AS AmountType,
BS.FireAccountNo,  
BAA.Id AS AssignementId,
ISNULL(FA2.ParentAccountNo, FA2.AccountNo) AS MainParent
FROM AcBalanceStructure AS BS
LEFT OUTER JOIN AcFireAccount AS FA ON BS.FireAccountNo = FA.AccountNo
LEFT OUTER JOIN AcFireAccount AS FA2 ON FA.ParentAccountNo = FA2.AccountNo
LEFT OUTER JOIN AcFireAccount AS FA3 ON FA2.ParentAccountNo = FA3.AccountNo
LEFT OUTER JOIN PtAccountBase AS Ac ON BS.BalanceAccountNo = Ac.AccountNo and TerminationDate is null
LEFT OUTER JOIN AcBalanceAcctAssignment AS BAA ON BS.BalanceAccountNo = BAA.BalanceAccountNo AND BAA.HdVersionNo BETWEEN 1 AND 999999998 AND Ac.AccountNo IS NULL 
LEFT OUTER JOIN AcAmountType AS AAT ON BAA.AmountType = AAT.AmountType
LEFT OUTER JOIN PrPrivate AS Pr ON BAA.PrivateProductNo = Pr.ProductNo
WHERE BS.BalanceSheetTypeNo = 20 AND BS.HdVersionNo BETWEEN 1 AND 999999998

--liquibase formatted sql

--changeset system:create-alter-view-ReBCIndexView context:any labels:c-any,o-view,ot-schema,on-ReBCIndexView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReBCIndexView
CREATE OR ALTER VIEW dbo.ReBCIndexView AS
SELECT     TOP 100 PERCENT Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, 
                      HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, BCNumber, BankName
FROM         dbo.AsBCIndex
WHERE     (BranchId = 0) AND (BCNumber IN
                          (SELECT DISTINCT BCNumber
                            FROM          RePledgeRegister))
UNION 
SELECT TOP 100 PERCENT Id, HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, HdEditStamp, HdVersionNo, HdProcessId, HdStatusFlag, 
                      HdNoUpdateFlag, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, BCNumber, BankName
FROM         dbo.AsBCIndex
WHERE (BranchId = 0) AND BCNumber IN ( SELECT DISTINCT PledgeRegisterPartNo FROM RePledgeRegister 
                                           WHERE PledgeRegisterPartNo > 79999 AND PledgeRegisterPartNo IS NOT NULL ) 
ORDER BY BCNumber

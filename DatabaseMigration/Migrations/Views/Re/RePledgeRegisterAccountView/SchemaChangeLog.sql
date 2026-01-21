--liquibase formatted sql

--changeset system:create-alter-view-RePledgeRegisterAccountView context:any labels:c-any,o-view,ot-schema,on-RePledgeRegisterAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePledgeRegisterAccountView
CREATE OR ALTER VIEW dbo.RePledgeRegisterAccountView AS
SELECT     TOP 100 PERCENT RePledgeRegisterAccount.Id, RePledgeRegisterAccount.HdCreateDate, RePledgeRegisterAccount.HdCreator, 
                      RePledgeRegisterAccount.HdChangeDate, RePledgeRegisterAccount.HdChangeUser, RePledgeRegisterAccount.HdEditStamp, 
                      RePledgeRegisterAccount.HdVersionNo, RePledgeRegisterAccount.HdProcessId, RePledgeRegisterAccount.HdStatusFlag, 
                      RePledgeRegisterAccount.HdNoUpdateFlag, RePledgeRegisterAccount.HdPendingChanges, RePledgeRegisterAccount.HdPendingSubChanges, 
                      RePledgeRegisterAccount.HdTriggerControl, RePledgeRegisterAccount.AccountId, RePledgeRegisterAccount.AccountNo, 
                      RePledgeRegisterAccount.DebitAmount, RePledgeRegisterAccount.NotificationDate, ReBase.Zip, ReBase.Town, ReBase.Id AS BaseId, 
                      RePledgeRegister.PledgeRegisterNo, ISNULL(RePledgeRegister.PledgeRegisterPartNo, '') AS PledgeRegisterPartNo, 
                      ISNULL(RePledgeRegister.StatusNo, '0') AS StatusNo, ISNULL(RePledgeRegister.StatusNoPfB, '0') AS StatusNoPfB, 
                      ISNULL(RePledgeRegister.ValueDate, '') AS ValueDate, ISNULL(RePledgeRegister.ValueAmount, 0) AS ValueAmount, 
                      ISNULL(RePledgeRegister.ValueAmountAdjusted, 0) AS ValueAmountAdjusted
FROM         RePledgeRegister INNER JOIN
                      RePledgeRegisterAccount ON RePledgeRegister.Id = RePledgeRegisterAccount.PledgeRegisterId INNER JOIN
                      ReBase ON RePledgeRegister.ReBaseId = ReBase.Id INNER JOIN
                      PtAccountBase ON RePledgeRegisterAccount.AccountId = PtAccountBase.Id
WHERE     (RePledgeRegisterAccount.HdVersionNo BETWEEN 1 AND 99999998)  AND  
                      (ReBase.HdVersionNo BETWEEN 1 AND 99999998) AND (RePledgeRegister.HdVersionNo BETWEEN 1 AND 99999998) AND 
                      (RePledgeRegister.StatusNoPfB <> 6) AND (PtAccountBase.TerminationDate IS NULL)

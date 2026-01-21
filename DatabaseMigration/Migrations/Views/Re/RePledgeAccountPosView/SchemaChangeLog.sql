--liquibase formatted sql

--changeset system:create-alter-view-RePledgeAccountPosView context:any labels:c-any,o-view,ot-schema,on-RePledgeAccountPosView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RePledgeAccountPosView
CREATE OR ALTER VIEW dbo.RePledgeAccountPosView AS
SELECT     RePledgeRegister.PledgeRegisterNo, RePledgeRegister.PledgeRegisterPartNo,
                   PtPosition.ValueProductCurrency AS AmountInterest, 
                   PtPosition.DueValueProductCurrency * - 1 AS OutstandingInterest, 
                  (PtPosition.ValueProductCurrency - PtPosition.DueValueProductCurrency) * - 1 AS DebitAmount, 
                  (PtAccountClosingPeriod.InterestNosNegative / CASE PtAccountClosingPeriod.DaysNegative WHEN 0 THEN 1 ELSE PtAccountClosingPeriod.DaysNegative
                       END) 
                      / CASE PtAccountClosingPeriod.DaysNegative WHEN 0 THEN 1 ELSE PtAccountClosingPeriod.DaysNegative END * 360 AS InerestAverage, 
                      PtAccountClosingPeriod.DaysNegative, PtAccountClosingPeriod.InterestNosNegative, RePledgeRegisterAccount.AccountNo, 
                    RePledgeRegisterAccount.Id AS MemberUniqueKey, ValueDateEnd AS NotificationDate
FROM          PrReference INNER JOIN
                    PtPosition ON PrReference.Id = PtPosition.ProdReferenceId INNER JOIN
                    RePledgeRegister INNER JOIN
                    RePledgeRegisterAccount ON RePledgeRegister.Id = RePledgeRegisterAccount.PledgeRegisterId ON 
                    PrReference.AccountId = RePledgeRegisterAccount.AccountId LEFT OUTER JOIN
                    PtAccountClosingPeriod ON PtPosition.Id = PtAccountClosingPeriod.PositionId

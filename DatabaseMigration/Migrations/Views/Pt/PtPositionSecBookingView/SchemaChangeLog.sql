--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecBookingView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecBookingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecBookingView
CREATE OR ALTER VIEW dbo.PtPositionSecBookingView AS
Select TI.Id, 
    TI.HdCreateDate, 
    TI.HdCreator, 
    TI.HdChangeDate, 
    TI.HdChangeUser,
    TI.HdEditStamp, 
    TI.HdVersionNo, 
    TI.HdProcessId, 
    TI.HdStatusFlag, 
    TI.HdNoUpdateFlag, 
    TI.HdPendingChanges, 
    TI.HdPendingSubChanges, 
    TI.HdTriggerControl, 
    Pos.ID As PositionID, 
    Pos.Quantity,
    TI.TransDate, 
    TI.TransDateTime, 
    TI.TextNo,
    TI.TransText,
    TI.DebitQuantity, 
    TI.CreditQuantity, 
    TI.ValueDate,
    Case When M.TradePrice Is Not Null Then M.TradePrice
        When M.TradePrice Is Null And TI.MgKurs=0 Then Null
        Else TI.MgKurs End As TradePrice, 
    Case When M.TradePrice Is Null And TI.MgKurs Is Null Then Null 
        When M.TradePrice Is Null And TI.MgKurs=0.0 Then Null
        Else M.PaymentCurrency End As TradeCurrency,
    M.TradeDate, 
    M.BankInternalReference,
    N.ProcessId
From PtTransItem TI Inner Join PtPosition Pos On TI.PositionID=Pos.ID
    Left Outer Join PtTransMessage M On TI.MessageID=M.ID And M.HdVersionNo<999999999
    Left Outer Join PtPositionNotify N on N.PositionId = Pos.Id and N.HdVersionNo < 999999999
Where Pos.HdVersionNo < 999999999 And TI.HdVersionNo between 1 and 999999998

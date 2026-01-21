--liquibase formatted sql

--changeset system:create-alter-view-ATMKTBBookingCheckBView context:any labels:c-any,o-view,ot-schema,on-ATMKTBBookingCheckBView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ATMKTBBookingCheckBView
CREATE OR ALTER VIEW dbo.ATMKTBBookingCheckBView AS
Select Case When ATM.ID Is Not Null Then ATM.ID Else KTB.ID End As ID,
    Case When ATM.ID Is Not Null Then ATM.HdCreateDate Else KTB.HdCreateDate End As HdCreateDate,
    Case When ATM.ID Is Not Null Then ATM.HdCreator Else KTB.HdCreator End As HdCreator,
    Case When ATM.ID Is Not Null Then ATM.HdChangeDate Else KTB.HdChangeDate End As HdChangeDate,
    Case When ATM.ID Is Not Null Then ATM.HdChangeUser Else KTB.HdChangeUser End As HdChangeUser,
    Case When ATM.ID Is Not Null Then ATM.HdEditStamp Else KTB.HdEditStamp End As HdEditStamp,
    Case When ATM.ID Is Not Null Then ATM.HdVersionNo Else KTB.HdVersionNo End As HdVersionNo,
    Case When ATM.ID Is Not Null Then ATM.HdProcessId Else KTB.HdProcessId End As HdProcessId,
    Case When ATM.ID Is Not Null Then ATM.HdStatusFlag Else KTB.HdStatusFlag End As HdStatusFlag,
    Case When ATM.ID Is Not Null Then ATM.HdNoUpdateFlag Else KTB.HdNoUpdateFlag End As HdNoUpdateFlag,
    Case When ATM.ID Is Not Null Then ATM.HdPendingChanges Else KTB.HdPendingChanges End As HdPendingChanges,
    Case When ATM.ID Is Not Null Then ATM.HdPendingSubChanges Else KTB.HdPendingSubChanges End                      As HdPendingSubChanges,
    Case When ATM.ID Is Not Null Then ATM.HdTriggerControl Else KTB.HdTriggerControl End As HdTriggerControl,
    Case When ATM.DeviceID Is Not Null Then ATM.DeviceID Else KTB.DeviceID End As DeviceID,
    Case When ATM.Location Is Not Null Then ATM.Location Else KTB.Location End As Location,
    Case When ATM.PaymentCurrency Is Not Null Then ATM.PaymentCurrency Else KTB.PaymentCurrency End As PaymentCurrency,
    Case When ATM.PaymentAmount Is Not Null Then ATM.PaymentAmount Else KTB.PaymentAmount End As PaymentAmount,
    Cast(Case When ATM.ID Is Not Null Then 1 Else 0 End As Bit) As IsATM,
    Cast(Case When KTB.ID Is Not Null Then 1 Else 0 End As Bit) As IsKTB,
    Case When ATM.TransDate Is Not Null Then ATM.TransDate Else KTB.TransDate End As TransDate,
    Case When ATM.TransDateTime Is Not Null Then ATM.TransDateTime Else KTB.TransDateTime End As TransDateTime,
    Case When ATM.TKAccountNo Is Not Null Then ATM.TKAccountNo Else KTB.TKAccountNo End As TKAccountNo,
    ATM.ATMAccountNo, KTB.SNBAccountNo,
    Case When ATM.ValueDate Is Not Null Then ATM.ValueDate Else KTB.ValueDate End As ValueDate,
    Case When ATM.CardClearingNo Is Not Null Then ATM.CardClearingNo Else KTB.CardClearingNo End As CardClearingNo,
    Case When ATM.TransText Is Not Null Then ATM.TransText Else KTB.TransText End As TransText,
    Case When ATM.CardNo Is Not Null Then ATM.CardNo Else KTB.CardNo End As CardNo
From 
    (
      Select M.ID, M.HdCreateDate, M.HdCreator, M.HdChangeDate, M.HdChangeUser, M.HdEditStamp, 
        M.HdVersionNo, M.HdProcessId, M.HdStatusFlag, M.HdNoUpdateFlag, M.HdPendingChanges, 
        M.HdPendingSubChanges, M.HdTriggerControl, 
        C.DeviceID, C.Location, M.PaymentCurrency, M.PaymentAmount, T.TransDateTime, M.DebitAccountNo As TKAccountNo, 
        M.DebitClearingNo As CardClearingNo, 
        M.CreditAccountNo As ATMAccountNo, M.TransText, M.CardNo, T.TransDate, M.DebitValuedate As ValueDate
      From PtTransMessage M Inner Join PtTransaction T On M.TransactionID=T.ID And T.TransTypeNo=187
        Inner Join AsATMConfig C On T.SeriesNo=C.SeriesNo
          And ((M.CreditAccountNo=C.RMCHF And M.DebitAccountNo=C.BMCHF And M.PaymentCurrency='CHF')
                 Or (M.CreditAccountNo=C.RMEUR And M.DebitAccountNo=C.BMEUR And M.PaymentCurrency='EUR'))
    ) ATM 
Full Join 
    (
      Select M.ID, M.HdCreateDate, M.HdCreator, M.HdChangeDate, M.HdChangeUser, M.HdEditStamp, 
        M.HdVersionNo, M.HdProcessId, M.HdStatusFlag, M.HdNoUpdateFlag, M.HdPendingChanges, 
        M.HdPendingSubChanges, M.HdTriggerControl, 
        C.DeviceID, C.Location, M.PaymentCurrency, M.PaymentAmount, M.DebitAccountNo As SNBAccountNo, 
        M.CreditAccountNo As TKAccountNo, M.CreditTransText As TransText, M.CardNo, 
        Cast(K.BCNrEndKIBank As nvarchar(25)) As CardClearingNo,
        Cast(Convert(varchar(8), K.ExternalTransactionDate, 112) + ' ' + Convert(varchar(8), K.ExternalTransactionTime, 108) As datetime)           As TransDateTime,
       T.TransDate, M.CreditValueDate As ValueDate
      From PtPaymentKTB K Inner Join PtTransMessage M On M.SourceRecID=K.ID 
          And M.SourceTableName='PtPaymentKTB' And K.PaymentStatus=1 And K.TransactionType='KTB_100'                                            And K.IsSettlementDebit=0
        Inner Join PtTransaction T On M.TransactionID=T.ID And T.TransTypeNo=285
        Inner Join AsATMConfig C On Left(K.TerminalID, 6)=C.DeviceID 
          And ((M.CreditAccountNo=C.BMCHF And M.PaymentCurrency='CHF') 
	  Or (M.CreditAccountNo=C.BMEUR And M.PaymentCurrency='EUR'))
    ) KTB On KTB.DeviceID=ATM.DeviceID And KTB.TransDateTime=ATM.TransDateTime           And KTB.TKAccountNo=ATM.TKAccountNo

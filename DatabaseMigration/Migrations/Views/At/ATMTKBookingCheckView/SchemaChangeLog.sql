--liquibase formatted sql

--changeset system:create-alter-view-ATMTKBookingCheckView context:any labels:c-any,o-view,ot-schema,on-ATMTKBookingCheckView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ATMTKBookingCheckView
CREATE OR ALTER VIEW dbo.ATMTKBookingCheckView AS
Select 
  M.ID, M.HdCreateDate, M.HdCreator, M.HdChangeDate,
  M.HdChangeUser, M.HdEditStamp, M.HdVersionNo, M.HdProcessId,
  M.HdStatusFlag, M.HdNoUpdateFlag, M.HdPendingChanges, M.HdPendingSubChanges,
  C.DeviceID, 
  Cast(Case When M.DebitAccountNo=C.BMCHF Or M.DebitAccountNo=C.BMEUR Then 'BM' Else 'RM' End As Char(3)) As ATMorKTB,
  T.TransDateTime, T.TransDate,
  M.PaymentAmount, M.PaymentCurrency,  
  M.CardNo, 
  M.CreditAccountNo As ATMAccountNo, 
  Case When M.PaymentCurrency='CHF' Then C.TransportCHF Else C.TransportEUR End As Transport,
  Case When M.DebitAccountNo=C.BMCHF Or M.DebitAccountNo=C.BMEUR Then M.DebitAccountNo Else Null End 
    As TKAccountNo, 
  Null As SNBAccountNo, 
  A.AccountNo As CardAccountNo,
  M.DebitClearingNo As CardClearingNo, 
  M.DebitValuedate As ValueDate,
  M.TransText,
  E.CheckDateTime
From PtTransMessage M Inner Join PtTransaction T On M.TransactionID=T.ID And T.TransTypeNo=187 
  Inner Join AsATMConfig C On C.SeriesNo=T.SeriesNo 
  Left Outer Join PtAgrCardBase CC On M.CardNo=CC.CardNo And CC.HdVersionNo<999999999
  Left Outer Join PtAccountBase A On CC.AccountID=A.ID And A.HdVersionNo<999999999
  Inner Join ATMKTBBookingError E On E.DeviceID=C.DeviceID 
	And ((E.WithdrawDateTime Is Not Null And  E.WithdrawDateTime=T.TransDateTime) 
	     Or (E.WithdrawDateTime Is Null And E.CardNo=M.CardNo 
			 And E.MinWithdrawDateTime<=T.TransDateTime And E.MaxWithdrawDateTime>=T.TransDateTime))
Where M.HdVersionNo<999999999 And T.HdVersionNo<999999999

Union

Select 
  M.ID, M.HdCreateDate, M.HdCreator, M.HdChangeDate, M.HdChangeUser,
  M.HdEditStamp, M.HdVersionNo, M.HdProcessId, M.HdStatusFlag,
  M.HdNoUpdateFlag, M.HdPendingChanges, M.HdPendingSubChanges,
  C.DeviceID, 
  Cast('TK' As Char(3)) As ATMorKTB,
  Cast(Convert(varchar(8), K.ExternalTransactionDate, 112) + ' ' 
	+ Convert(varchar(8), K.ExternalTransactionTime, 108) As datetime) As TransDateTime, T.TransDate,
  M.PaymentAmount, M.PaymentCurrency,  
  M.CardNo, 
  Null As ATMAccountNo, 
  Case When M.PaymentCurrency='CHF' Then C.TransportCHF Else C.TransportEUR End As Transport,
  Case When K.IsSettlementDebit=0 Then M.CreditAccountNo Else Null End As TKAccountNo, 
  Case When K.IsSettlementDebit=0 Then M.DebitAccountNo Else M.CreditAccountNo End As SNBAccountNo, 
  Case When K.IsSettlementDebit=1 Then M.DebitAccountNo Else Null End As CardAccountNo,
  Cast(K.BCNrEndKIBank As nvarchar(25)) As CardClearingNo, 
  M.DebitValuedate As ValueDate,
  Case When K.IsSettlementDebit=0 Then M.CreditTransText Else DebitTransText End As TransText,
  E.CheckDateTime
From PtTransMessage M Inner Join PtTransaction T On M.TransactionID=T.ID And T.TransTypeNo=285
  Inner Join PtPaymentKTB K On M.SourceRecID=K.ID 
    And M.SourceTableName='PtPaymentKTB' And K.PaymentStatus=1 And K.TransactionType='KTB_100' 
  Inner Join AsATMConfig C On K.TerminalID=C.DeviceID + '00'
  Inner Join ATMKTBBookingError E On E.DeviceID=C.DeviceID 
    And ((E.WithdrawDateTime Is Not Null And E.WithdrawDateTime=Cast(Convert(varchar(8), K.ExternalTransactionDate, 112) + ' ' 
	       + Convert(varchar(8), K.ExternalTransactionTime, 108) As datetime))
            Or (E.WithdrawDateTime Is Null And E.CardNo=M.CardNo And E.MinWithdrawDateTime<=Cast(Convert(varchar(8), K.ExternalTransactionDate, 112) + ' ' + Convert(varchar(8), K.ExternalTransactionTime, 108) As datetime)
                And E.MaxWithdrawDateTime>=Cast(Convert(varchar(8), K.ExternalTransactionDate, 112) + ' ' 
                       + Convert(varchar(8), K.ExternalTransactionTime, 108) As datetime)))
Where M.HdVersionNo<999999999 And T.HdVersionNo<999999999 And K.HdVersionNo<999999999

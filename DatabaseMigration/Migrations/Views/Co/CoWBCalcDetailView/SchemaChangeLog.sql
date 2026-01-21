--liquibase formatted sql

--changeset system:create-alter-view-CoWBCalcDetailView context:any labels:c-any,o-view,ot-schema,on-CoWBCalcDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoWBCalcDetailView
CREATE OR ALTER VIEW dbo.CoWBCalcDetailView AS
Select PB.Id, PB.PartnerNo, PB.PtDescription	
 ,B.CollNo, B.InactFlag As WBInactFlag, BA.AccountId, D.ProductId, BA.MaxAllocAmount As WBMaxZero
 ,BA.InactFlag As AssignInactFlag
 ,Case When BA.MaxAllocAmount=0 Then BA.HdChangeDate Else Null End As WBInactDate 
 ,A.AccountNo, A.AccountNoEdited, A.TerminationDate As AccountCloseDate, D.Currency
 ,D.VeraGrp, Cast(D.VeraDate As Date) As ProcessDate, D.Balance, D.BalanceKW, D.Limit, D.WBAssigned
 ,D.AllowanceAmount As WBAllowanceAmount, D.AccrualsAmount As ResAccrualsAmount
 ,D.AllowanceAmount+D.AccrualsAmount As WBTotal
 ,Case When AM.Veragrp=D.Veragrp Then 1 Else 0 End As IsLastCalc, PV.PVAssignAccount, PV.CalcLimit
 ,Cast(G.ReportDate As Date) As ReportDate, G.ReportDate As FullReportDate, LR.ReportNo As LastReportNo 
From CoBase B Join CoBaseAss BA On B.Id=BA.CollateralId 
  And B.CollSubType = 6100
  And B.HdVersionNo<999999999 And BA.HdVersionNo<999999999
Join PtDescriptionView PB On B.OwnerId =PB.Id And PB.HdVersionNo<999999999
Join PtAccountBase A On BA.AccountId=A.Id And A.HdVersionNo<999999999	
Join (Select Top 1 ReportNo 
  From CoVeraReport 
  Where ProcessType =1 And CreditJob=1 And DynComJob=1 
  Order By ReportNo Desc) LR On 1=1
Join CoVeraDet D On D.AccountId=A.Id And D.ColWorkingType=130 And D.VerabFlag=1 And D.WhereDoWeCameFrom=0	
Join CoVeraGrp G On D.VeraGrp=G.Veragrp And G.Verastat=100 
Join (Select D.AccountId, Max(D.VeraGrp) As LastVeraGrp
 From CoVeraDet D Join CoVeraGrp G On D.Veragrp=G.Veragrp
 Join CoBaseAss BA On BA.AccountId=D.Accountid 
 Join CoBase B On BA.CollateralId=B.Id And B.CollSubType = 6100 
 Where D.ColWorkingType=130 And D.VerabFlag=1 And D.WhereDoWeCameFrom=0	
 Group By D.AccountId, DatePart(dy,G.VeraDate)) UD On D.AccountId=UD.AccountId And D.VeraGrp=UD.LastVeraGrp 
Join CoCalcMev AM On A.Id=AM.AccountId And AM.MevYear=9999
Join (Select AC.AccountId, VeraGrp, 
  Sum(Case When B.CollSubType<>6100 Then PledgeValueAssign Else 0 End) As PVAssignAccount,
  Sum(PledgeValueAssign) As CalcLimit,
  Max(Distinct Case When B.CollSubType=6100 Then B.CollNo Else 0 End) As WBCollNo
  From CoBaseAssCalc AC Join CoBase B On AC.CollateralId=B.Id 
  Group By AC.AccountId, VeraGrp) PV On D.AccountId=PV.AccountId And D.VeraGrp=PV.VeraGrp And B.CollNo=PV.WBCollNo
Where G.ReportDate Is Not Null

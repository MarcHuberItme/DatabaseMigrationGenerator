--liquibase formatted sql

--changeset system:create-alter-view-PtSHRegBookingView context:any labels:c-any,o-view,ot-schema,on-PtSHRegBookingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSHRegBookingView
CREATE OR ALTER VIEW dbo.PtSHRegBookingView AS
Select SH.ID, SH.HdCreateDate, SH.HdCreator, SH.HdChangeDate, SH.HdEditStamp, SH.HdVersionNo, 
	SH.HdProcessId, SH.HdStatusFlag, SH.HdNoUpdateFlag, SH.HdPendingChanges, 
	SH.HdPendingSubChanges, SH.HdTriggerControl, 
	D.RefNo, D.SeqNo, SH.PartnerID As ShareholderID, SH.ShareholderNo, D.DepotbankID,  Pos.PortfolioID, 
	Convert(VarChar(10),D.DeliveryDateTime,104) As DeliveryDate, 
	Case When Pos.Quantity>0 Then Pos.Quantity
			  Else Null End As Credit,
	Case When Pos.Quantity<0 Then -Pos.Quantity
			  Else Null End As Debit,
	D.QuantityType As DeliveryType,
	Cast(Null As VarChar(10)) As TitleNo, Cast( Null As Integer) As TitleShares, Cast(Null As VarChar(50)) As TitleInfo,
	SH.RemainingQuantity As RegisteredShares
From PtTransDeliveryShares D Inner Join PtPositionDetailShare Pos On Pos.DeliveryID=D.ID And D.QuantityType='SHARE'
	Inner Join PtShareholder SH On D.DepotbankID=SH.DepotbankID And SH.PartnerID=Pos.ShareholderID

Union

Select SH.ID, SH.HdCreateDate, SH.HdCreator, SH.HdChangeDate, SH.HdEditStamp, SH.HdVersionNo, 
	SH.HdProcessId, SH.HdStatusFlag, SH.HdNoUpdateFlag, SH.HdPendingChanges, 
	SH.HdPendingSubChanges, SH.HdTriggerControl, 
	D.RefNo,D.SeqNo, 
	SH.PartnerID As ShareholderID, SH.ShareholderNo,
	D.DepotbankID, D.PortfolioID, 
	Convert(VarChar(10),D.DeliveryDateTime,104) As DeliveryDate, 

	Case When D.QuantityType='SHARE' And D.NewShareholderID Is Not Null 
		And D.ShareholderID=SH.PartnerID Then Null
	     When D.QuantityType='SHARE' And D.NewShareholderID Is Not Null 
		And D.NewShareholderID=SH.PartnerID Then R.CreditQuantity 
	     When D.QuantityType='RIGHT' And D.ShareholderID=R.ShareholderID And R.ShareholderID=SH.PartnerID Then Null
	     When D.QuantityType='RIGHT' And D.NewShareholderID=R.ShareholderID And R.ShareholderID=SH.PartnerID Then R.CreditQuantity
	     End As Credit,

	Case When D.QuantityType='SHARE' And D.NewShareholderID Is Not Null 
		And D.ShareholderID=SH.PartnerID Then Pos.Quantity
	     When D.QuantityType='SHARE' And D.NewShareholderID Is Not Null 
		And D.NewShareholderID=SH.PartnerID Then Null
	     When D.QuantityType='RIGHT' And D.ShareholderID=R.ShareholderID And D.ShareholderID=SH.PartnerID Then R.DebitQuantity
	     When D.QuantityType='RIGHT' And D.NewShareholderID=R.ShareholderID And R.ShareholderID=SH.PartnerID Then Null
	     End As Debit,

	Case When D.QuantityType='SHARE' And D.NewShareholderID Is Not Null Then 'RIGHT'
	     Else D.QuantityType End As QuantityType,
	Cast(Null As VarChar(10)) As TitleNo, Cast( Null As Integer) As TitleShares, Cast(Null As VarChar(50)) As TitleInfo,
	SH.RemainingQuantity As RegisteredShares
From PtTransDeliveryShares D Left Outer Join PtPositionDetailShare Pos On D.ID=Pos.DeliveryID
	Left Outer Join PtTransItemRight R On R.DeliveryID=D.ID
	Inner Join PtShareholder SH On SH.DepotbankID=D.DepotbankID
Where (D.QuantityType='SHARE' And D.NewShareholderID Is Not Null 
	And (Pos.ShareholderID=SH.PartnerID Or R.ShareholderID=SH.PartnerID))
      Or (D.QuantityType='RIGHT' And R.ShareholderID=SH.PartnerID)

Union

Select SH.ID, SH.HdCreateDate, SH.HdCreator, SH.HdChangeDate, SH.HdEditStamp, SH.HdVersionNo, 
	SH.HdProcessId, SH.HdStatusFlag, SH.HdNoUpdateFlag, SH.HdPendingChanges, 
	SH.HdPendingSubChanges, SH.HdTriggerControl, 
	D.RefNo, D.SeqNo, SH.PartnerID As ShareholderID, SH.ShareholderNo, T.DepotbankID, 
	Case When D.DeliveryType='CREDIT' And Pos.Quantity>0 And Pos.PortfolioID Is Not Null Then Pos.PortfolioID
	     When D.DeliveryType='DEBIT' And Pos.Quantity<0 And Pos.PortfolioID Is Not Null Then Pos.PortfolioID
	     Else D.PortfolioID End As PortfolioID, 
	Convert(VarChar(10),D.DeliveryDateTime,104) As DeliveryDate, 
	Case When Pos.Quantity>0 And D.CptyPartnerID Is Not Null Then Pos.Quantity Else Null End As Credit,
	Case When Pos.Quantity<0 And D.CptyPartnerID Is Not Null Then -Pos.Quantity Else Null End As Debit,
	'TITLE' As QuantityType,
	T.TitleNo, 
	Cast(ABS(T.Quantity) As Integer) As TitleShares, 
	Case When T.Quantity>0 And T.TitlePrintDate Is Not Null Then 'Printed ' + Convert(Char(10),T.TitlePrintDate,104)
	     When T.Quantity<0 And T.TitleCancelDate Is Not Null Then 'Canceled ' + Convert(Char(10),T.TitleCancelDate,104)
	     Else '' 
	     End As TitleInfo,
	SH.RemainingQuantity As RegisteredShares
From PtTransDeliveryShares D Inner Join PtTransItemTitle T On D.ID=T.DeliveryID
	Left Outer Join PtPositionDetailShare Pos On D.ID=Pos.DeliveryID 
		And Pos.ShareholderID=T.ShareholderID And Pos.DepotbankID=T.DepotbankID 
		And (      (D.QuantityType='TITLE' And D.CptyPartnerID Is Null And D.DeliveryType='CREDIT' And Pos.Quantity>0)
			Or (D.QuantityType='TITLE' And D.CptyPartnerID Is Null And D.DeliveryType='DEBIT' And Pos.Quantity<0)
			Or (D.QuantityType='TITLE' And D.CptyPartnerID Is Not Null And Pos.PortfolioID=D.PortfolioID)
			Or (D.QuantityType='SHARE' And Pos.PortfolioID=D.PortfolioID)
		    )
		And ((Pos.PortfolioID=D.PortfolioID And Not(D.DeliveryType='CREDIT' And D.QuantityType='TITLE' And Pos.Quantity>0))
			Or (D.DeliveryType='CREDIT' And D.QuantityType='TITLE' And Pos.Quantity>0))
	Inner Join PtShareholder SH On SH.DepotbankID=T.DepotbankID And SH.PartnerID=T.ShareholderID


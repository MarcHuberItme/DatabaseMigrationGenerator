--liquibase formatted sql

--changeset system:create-alter-view-PtAccruedOwnSecurityDetailView context:any labels:c-any,o-view,ot-schema,on-PtAccruedOwnSecurityDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccruedOwnSecurityDetailView
CREATE OR ALTER VIEW dbo.PtAccruedOwnSecurityDetailView AS
Select V.PositionID As ID, Ref.HdCreateDate, Ref.HdCreator, Ref.HdChangeDate, Ref.HdChangeUser,
  Ref.HdEditStamp, Ref.HdVersionNo, Ref.HdProcessId, Ref.HdStatusFlag, 
  Ref.HdNoUpdateFlag, Ref.HdPendingChanges, Ref.HdPendingSubChanges, Ref.HdTriggerControl, 'OwnBond' As GroupName,
  V.PositionID, V.VaRunID, R.ValuationDate, V.PartnerID, PD.PartnerNo, PD.PtDescription, V.PortfolioID, V.PortfolioNo, 
  V.Quantity As PosQuantity, Ref.Currency As PosCurrency, V.RatePrCuCHF, 
  Cast(Round(V.MarketValueCHF*2,1)/2 As Money) As MarketValueCHF, Cast(Round(V.AccruedInterestCHF*2,1)/2 As Money) As AccruedInterestCHF, 
  Pub.ISINNo, Ref.MaturityDate, Pub.ActualInterest, PV.ShortName As PositionDescription, PV.LanguageNo
From VaPublicView V Inner Join PrReference Ref On V.ProdReferenceID=Ref.ID And Ref.HdVersionNo<999999999
  Inner Join PrPublic Pub On Pub.ProductID=Ref.ProductID And Pub.HdVersionNo<999999999
  Inner Join PrPublicDescriptionView PV On PV.ProductID = Ref.ProductID
  Inner Join PtBase B On Pub.IssuerID=B.ID And B.HdVersionNo<999999999
  Inner Join AsParameter Pm On CHARINDEX(LTRIM(STR(B.PartnerNo)), Pm.Value)>0 And Pm.Name='IssuerPartnerNoList' And Pm.HdVersionNo<999999999
  Inner Join AsParameterGroup AG On Pm.ParamGroupID=AG.ID And AG.GroupName='AdmCharge' And AG.HdVersionNo<999999999
  Inner Join AsParameter Ps On Pub.SecurityType=Ps.Value And Ps.Name='OwnBondSecurityType' And Ps.HdVersionNo<999999999
  Inner Join AsParameterGroup G On Ps.ParamGroupID=G.ID And G.GroupName='OwnBond' And G.HdVersionNo<999999999
  Inner Join PtDescriptionView PD On V.PartnerID=PD.ID
  Inner Join VaRun R On V.VaRunID=R.ID And Ref.MaturityDate > R.ValuationDate And R.HdVersionNo<999999999
Where V.Quantity>0 And R.RunTypeNo<=2 

Union

Select V.PositionID As ID, Ref.HdCreateDate, Ref.HdCreator, Ref.HdChangeDate, Ref.HdChangeUser,
  Ref.HdEditStamp, Ref.HdVersionNo, Ref.HdProcessId, Ref.HdStatusFlag, 
  Ref.HdNoUpdateFlag, Ref.HdPendingChanges, Ref.HdPendingSubChanges, Ref.HdTriggerControl, GL.Name As GroupName,
  V.PositionID, V.VaRunID, R.ValuationDate, V.PartnerID, PD.PartnerNo, PD.PtDescription, V.PortfolioID, V.PortfolioNo, 
  V.Quantity As PosQuantity, Ref.Currency As PosCurrency, V.RatePrCuCHF, 
  Cast(Round(V.MarketValueCHF*2,1)/2 As Money) As MarketValueCHF, Cast(Round(V.AccruedInterestCHF*2,1)/2 As Money) As AccruedInterestCHF, 
  Pub.ISINNo, RMV.DueDate AS MaturityDate, Pub.ActualInterest, PV.ShortName As PositionDescription, PV.LanguageNo
From AsGroupTypeLabel TL Inner Join AsGroupType GT On TL.GroupTypeID=GT.ID And GT.TableName='PtPortfolio' 
	And TL.Name='NostroPortfolioIntent' And TL.HdVersionNo<999999999
    Inner Join AsGroup G On G.GroupTypeID=GT.ID And G.IsDefault=0 And G.HdVersionNo<999999999
    Inner Join AsGroupLabel GL On G.ID=GL.GroupID And (GL.Name='OwnTrading' Or GL.Name='OwnInvestment') And GL.HdVersionNo<999999999
    Inner Join AsGroupMember M On M.GroupTypeID=GT.ID And M.GroupID=G.ID And M.HdVersionNo<999999999
    Inner Join VaPublicView V On M.TargetRowID=V.PortfolioID
    Inner Join PrReference Ref On V.ProdReferenceID=Ref.ID And Ref.HdVersionNo<999999999
    Inner Join PrPublic Pub On Pub.ProductID=Ref.ProductID And Pub.HdVersionNo<999999999
    Inner Join PrPublicDescriptionView PV On PV.ProductID = Ref.ProductID
    Inner Join PrReferenceMaturityView RMV on RMV.Id = Ref.Id And RMV.LanguageNo = PV.LanguageNo
    Inner Join PtDescriptionView PD On V.PartnerID=PD.ID
    Inner Join VaRun R On V.VaRunID=R.ID And R.HdVersionNo<999999999
Where V.Quantity>0 And R.RunTypeNo<=2 

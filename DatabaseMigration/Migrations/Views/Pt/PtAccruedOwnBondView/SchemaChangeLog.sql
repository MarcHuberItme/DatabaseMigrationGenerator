--liquibase formatted sql

--changeset system:create-alter-view-PtAccruedOwnBondView context:any labels:c-any,o-view,ot-schema,on-PtAccruedOwnBondView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccruedOwnBondView
CREATE OR ALTER VIEW dbo.PtAccruedOwnBondView AS
Select V.PositionID As ID, Ref.HdCreateDate, Ref.HdCreator, Ref.HdChangeDate, Ref.HdChangeUser,
	Ref.HdEditStamp, Ref.HdVersionNo, Ref.HdProcessId, Ref.HdStatusFlag, 
	Ref.HdNoUpdateFlag, Ref.HdPendingChanges, Ref.HdPendingSubChanges, Ref.HdTriggerControl, 'OwnBond' As GroupName,
	V.PositionID, V.VaRunID, R.ValuationDate, V.PartnerID, PD.PartnerNo, PD.PtDescription, V.PortfolioID, V.PortfolioNo, 
	V.Quantity As PosQuantity, Ref.Currency As PosCurrency, V.RatePrCuCHF, 
	V.MarketValueCHF, Round(V.AccruedInterestCHF*2,1)/2 As AccruedInterestCHF, 
	Pub.ISINNo, Ref.MaturityDate, Pub.ActualInterest
From VaPublicView V Inner Join PrReference Ref On V.ProdReferenceID=Ref.ID
	Inner Join PrPublic Pub On Pub.ProductID=Ref.ProductID
	Inner Join AsParameter Pm On Pub.IssuerID=Pm.Value And Pm.Name='PartnerIDOwn'
	Inner Join AsParameter Ps On Pub.SecurityType=Ps.Value And Ps.Name='OwnBondSecurityType'
	Inner Join AsParameterGroup G On Ps.ParamGroupID=G.ID And G.GroupName='OwnBond'
	Inner Join PtDescriptionView PD On V.PartnerID=PD.ID
	Inner Join VaRun R On V.VaRunID=R.ID And Ref.MaturityDate > R.ValuationDate
Where V.Quantity>0 

Union

Select V.PositionID As ID, Ref.HdCreateDate, Ref.HdCreator, Ref.HdChangeDate, Ref.HdChangeUser,
	Ref.HdEditStamp, Ref.HdVersionNo, Ref.HdProcessId, Ref.HdStatusFlag, 
	Ref.HdNoUpdateFlag, Ref.HdPendingChanges, Ref.HdPendingSubChanges, Ref.HdTriggerControl, GL.Name As GroupName,
	V.PositionID, V.VaRunID, R.ValuationDate, V.PartnerID, PD.PartnerNo, PD.PtDescription, V.PortfolioID, V.PortfolioNo, 
	V.Quantity As PosQuantity, Ref.Currency As PosCurrency, V.RatePrCuCHF, 
	V.MarketValueCHF, Round(V.AccruedInterestCHF*2,1)/2 As AccruedInterestCHF, 
	Pub.ISINNo, Ref.MaturityDate, Pub.ActualInterest
From AsGroupTypeLabel TL Inner Join AsGroupType GT On TL.GroupTypeID=GT.ID And GT.TableName='PtPortfolio' And TL.Name='NostroPortfolioIntent'
    Inner Join AsGroup G On G.GroupTypeID=GT.ID And G.IsDefault=0 
    Inner Join AsGroupLabel GL On G.ID=GL.GroupID And (GL.Name='OwnTrading' Or GL.Name='OwnInvestment')
    Inner Join AsGroupMember M On M.GroupTypeID=GT.ID And M.GroupID=G.ID
	Inner Join VaPublicView V On M.TargetRowID=V.PortfolioID
	Inner Join PrReference Ref On V.ProdReferenceID=Ref.ID
	Inner Join PrPublic Pub On Pub.ProductID=Ref.ProductID
	Inner Join PtDescriptionView PD On V.PartnerID=PD.ID
	Inner Join VaRun R On V.VaRunID=R.ID
Where V.Quantity>0 

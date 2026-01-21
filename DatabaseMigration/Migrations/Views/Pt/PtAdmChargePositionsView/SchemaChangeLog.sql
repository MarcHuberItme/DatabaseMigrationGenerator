--liquibase formatted sql

--changeset system:create-alter-view-PtAdmChargePositionsView context:any labels:c-any,o-view,ot-schema,on-PtAdmChargePositionsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAdmChargePositionsView
CREATE OR ALTER VIEW dbo.PtAdmChargePositionsView AS
Select Pos.*, Req.Id As OriginChargePortfolioId
From PtAdmChargePositions Pos Join PtAdmChargePortfolio Link On Pos.ChargePortfolioID=Link.Id 
Join PtAdmChargePortfolio Req On Req.ChargeJobID=Link.ChargeJobID And Req.PortfolioID=Link.PortfolioID 
Join PtAdmChargeExecJob J On J.Id=Req.ChargeJobID
Left Outer Join PtAdmChargeSubType Sub On Req.AdmChargeType=Sub.SubTypeNo      
Where 1=1
And ((Req.AdmChargeType Is Null And Req.ForPositionLink=0 And Req.Id=Link.Id) 
	Or (Req.AdmChargeType Is Not Null And Req.ForPositionLink=0 And Link.ForPositionLink=1))  
And(  (Sub.Id Is Not Null And Sub.DepotSelected=1 And Sub.AccountSelected=1 And Sub.ExcludeNegativeAccount=1 
       And ((Pos.ISINNo Is Not Null) Or (Pos.ISINNo Is Null And AverageValue>=0)))
   Or (Sub.Id Is Not Null And Sub.DepotSelected=1 And Sub.AccountSelected=1 And Sub.ExcludeNegativeAccount=0 )
   Or (Sub.Id Is Not Null And Sub.DepotSelected=1 And Sub.AccountSelected=0 And Pos.ISINNo Is Not Null )
   Or (Sub.Id Is Not Null And Sub.DepotSelected=0 And Sub.AccountSelected=1 And Sub.ExcludeNegativeAccount=1 And Pos.ISINNo Is Null And AverageValue>=0) 
   Or (Sub.Id Is Not Null And Sub.DepotSelected=0 And Sub.AccountSelected=1 And Sub.ExcludeNegativeAccount=0 And Pos.ISINNo Is Null)
   Or (Sub.Id Is Null))

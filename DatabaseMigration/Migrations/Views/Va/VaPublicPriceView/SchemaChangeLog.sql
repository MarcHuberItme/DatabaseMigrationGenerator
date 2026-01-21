--liquibase formatted sql

--changeset system:create-alter-view-VaPublicPriceView context:any labels:c-any,o-view,ot-schema,on-VaPublicPriceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaPublicPriceView
CREATE OR ALTER VIEW dbo.VaPublicPriceView AS
--View: VaPublicPriceView

Select Distinct  PUB.Id AS PublicId, RV.PublicPriceId, PP.Price, RV.MarketValuePrCu, PP.Currency, PP.LogicalPriceDate, RV.ValRunId as VaRunId
from VaRefVal RV
Inner Join PrPublicPrice PP on PP.ID = RV.PublicPriceId
Inner Join PrReference REF ON REF.Id = RV.ProdReferenceId
Inner Join PrPublic PUB ON PUB.ProductId = REF.ProductId


/* old version 
Select Distinct  PP.PublicId, RV.PublicPriceId, PP.Price, RV.MarketValuePrCu, PP.Currency, PP.LogicalPriceDate, RV.ValRunId as VaRunId
from VaRefVal RV
Inner Join PrPublicPrice PP on PP.ID = RV.PublicPriceId */
/*Where RV.ValRunId = (Select Top 1 ID 
From  VaRun 
Where  RunTypeNo = 0 
AND    SynchronizeTypeNo = 1
AND    ValuationStatusNo = 99
AND    ValuationTypeNo = 0
Order  by ValuationDate ASC)*/

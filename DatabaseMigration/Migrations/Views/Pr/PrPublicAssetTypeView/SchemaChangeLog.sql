--liquibase formatted sql

--changeset system:create-alter-view-PrPublicAssetTypeView context:any labels:c-any,o-view,ot-schema,on-PrPublicAssetTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicAssetTypeView
CREATE OR ALTER VIEW dbo.PrPublicAssetTypeView AS
SELECT DISTINCT p.Id, p.IsinNo, p.InstrumentTypeNo, p.SecurityType, p.FundTypeNo, p.AssetTypeCalculated, p.AssetTypeManual, P.UnitNo, P.ExposureCurrency, P.NominalCurrency  
FROM PrPublic p 
JOIN  PrReference ref on p.ProductId = ref.ProductId 
JOIN  PtPosition pos on pos.ProdReferenceId = ref.Id
WHERE (pos.Quantity <> 0  OR pos.LatestTransDate > dateadd(yy,-1,Getdate()))
   AND p.InstrumentTypeNo < 100
   AND p.HdVersionNo BETWEEN 1 AND 999999998 

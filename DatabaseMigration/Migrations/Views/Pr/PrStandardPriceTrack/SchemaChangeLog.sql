--liquibase formatted sql

--changeset system:create-alter-view-PrStandardPriceTrack context:any labels:c-any,o-view,ot-schema,on-PrStandardPriceTrack,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrStandardPriceTrack
CREATE OR ALTER VIEW dbo.PrStandardPriceTrack AS
SELECT  PrivProd.Id, PrivProd.HdPendingChanges, PrivProd.HdPendingSubChanges, PrivProd.HdVersionNo, PrivProd.HdCreateDate, PrivProd.HdCreator, PrivProd.HdChangeDate, PrivProd.HdChangeUser, PrivProd.HdEditStamp, PrivProd.HdProcessId, PrivProd.HdStatusFlag, PrivProd.HdNoUpdateFlag, PrivProd.HdTriggerControl,
PrivProd.ProductId, PrivProd.ProductNo, CurrReg.Id AS CurrRegId, CurrReg.RegionId, CurrReg.Currency AS Curr, PrivComp.Id AS CompId, 
               PrivComp.PrivateComponentNo, PrivComp.PrivateCompTypeId, PrivComp.DefaultValue AS Limit, PrivComp.PriorityOfInterestCalculation AS Prio, 
               Price.ValidFrom, Price.ValidTo, Price.InterestRate, Price.CommissionRate, Price.ProvisionRate, Price.State, 
               dbo.PrPrivateCompPrice.StandardPriceNo
FROM  dbo.PrPrivate PrivProd INNER JOIN
               dbo.PrPrivateCurrRegion CurrReg ON PrivProd.ProductNo = CurrReg.ProductNo INNER JOIN
               dbo.PrPrivateComponent PrivComp ON CurrReg.Id = PrivComp.PrivateCurrRegionId INNER JOIN
               dbo.PrPrivateCompType CompType ON PrivComp.PrivateCompTypeId = CompType.Id INNER JOIN
               dbo.PrComposedPrice Price ON PrivComp.PrivateComponentNo = Price.PrivateComponentNo INNER JOIN
               dbo.PrPrivateCompPrice ON PrivComp.PrivateComponentNo = dbo.PrPrivateCompPrice.PrivateComponentNo INNER JOIN
               dbo.PrStandardPriceType ON dbo.PrPrivateCompPrice.StandardPriceNo = dbo.PrStandardPriceType.StandardPriceNo

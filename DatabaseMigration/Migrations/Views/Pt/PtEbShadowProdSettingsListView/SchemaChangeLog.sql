--liquibase formatted sql

--changeset system:create-alter-view-PtEbShadowProdSettingsListView context:any labels:c-any,o-view,ot-schema,on-PtEbShadowProdSettingsListView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtEbShadowProdSettingsListView
CREATE OR ALTER VIEW dbo.PtEbShadowProdSettingsListView AS
select 
	PtShadowProduct.Id as ShadowProductId,
	PtShadowProductSettings.IsVisibleForEBanking as IsVisibleForEBanking,
                PtShadowProductSettings.IsAbsoluteTrendActive as IsAbsoluteTrendActive,
                PtShadowProductSettings.IsPerformanceActive as IsPerformanceActive,
	PtEbProductCategory.Id as CategoryId,
	AsText.TextShort as CategoryAsText,
	AsText.LanguageNo as LanguageNo
from
	PtShadowProduct
	inner join PtShadowProductSettings on PtShadowProduct.Id = PtShadowProductSettings.ShadowProductId
	left outer join PtEbShadowProductInfo on PtEbShadowProductInfo.ShadowProductId = PtShadowProduct.Id
	left outer join PtEbProductCategory on PtEbProductCategory.Id = PtEbShadowProductInfo.ProductCategoryId
	left outer join AsText on AsText.MasterId = PtEbProductCategory.Id
where 
	PtShadowProduct.HdVersionNo BETWEEN 1 AND 999999998 

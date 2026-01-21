--liquibase formatted sql

--changeset system:create-alter-view-PrProductPriceOverview context:any labels:c-any,o-view,ot-schema,on-PrProductPriceOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrProductPriceOverview
CREATE OR ALTER VIEW dbo.PrProductPriceOverview AS
SELECT
	PrivProd.ProductId,
	PrivProd.ProductNo,
	PrivPrText.TextShort AS ProdText,
	PrivPrText.LanguageNo,
	CurrReg.Id AS CurrRegId,
	CurrReg.RegionId,
	CurrReg.Currency AS Curr,
	PrRegText.TextShort AS RegText,
	PrivComp.Id AS CompId,
	PrivComp.PrivateComponentNo,
	PrivComp.PrivateCompTypeId,
	PrivComp.DefaultValue AS Limit,
	PrivComp.PriorityOfInterestCalculation As Prio,
	PrCompTypeText.TextShort AS CompTypeText,
	Price.ValidFrom,
	Price.ValidTo,
	Price.InterestRate,
	Price.CommissionRate,
	Price.ProvisionRate,
	Price.State
FROM
	PrPrivate PrivProd,
	AsText PrivPrText,
	PrPrivateCurrRegion CurrReg,
	PrRegion Region,
	AsText PrRegText,
	PrPrivateComponent PrivComp,
	PrPrivateCompType CompType,
	AsText PrCompTypeText,
	PrComposedPrice Price
WHERE
	    PrivPrText.MasterId = PrivProd.Id
	AND PrivProd.ProductNo = CurrReg.ProductNo
	AND Region.Id = CurrReg.RegionId
	AND PrRegText.MasterId = Region.Id
	AND CurrReg.Id = PrivComp.PrivateCurrRegionId
	AND CompType.Id = PrivComp.PrivateCompTypeId
	AND PrCompTypeText.MasterId = CompType.Id
	AND PrivComp.PrivateComponentNo = Price.PrivateComponentNo
	AND PrivPrText.LanguageNo = PrRegText.LanguageNo
	AND PrivPrText.LanguageNo = PrCompTypeText.LanguageNo


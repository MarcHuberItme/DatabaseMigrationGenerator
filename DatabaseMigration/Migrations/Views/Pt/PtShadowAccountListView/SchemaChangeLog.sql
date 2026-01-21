--liquibase formatted sql

--changeset system:create-alter-view-PtShadowAccountListView context:any labels:c-any,o-view,ot-schema,on-PtShadowAccountListView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtShadowAccountListView
CREATE OR ALTER VIEW dbo.PtShadowAccountListView AS
select      
	PtShadowAccount.Id as 'ShadowAccountId',
	PtShadowAccount.TotalValue as 'Balance',
	PtShadowAccount.Currency as 'Currency',
	PtShadowAccount.AccountNoEdited as 'ShadowAccountNoEdited',

	PtShadowProduct.Id as 'ShadowProductId',
	PtShadowProduct.ProfileName as 'ProfileName',

	PtBase.Id as 'PartnerId',
	PtBase.PartnerNo as 'PartnerNo',
	PtBase.PartnerNoEdited as 'PartnerNoEdited',
	PtBase.PartnerNoText as 'PartnerNoText',
	PtAddress.NameLine as 'OwnerNameLine',
	PtAddress.ReportAdrLine as 'ReportAdrLine',
	
	PtShadowAccount.Id as 'AccountId',
	PtShadowAccount.AccountNo as 'AccountNo', 
	PtShadowAccount.AccountNoEdited as 'AccountNoEdited', 
	PtShadowAccount.CustomerReference as 'CustomerReference',
	PtShadowProduct.FinstarProductNo as 'ProductNo',
                PrPrivate.Id as 'ProductId',
                PtShadowAccount.TerminationDate as 'TerminationDate'
from            
	dbo.PtShadowAccount 
	inner join PtShadowProduct ON PtShadowAccount.ShadowProductNo = PtShadowProduct.ShadowProductNo 
	inner join PtPortfolio ON PtShadowAccount.PortfolioId = PtPortfolio.Id 
	inner join PrPrivate on PrPrivate.ProductNo = PtShadowProduct.FinstarProductNo
	inner join PtBase on PtBase.Id = PtPortfolio.PartnerId
	left outer join PtAddress on PtAddress.PartnerId = PtBase.Id 
where       
	(PtShadowAccount.HdVersionNo BETWEEN 1 AND 999999998) 
	AND (PtPortfolio.HdVersionNo BETWEEN 1 AND 999999998) 
	AND (PtShadowProduct.HdVersionNo BETWEEN 1 AND 999999998)
	AND PtAddress.AddressTypeNo = 11 
	AND PtAddress.HdVersionNo BETWEEN 1 AND 999999998
	AND PrPrivate.HdVersionNo BETWEEN 1 AND 999999998
	AND PtBase.HdVersionNo BETWEEN 1 AND 999999998

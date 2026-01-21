--liquibase formatted sql

--changeset system:create-alter-view-PtAccountReferenceListView context:any labels:c-any,o-view,ot-schema,on-PtAccountReferenceListView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountReferenceListView
CREATE OR ALTER VIEW dbo.PtAccountReferenceListView AS
select
	ab.Id as 'AccountId',
	ab.PortfolioId,
	ab.AccountNo, -- dec 11
	ab.AccountNoText, -- nv 20
	ab.AccountNoEdited, -- nv 20
	ab.AccountNoIbanElect, -- nv 21
	ab.AccountNoIbanForm, -- nv 31
	ab.QrIban as 'AccountNoQrIbanElect', -- nv 21
	ab.QrIbanForm as 'AccountNoQrIbanForm', -- nv 31
	ab.CustomerReference as 'AccountCustomerReference', -- nv 100
	ab.OpeningDate,
	ab.TerminationDate,
	
	pref.Currency as 'ProductReferenceCurrency',
	pref.Id as 'ProductReferenceId',

	prod.Id as 'PrivateProductId',
	prod.ProductId as 'ProductId',
	prod.ProductNo, -- int
	prod.ProductClass,
	prod.ProductNameTranslationKey


from PtAccountBase ab
left outer join PrReference pref on pref.AccountId = ab.Id and pref.HdVersionNo < 999999999
left outer join PrPrivateReferenceView prod on prod.ProductId = pref.ProductId
where ab.HdVersionNo < 999999999

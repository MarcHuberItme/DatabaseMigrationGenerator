--liquibase formatted sql

--changeset system:create-alter-view-PtAccountHierarchyView context:any labels:c-any,o-view,ot-schema,on-PtAccountHierarchyView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountHierarchyView
CREATE OR ALTER VIEW dbo.PtAccountHierarchyView AS
select
	partner.Id as 'PartnerId',
	partner.PartnerNo, -- decimal 8
	partner.PartnerNoText, -- nv 8
	partner.PartnerNoEdited, -- nv 10

	port.Id as 'PortfolioId',
	port.PortfolioNo, -- dec 11
	port.PortfolioNoText, -- nv 13
	port.PortfolioNoEdited, -- nv 20
	port.CustomerReference as 'PortfolioCustomerReference', -- nv 100
	port.Currency as 'PortfolioCurrency', -- refers to CyBase.Symbol, type currency symbol, char 3
	
	portt.Id as 'PortfolioTypeId',
	portt.PortfolioTypeNo, -- int
	portfolioGroup.GroupLabel as 'PortfolioClass',
	porttText.TextLong as 'PortfolioTypeTranslationKey',

	ab.AccountId,
	ab.AccountNo, -- dec 11
	ab.AccountNoText, -- nv 20
	ab.AccountNoEdited, -- nv 20
	ab.AccountNoIbanElect, -- nv 21
	ab.AccountNoIbanForm, -- nv 31
	ab.AccountCustomerReference, -- nv 100
	ab.OpeningDate,
	ab.TerminationDate,
	
	ab.ProductReferenceCurrency,
	ab.ProductReferenceId,

	ab.PrivateProductId,
	ab.ProductId,
	ab.ProductNo, -- int
	ab.ProductClass,
	ab.ProductNameTranslationKey

from PtBase partner
left outer join PtPortfolio port on port.PartnerId = partner.Id and port.HdVersionNo < 999999999
left outer join PtPortfolioType portt on portt.PortfolioTypeNo = port.PortfolioTypeNo
left outer join AsGroupView portfolioGroup on portfolioGroup.GroupMemberTargetRowId = portt.Id and portfolioGroup.GroupTypeLabel = 'Portfolio Classes'
left outer join AsText porttText on porttText.MasterId = portt.Id and porttText.MasterTableName = 'PtPortfolioType' and porttText.LanguageNo = 1 -- should be 0 or 99 later for the real translation key.
left outer join PtAccountReferenceListView ab on ab.PortfolioId = port.Id

where partner.HdVersionNo < 999999999

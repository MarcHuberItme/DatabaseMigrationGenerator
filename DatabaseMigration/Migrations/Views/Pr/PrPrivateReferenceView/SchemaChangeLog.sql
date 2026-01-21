--liquibase formatted sql

--changeset system:create-alter-view-PrPrivateReferenceView context:any labels:c-any,o-view,ot-schema,on-PrPrivateReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPrivateReferenceView
CREATE OR ALTER VIEW dbo.PrPrivateReferenceView AS
select
	pr.Id as Id,
	pr.ProductId as ProductId,
	pr.ProductNo as ProductNo,
	prodText.TextLong as 'ProductNameTranslationKey',
	g.GroupLabel as 'ProductClass'
from PrPrivate pr
left outer join AsText prodText on prodText.MasterId = pr.Id and prodText.MasterTableName = 'PrPrivate' and prodText.LanguageNo = 1 -- should be 0 or 99 later for the real
left outer join AsGroupView g on g.GroupMemberTargetRowId = pr.Id and g.GroupTypeLabel = 'Product Classes' 
where pr.HdVersionNo BETWEEN 0 and 999999999

--liquibase formatted sql

--changeset system:create-alter-view-PrPrivateCcmGroupAssignView context:any labels:c-any,o-view,ot-schema,on-PrPrivateCcmGroupAssignView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPrivateCcmGroupAssignView
CREATE OR ALTER VIEW dbo.PrPrivateCcmGroupAssignView AS


select TOP 100 PERCENT Pr.Id, Pr.ProductNo, Pr.ProductId, Gl.Name AS GroupName
from AsGroupMember Gm
inner join AsGroupType AS GT ON Gm.GroupTypeId = GT.Id
inner join AsGroupTypeLabel AS Gtl ON GT.Id = Gtl.GroupTypeId
inner join AsGroup AS G ON G.Id = Gm.GroupId
inner join AsGroupLabel AS Gl ON G.Id = Gl.GroupId
inner join PrPrivate AS Pr ON Gm.TargetRowId = Pr.Id
WHERE Gtl.Name = 'ConsumerCreditProducts'
AND Gl.Name IN ('CcmIncludeBalance', 'CcmNoMonitoring', 'CcmMonitoring')
AND Gm.HdVersionNo < 999999999


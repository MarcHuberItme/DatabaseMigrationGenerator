--liquibase formatted sql

--changeset system:create-alter-view-PrPublicListingOrderView context:any labels:c-any,o-view,ot-schema,on-PrPublicListingOrderView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicListingOrderView
CREATE OR ALTER VIEW dbo.PrPublicListingOrderView AS
SELECT TOP 100 PERCENT
                PLI.Id, 
    	PLI.HdPendingChanges,
    	PLI.HdPendingSubChanges, 
    	PLI.HdVersionNo, 
	PLI.PublicId, 
	PLI.Currency, 
	PLI.ListingStatusNo, 
	PTP.ShortName + ' ' + PLI.Currency AS ListingDescription,
	PTP.CountryCode, 
	PTP.ShortName, 
	PTP.Name, 
	PTP.Town, 
	PTP.SelPrioInt, 
	PTP.SelPrioEb,
                PLI.PublicTradingPlaceId,
                PLI.OrderStatusNoSx 
FROM 	PrPublicTradingPlace PTP 
JOIN PrPublicListing PLI ON PLI.PublicTradingPlaceId = PTP.Id 
JOIN PrPublicListingStatus on PrPublicListingStatus.ListingStatusNo = PLI.ListingStatusNo
and PrPublicListingStatus.HdVersionNo between 1 and 999999998
WHERE	(PTP.SelPrioInt IS NOT NULL OR PTP.SelPrioEb IS NOT NULL)
and (exists(
select * from asgroupmember 
JOIN AsGroupType on AsGroupType.Id = AsGroupMember.GroupTypeId
and AsGroupType.HdVersionNo between 1 and 999999998
JOIN AsGroupTypeLabel on AsGroupTypeLabel.GroupTypeId = AsGroupType.Id
and AsGroupTypeLabel.Name = 'ListingStatus'
and AsGroupTypeLabel.HdVersionNo between 1 and 999999998
JOIN AsGroup on AsGroup.id = asgroupmember.groupid
and AsGroup.HdVersionNo between 1 and 999999998
JOIN AsGroupLabel on AsGroupLabel.GroupId = AsGroup.id
and AsGroupLabel.Name = 'Listed'
and AsGroupLabel.HdVersionNo between 1 and 999999998
WHERE AsGroupMember.TargetRowId = PrPublicListingStatus.Id) and 
PLI.OrderStatusNoSx IS NULL) or
(PLI.OrderStatusNoSx = 1 or PLI.OrderStatusNoSx = 10)


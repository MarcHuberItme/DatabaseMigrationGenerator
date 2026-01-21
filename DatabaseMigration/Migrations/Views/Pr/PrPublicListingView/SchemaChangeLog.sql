--liquibase formatted sql

--changeset system:create-alter-view-PrPublicListingView context:any labels:c-any,o-view,ot-schema,on-PrPublicListingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicListingView
CREATE OR ALTER VIEW dbo.PrPublicListingView AS
SELECT TOP 100 PERCENT
                PLI.Id, 
    	PLI.HdPendingChanges,
    	PLI.HdPendingSubChanges, 
    	PLI.HdVersionNo, 
	PLI.PublicId, 
	PLI.Currency, 
	PLI.ListingStatusNo, 
                PLI.PublicTradingPlaceId,
                ISNULL(PLI.PriceUnitNo, PUB.UnitNo) AS UnitNo,
	PTP.ShortName + ' ' + PLI.Currency AS ListingDescription,
	PTP.CountryCode, 
	PTP.ShortName, 
	PTP.Name, 
	PTP.Town, 
	PTP.SelPrioInt, 
	PTP.SelPrioEb
FROM 	PrPublicTradingPlace PTP 
JOIN	PrPublicListing PLI ON PLI.PublicTradingPlaceId = PTP.Id 
JOIN	PrPublic PUB ON PUB.Id = PLI.PublicId
WHERE	PTP.SelPrioInt IS NOT NULL OR PTP.SelPrioEb IS NOT NULL


--liquibase formatted sql

--changeset system:create-alter-view-PrPublicListingSymbolView context:any labels:c-any,o-view,ot-schema,on-PrPublicListingSymbolView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicListingSymbolView
CREATE OR ALTER VIEW dbo.PrPublicListingSymbolView AS
SELECT 	TOP 100 PERCENT
	PLS.Id, 
	PLS.HdCreateDate, PLS.HdCreator, 
	PLS.HdChangeDate, PLS.HdChangeUser, 
	PLS.HdEditStamp, PLS.HdVersionNo, 
	PLS.HdProcessId, PLS.HdStatusFlag, 
	PLS.HdNoUpdateFlag, PLS.HdPendingChanges, 
	PLS.HdPendingSubChanges, PLS.HdTriggerControl, 
	PLI.PublicId,
	TPL.VdfInstituteSymbol,
	TPL.ShortName,
	PLS.ListingScheme, 
	PLS.ListingSymbol, 
	PLS.UseAsIdentification 
FROM 	PrPublicListingSymbol PLS
JOIN	PrPublicListing PLI ON PLI.Id = PLS.PublicListingId
JOIN	PrPublicTradingPlace TPL ON TPL.Id = PLI.PublicTradingPlaceId

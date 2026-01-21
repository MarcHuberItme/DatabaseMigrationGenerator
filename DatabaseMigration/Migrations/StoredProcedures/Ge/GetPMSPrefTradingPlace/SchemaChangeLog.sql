--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPrefTradingPlace context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPrefTradingPlace,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPrefTradingPlace
CREATE OR ALTER PROCEDURE dbo.GetPMSPrefTradingPlace
@PublicId UniqueIdentifier
As
DECLARE @PrefVdfInstituteSymbol varchar(12)

Select top 1 @PrefVdfInstituteSymbol = PrPublicTradingPlace .VdfInstituteSymbol  from PrPublicListing 
inner join PrPublictradingPlace on  PrPublicListing.PublicTradingPlaceId = PrPublicTradingPlace.Id and VdfInstituteSymbol is not  null and SelPrioInt is not null
Where PublicId = @PublicId
and PrPublicListing.HdVersionNo between 1 and 99999998
order by SelPrioInt

Select @PrefVdfInstituteSymbol  as PrefVdfInstituteSymbol 

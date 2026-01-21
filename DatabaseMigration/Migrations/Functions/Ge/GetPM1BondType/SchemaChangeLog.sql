--liquibase formatted sql

--changeset system:create-alter-function-GetPM1BondType context:any labels:c-any,o-function,ot-schema,on-GetPM1BondType,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetPM1BondType
CREATE OR ALTER FUNCTION dbo.GetPM1BondType
(
@PublicId uniqueidentifier
)
RETURNS tinyint
AS BEGIN
RETURN (
Select 
case 
                when ((InstrumentTypeNo = 1)or(InstrumentTypeNo =8)) and (PrPublic.AssetTypeCalculated = 2) and  (PrPublic.RedemptionCode = 2) then 5 -- Perpetual
	when SecurityType = 'V' then 1		-- Convertible
	when SecurityType = 'L' then 2      -- Floating Rate
	when (PrPublic.SecurityType = '0') then 8 -- Straight
	when (PrPublic.InstrumentTypeNo = '1' and PrPublic.ActualInterest is Null) then 10 -- Zero Bond
	when (IsNull(PrPublicListing.IsFlat,0)=1) then 11 -- Flat Notation
	else 20
end as BondType
from PrPublic 
left outer join PrPublicListing on PrPublicListing.PublicTradingPlaceId = PrPublic.MajorTradingPlaceId and PrPublicListing.PublicId = PrPublic.Id and PrPublicListing.HDVersionNo between 1 and 999999998
Where PrPublic.Id = @PublicId)
END


--liquibase formatted sql

--changeset system:create-alter-procedure-VaGetLatestPriceByCurrency context:any labels:c-any,o-stored-procedure,ot-schema,on-VaGetLatestPriceByCurrency,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaGetLatestPriceByCurrency
CREATE OR ALTER PROCEDURE dbo.VaGetLatestPriceByCurrency
@PublicId uniqueidentifier,
@Currency char(3)
AS
SELECT Top 1 PP.Price, PP.LogicalPriceDate,PP.PriceDate, PP.PriceQuoteType, PP.PublicTradingPlaceId, 
               CAST( DATEDIFF ( d , isnull(PP.PriceDate, PP.LogicalPriceDate) , CAST(Getdate() As DateTime) ) + 
            Case PP.PublicTradingPlaceId  
            WHEN P.MajorTradingPlaceId THEN 0 
            Else PPP.TradingPlace 
            END + 
            Case PP.Currency 
            WHEN isnull(ISNULL(P.ExposureCurrency, IsNull(P.NominalCurrency,'CHF')), PP.Currency) THEN 0 
            Else PPP.Currency 
            End 
            + IsNull(PPTP.Delay,0)+ IsNull(PPST.Delay,0) As DECIMAL(10,4)) As Delay, 
            isnull(PP.PriceStaticTypeNo,2) As PriceStatisticTypeNo, Isnull(L.OrderStatusNoSx,10) As OrderStatusNoSx,
            P.PhysicalUnitTypeNo, PP.PriceRepUnitAmount, PP.PriceUnit
        FROM PrPublic P 
        Inner Join PrPublicPrice PP on PP.PublicId = P.Id 
        Inner Join PrPublicTradingPlace PTP on PTP.Id = PP.PublicTradingPlaceId AND PTP.HdVersionNo Between 1 AND 999999998 
        Left Outer Join PrPublicListing L on L.PublicId = P.Id and L.PublicTradingPlaceId = PP.PublicTradingPlaceId and L.HdVersionNo  between 1 and 999999998 
        Inner Join prPublicPriceType PPT on PPT.PriceTypeNo = PP.PriceTypeNo AND PPT.HdVersionNo Between 1 AND 999999998 
        Inner Join prPublicSecurityType PST on P.SecurityType = PST.SecurityType 
        Inner Join prPublicPricePenalty PPP on PPP.PenaltySetNo = PST.PenaltySetNo 
        Inner Join prPublicPriceTypePenalty PPTP on PPT.PriceTypeNo = PPTP.PriceTypeNo AND PPTP.PenaltySetNo =  PPP.PenaltySetNo AND PPTP.HdVersionNo Between 1 AND 999999998 
            AND PPTP.Delay is not Null 
        Left Outer Join prPublicPriceStaticType PPST on PPST.PriceStaticTypeNo = PP.PriceStaticTypeNo 
         WHERE P.Id = @PublicId 
         and   PP.Currency = @Currency 
         Order by L.OrderStatusNoSx ASC, PP.PriceStaticTypeNo, Delay ASC, PP.PriceDate DESC, PP.LogicalPricedate DESC


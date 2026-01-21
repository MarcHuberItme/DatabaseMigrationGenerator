--liquibase formatted sql

--changeset system:create-alter-procedure-VaRateWithReferenceId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRateWithReferenceId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRateWithReferenceId
CREATE OR ALTER PROCEDURE dbo.VaRateWithReferenceId
--Store Procedure: VaRateWithReferenceId

@DateDiff integer,
@ValuationDate Datetime,
@PublicTradingPlaceId uniqueidentifier,
@ReferenceId uniqueidentifier

AS
/*
	Declare @PublicTradingPlaceId AS uniqueidentifier
	Declare @ReferenceId AS uniqueidentifier
	Declare @DateDiff AS Integer	
	Declare @ValuationDate As SmallDateTime

	Set @ValuationDate = getdate() -- '20080626'
	Set @PublicTradingPlaceId = NULL-- '{3DDD738C-761A-4EBC-BEDD-72F2F7AB1568}'
	Set @ReferenceId ='28F5CD33-CDC2-4BCC-9E6F-B99C6811570D'--'{D607ECF0-9D2C-4FE7-9090-1F160745A0A9}'
	Set @DateDiff = -3	
*/

Set DATEFIRST 7

If @DateDiff is null 
	BEGIN 
		Set @DateDiff = -1
	END
If 	@DateDiff > 0 	
	BEGIN
		Set @DateDiff = @DateDiff - ( 2 * @DateDiff )
	END

If @ValuationDate is null 
	BEGIN
		Set @ValuationDate = getdate()
	END

SELECT TOP 1 PP.ID, PP.Currency, PP.Price, PP.LogicalPriceDate, PP.PriceDate,   
	CAST(CAST(@ValuationDate As DateTime) - PP.LogicalPriceDate +

	Case WHEN CAST(@ValuationDate As DateTime) - PP.LogicalPriceDate > 2 THEN
		Case DATEPART(weekday, PP.LogicalPriceDate)
		WHEN 6 THEN -2
		ELSE 0 
		END
	ELSE 0
	END +
	    
	Case PP.PublicTradingPlaceId        
	WHEN IsNull(@PublicTradingPlaceId, IsNull((Select Top 1 PH.MajorTradingPlaceId From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @ValuationDate Order by FromDate DESC)  , PP.PublicTradingPlaceId)) THEN 0        
	ELSE PPP.TradingPlace   
	END +    
	
	CASE PP.Currency
	WHEN isnull((Select Top 1 PH.NominalCurrency From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @ValuationDate Order by FromDate DESC)  , PP.Currency) THEN 0          
	ELSE PPP.Currency   
	END 
	+ PPTP.Delay
	+ IsNull(PPST.Delay,0)
	As DECIMAL(10,4)) 
	As Delay

FROM PrReference REF 
	Inner Join PrBase B on B.Id = REF.ProductId
	Inner Join PrPublic P on P.ProductId = B.Id
	Inner Join PrPublicPrice PP on PP.PublicId = P.Id AND PP.HdVersionNo Between 1 AND 999999998
	Inner Join PrPublicTradingPlace PTP on PTP.Id = PP.PublicTradingPlaceId AND PTP.HdVersionNo Between 1 AND 999999998  
	Inner Join prPublicPriceType PPT on PPT.PriceTypeNo = PP.PriceTypeNo AND PPT.HdVersionNo Between 1 AND 999999998   
	Inner Join prPublicSecurityType PST on P.SecurityType = PST.SecurityType
	Inner Join prPublicPricePenalty PPP on PPP.PenaltySetNo = PST.PenaltySetNo
	Inner Join prPublicPriceTypePenalty PPTP on PPT.PriceTypeNo = PPTP.PriceTypeNo AND PPTP.PenaltySetNo =  PPP.PenaltySetNo
	Left Outer Join prPublicPriceStaticType PPST on PPST.PriceStaticTypeNo = PP.PriceStaticTypeNo
	
WHERE REF.Id = @ReferenceId
	AND PP.LogicalPriceDate <= @ValuationDate
	AND (PP.LogicalPriceDate > Dateadd(WW,@DateDiff,@ValuationDate)
	OR  PP.PriceStaticTypeNo is not null)
	AND PP.Price is not Null
Order by Coalesce(PP.PriceStaticTypeNo,0), Delay ASC, PP.LogicalPriceDate DESC, PP.PriceDate DESC
